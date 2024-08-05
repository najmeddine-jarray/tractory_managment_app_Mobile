import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:tractory/app/data/models/client_Model.dart';
import 'package:tractory/app/data/models/equipment_Model.dart';
import 'package:tractory/app/data/models/tractor_Model.dart';
import 'package:tractory/utils/constants.dart';
import '../../data/models/rental_Model.dart';
import 'rental_controller.dart';

class RentalPage extends GetView<RentalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Rentals',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Constants.azreg,
        toolbarHeight: 50,
        actions: [
          IconButton(
              onPressed: () => controller.fetchAllData(),
              icon: Icon(
                Icons.refresh_outlined,
              ))
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              onChanged: (value) {
                controller.setFilterText(value);
              },
              decoration: InputDecoration(
                filled: true,
                hintText: 'Filter by Client, Tractor, or Equipment',
                prefixIcon: const Icon(Icons.search_outlined, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.filteredRentals.isEmpty) {
              return Center(child: Text('No results found'));
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredRentals.length,
                  itemBuilder: (context, index) {
                    final rental = controller.filteredRentals[index];
                    final clientName = controller.clientList
                        .firstWhere((client) => client.id == rental.clientId,
                            orElse: () =>
                                Client(name: '', phone: '', address: ''))
                        .name;
                    final tractorName = controller.tractorList
                        .firstWhere((tractor) => tractor.id == rental.tractorId,
                            orElse: () => Tractor(
                                name: '', type: '', image: '', power: 0))
                        .name;
                    final equipmentName = controller.equipmentList
                        .firstWhere(
                            (equipment) => equipment.id == rental.equipmentId,
                            orElse: () => Equipment(
                                name: '', type: '', image: '', priceHours: 0))
                        .name;

                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text('Rental ID: ${rental.id} |$clientName'),
                        subtitle: Text(
                            'Tractor: $tractorName\nEquipment: $equipmentName\nRental Date: ${DateFormat('MM-dd-yyyy').format(rental.rentalDate)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: Constants.azreg,
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _showRentalDialog(context, rental: rental),
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(Icons.delete),
                              onPressed: () => _showDeleteConfirmationDialog(
                                  context, rental.id!),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showRentalDialog(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Constants.azreg,
      ),
    );
  }

  void _showRentalDialog(BuildContext context, {Rental? rental}) {
    final isEdit = rental != null;

    final clientIdController =
        TextEditingController(text: isEdit ? rental!.clientId.toString() : '');
    final tractorIdController =
        TextEditingController(text: isEdit ? rental!.tractorId.toString() : '');
    final equipmentIdController = TextEditingController(
        text: isEdit ? rental!.equipmentId.toString() : '');
    final rentalDateController = TextEditingController(
        text:
            isEdit ? DateFormat('MM-dd-yyyy').format(rental!.rentalDate) : '');
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    Get.defaultDialog(
      title: isEdit ? 'Edit Rental' : 'Add Rental',
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              value: isEdit ? rental!.clientId : null,
              onChanged: (value) {
                clientIdController.text = value.toString();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey.withOpacity(.1),
                hintText: "Client",
                prefixIcon: Icon(
                  Icons.person,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              items: controller.clientList.map((client) {
                return DropdownMenuItem<int>(
                  value: client.id,
                  child: Text(client.name),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: isEdit ? rental!.tractorId : null,
              onChanged: (value) {
                tractorIdController.text = value.toString();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey.withOpacity(.1),
                hintText: "Tractor",
                prefixIcon: Icon(
                  Icons.agriculture,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              items: controller.tractorList.map((tractor) {
                return DropdownMenuItem<int>(
                  value: tractor.id,
                  child: Text(tractor.name),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: isEdit ? rental!.equipmentId : null,
              onChanged: (value) {
                equipmentIdController.text = value.toString();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey.withOpacity(.1),
                hintText: "Equipment",
                prefixIcon: Icon(
                  Icons.handyman_rounded,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              items: controller.equipmentList.map((equipment) {
                return DropdownMenuItem<int>(
                  value: equipment.id,
                  child: Text(equipment.name),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DateTimeFormField(
              initialValue: isEdit ? rental!.rentalDate : null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey.withOpacity(.1),
                hintText: "Date",
                prefixIcon: Icon(
                  Icons.date_range,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              mode: DateTimeFieldPickerMode.date,
              onChanged: (DateTime? value) {
                rentalDateController.text =
                    DateFormat('MM-dd-yyyy').format(value!);
              },
            ),
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          final newRental = Rental(
            id: isEdit ? rental!.id : null,
            clientId: int.parse(clientIdController.text),
            tractorId: int.parse(tractorIdController.text),
            equipmentId: int.parse(equipmentIdController.text),
            rentalDate: DateTime.parse(rentalDateController.text),
          );
          if (isEdit) {
            controller.updateRental(newRental);
          } else {
            controller.addRental(newRental);
          }
          Get.back(); // Close dialog
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Constants.azreg : Constants.ktiba),
        child: Text(
          isEdit ? 'Update Rental' : 'Add Rental',
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
      content: Text('Are you sure you want to delete this rental?'),
      confirm: ElevatedButton(
        onPressed: () {
          controller.deleteRental(id);
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
