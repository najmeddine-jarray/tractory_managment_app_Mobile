import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractory/app/modules/tractor/tractor_controller.dart';
import 'package:tractory/utils/constants.dart';
import '../../data/models/tractor_Model.dart';
import '../../data/services/tractor_Services.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage

class TractorPage extends GetView<TractorController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    final TextEditingController _filterController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Tractors',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Constants.azreg,
        toolbarHeight: 50,
        actions: [
          IconButton(
              onPressed: () => controller.fetchTractors(),
              icon: Icon(
                Icons.refresh_outlined,
              ))
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          //  else if (controller.errorMessage.value.isNotEmpty) {
          //   return Center(
          //       child: Text(controller.errorMessage.value,
          //           style: TextStyle(color: Colors.red)));
          // }

          else {
            return Column(
              children: [
                TextFormField(
                  controller: _filterController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    controller.filterTractors(value.toLowerCase());
                  },
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Filter by Tractor name or type',
                    prefixIcon: const Icon(Icons.search_outlined, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                // Show "No Results" message if no tractors are found
                if (controller.filteredTractors.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text('No Results',
                          style: TextStyle(color: Colors.grey, fontSize: 18)),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredTractors.length,
                      itemBuilder: (context, index) {
                        final tractor = controller.filteredTractors[index];
                        return Card(
                          elevation: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10.0),
                            title: Text("${tractor.id} | ${tractor.name}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "${tractor.image}",
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    height: 65, // Adjust as needed
                                    width: 65, // Adjust as needed
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Type: ${tractor.type}'),
                                      Text('Power: ${tractor.power}'),
                                      Text(
                                          'Status: ${tractor.maintenanceStatus}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon:
                                      Icon(Icons.edit, color: Constants.azreg),
                                  onPressed: () => _showTractorDialog(context,
                                      tractor: tractor),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => Get.defaultDialog(
                                    title: 'Delete Tractor',
                                    middleText:
                                        'Are you sure you want to delete this tractor?',
                                    confirm: ElevatedButton(
                                      onPressed: () {
                                        controller.deleteTractor(tractor.id!);
                                        Get.back(); // Close dialog
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      child: Text(
                                        'Delete',
                                      ),
                                    ),
                                    cancel: TextButton(
                                      onPressed: () =>
                                          Get.back(), // Close dialog
                                      child: Text(
                                        'Cancel',
                                      ),
                                    ),
                                    titlePadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    contentPadding: EdgeInsets.all(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTractorDialog(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Constants.azreg,
        tooltip: 'Add Tractor',
      ),
    );
  }

  void _showTractorDialog(BuildContext context, {Tractor? tractor}) {
    final isEdit = tractor != null;

    final typeController =
        TextEditingController(text: isEdit ? tractor!.type : '');
    final nameController =
        TextEditingController(text: isEdit ? tractor!.name : '');
    final imageController =
        TextEditingController(text: isEdit ? tractor!.image : '');
    final powerController =
        TextEditingController(text: isEdit ? tractor!.power.toString() : '');
    // final hoursUsedController = TextEditingController(
    //     text: isEdit ? tractor!.hoursUsed.toString() : '');
    final maintenanceStatusController =
        TextEditingController(text: isEdit ? tractor!.maintenanceStatus : '');
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    Get.defaultDialog(
      title: isEdit ? 'Edit Tractor' : 'Add Tractor',
      titlePadding: EdgeInsets.symmetric(vertical: 10),
      contentPadding: EdgeInsets.all(20),
      radius: 10,
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value:
                    typeController.text.isNotEmpty ? typeController.text : null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  hintText: "Type",
                  prefixIcon: const Icon(Icons.category, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: [
                  DropdownMenuItem(child: Text('Tractor'), value: 'Tractor'),
                  DropdownMenuItem(
                      child: Text('Harvester'), value: 'Harvester'),
                  DropdownMenuItem(
                      child: Text('Bulldozer'), value: 'Bulldozer'),
                ],
                onChanged: (value) => typeController.text = value!,
                validator: (value) =>
                    value == null ? 'Please select a type' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  hintText: "Name",
                  prefixIcon: const Icon(Icons.drive_eta, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: imageController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  hintText: "Image URL",
                  prefixIcon: const Icon(Icons.image, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: powerController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  hintText: "Power",
                  prefixIcon: const Icon(Icons.power, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the power';
                  }
                  return null;
                },
              ),
              // SizedBox(height: 10),
              // TextFormField(
              //   controller: hoursUsedController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.blueGrey.withOpacity(.1),
              //     hintText: "Hours Used",
              //     prefixIcon: const Icon(Icons.access_time, size: 20),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(15),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter hours used';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: maintenanceStatusController.text.isNotEmpty
                    ? maintenanceStatusController.text
                    : null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  hintText: "Maintenance Status",
                  prefixIcon: const Icon(Icons.build, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: [
                  DropdownMenuItem(child: Text('Good'), value: 'Good'),
                  DropdownMenuItem(
                      child: Text('Needs Service'), value: 'Needs Service'),
                  DropdownMenuItem(
                      child: Text('Under Repair'), value: 'Under Repair'),
                ],
                onChanged: (value) => maintenanceStatusController.text = value!,
                validator: (value) =>
                    value == null ? 'Please select a maintenance status' : null,
              ),
            ],
          ),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final newTractor = Tractor(
              id: isEdit ? tractor!.id : null,
              type: typeController.text,
              name: nameController.text,
              image: imageController.text,
              power: int.parse(powerController.text),
              // hoursUsed: double.parse(hoursUsedController.text),
              maintenanceStatus: maintenanceStatusController.text,
            );
            if (isEdit) {
              controller.updateTractor(newTractor);
            } else {
              controller.addTractor(newTractor);
            }
            Get.back(); // Close dialog
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Constants.azreg : Constants.ktiba),
        child: Text(
          isEdit ? 'Update Tractor' : 'Add Tractor',
          style: TextStyle(
              color: isDark ? Constants.secondaryColor : Constants.azreg),
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(), // Close dialog
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
