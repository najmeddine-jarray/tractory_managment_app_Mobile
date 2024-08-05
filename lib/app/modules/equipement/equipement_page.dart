import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractory/app/modules/equipement/equipement_controller.dart';
import 'package:tractory/utils/constants.dart';
import '../../data/models/equipment_Model.dart';

class EquipmentPage extends GetView<EquipmentController> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _filterController = TextEditingController();

  final List<String> _types = ["محراث", "حصادة", "مضخة دواء", "زراعة"];
  final List<String> _maintenanceStatuses = [
    "Good",
    "Needs Service",
    "Under Repair"
  ];

  EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Equipments',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Constants.azreg,
        toolbarHeight: 50,
        actions: [
          IconButton(
              onPressed: () => controller.fetchEquipment(),
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
          } else if (controller.errorMessage.value.isNotEmpty) {
            return Center(
                child: Text(controller.errorMessage.value,
                    style: TextStyle(color: Colors.red)));
          } else {
            return Column(
              children: [
                TextFormField(
                  controller: _filterController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    controller.filterEquipment(value.toLowerCase());
                  },
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Filter by Equipment name or type',
                    prefixIcon: const Icon(Icons.search_outlined, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                // Show "No Results" message if no equipment is found
                if (controller.filteredEquipment.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text('No Results',
                          style: TextStyle(color: Colors.grey, fontSize: 18)),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredEquipment.length,
                      itemBuilder: (context, index) {
                        final equipment = controller.filteredEquipment[index];
                        return Card(
                          elevation: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10.0),
                            title: Text('${equipment.id} | ${equipment.name}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: "${equipment.image}",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Type: ${equipment.type}'),
                                    Text(
                                        'Price: ${equipment.priceHours} Dinar'),
                                    Text(
                                        'Status: ${equipment.maintenanceStatus}'),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  color: Constants.azreg,
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _showEquipmentDialog(context,
                                      equipment: equipment),
                                ),
                                IconButton(
                                  color: Colors.red,
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      _showDeleteConfirmationDialog(
                                          context, equipment.id!),
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
        onPressed: () => _showEquipmentDialog(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Constants.azreg,
        tooltip: 'Add Equipment',
      ),
    );
  }

  void _showEquipmentDialog(BuildContext context, {Equipment? equipment}) {
    final isEdit = equipment != null;
    final _selectedType = isEdit ? equipment!.type : _types.first;
    final _selectedStatus =
        isEdit ? equipment!.maintenanceStatus : _maintenanceStatuses.first;

    final typeController =
        TextEditingController(text: isEdit ? equipment!.type : '');
    final nameController =
        TextEditingController(text: isEdit ? equipment!.name : '');
    final imageController =
        TextEditingController(text: isEdit ? equipment!.image : '');
    // final hoursUsedController = TextEditingController(
    //     text: isEdit ? equipment!.hoursUsed.toString() : '');
    final priceHoursController = TextEditingController(
        text: isEdit ? equipment!.priceHours.toString() : '');
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    Get.defaultDialog(
      title: isEdit ? 'Edit Equipment' : 'Add Equipment',
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: _types.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Do nothing
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: imageController,
                  decoration: InputDecoration(
                    hintText: 'Image URL',
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter image URL';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                // TextFormField(
                //   controller: hoursUsedController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(
                //     hintText: 'Hours Used',
                //     filled: true,
                //     fillColor: Colors.blueGrey.withOpacity(.1),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter hours used';
                //     }
                //     if (int.tryParse(value) == null) {
                //       return 'Please enter a valid number';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 10),
                TextFormField(
                  controller: priceHoursController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: _maintenanceStatuses.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Do nothing
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a maintenance status';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            final newEquipment = Equipment(
              id: isEdit ? equipment!.id : null,
              type: _selectedType,
              name: nameController.text,
              image: imageController.text,
              // hoursUsed: int.parse(hoursUsedController.text),
              priceHours: double.parse(priceHoursController.text),
              maintenanceStatus: _selectedStatus,
            );
            if (isEdit) {
              controller.updateEquipment(newEquipment);
            } else {
              controller.addEquipment(newEquipment);
            }
            Get.back(); // Close dialog
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Constants.azreg : Constants.ktiba),
        child: Text(
          isEdit ? 'Update Equipment' : 'Add Equipment',
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
      titlePadding: EdgeInsets.symmetric(vertical: 20),
      contentPadding: EdgeInsets.all(20),
      radius: 10,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int id) {
    Get.defaultDialog(
      title: 'Confirm Delete',
      content: Text('Are you sure you want to delete this equipment?'),
      confirm: ElevatedButton(
        onPressed: () {
          controller.deleteEquipment(id);
          Get.back(); // Close dialog
        },
        child: Text('Delete'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(), // Close dialog
        child: Text(
          'Cancel',
        ),
      ),
      titlePadding: EdgeInsets.symmetric(vertical: 20),
      contentPadding: EdgeInsets.all(20),
      radius: 10,
    );
  }
}
