import 'dart:developer';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tractory/app/data/models/client_Model.dart';
import 'package:tractory/app/data/models/driver_Model.dart';
import 'package:tractory/app/data/models/equipment_Model.dart';
import 'package:tractory/app/data/models/invoice_Model.dart';
import 'package:tractory/app/data/models/rental_Model.dart';
import 'package:tractory/app/data/models/tractor_Model.dart';
import 'package:tractory/app/modules/usage/usage_controller.dart';
import '../../../utils/constants.dart';
import '../../data/models/usage_Model.dart';

class UsagePage extends GetView<UsageController> {
  const UsagePage({super.key});

  void _showDeleteConfirmationDialog(BuildContext context, int id) {
    Get.defaultDialog(
      title: 'Delete Usage',
      content: const Text('Are you sure you want to delete this usage?'),
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteUsage(id);
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Usages',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Constants.azreg,
        actions: [
          IconButton(
              onPressed: () => controller.fetchAllData(),
              icon: const Icon(
                Icons.refresh_outlined,
              ))
        ],
        toolbarHeight: 50,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.usageList.isEmpty) {
            return const Center(child: Text('No results found'));
          } else {
            return ListView.builder(
              itemCount: controller.usageList.length,
              itemBuilder: (context, index) {
                final usage = controller.usageList[index];

                final tractorName = controller.tractorList
                    .firstWhere((t) => t.id == usage.tractorId,
                        orElse: () => Tractor(
                            id: -1,
                            name: 'Unknown',
                            type: '',
                            image: '',
                            power: 0))
                    .name;
                final equipmentName = controller.equipmentList
                    .firstWhere((e) => e.id == usage.equipmentId,
                        orElse: () => Equipment(
                            id: -1,
                            name: 'Unknown',
                            type: '',
                            image: '',
                            priceHours: 0))
                    .name;

                final equipmentPrice = controller.equipmentList
                    .firstWhere((e) => e.id == usage.equipmentId,
                        orElse: () => Equipment(
                            id: -1,
                            priceHours: 0.0,
                            type: '',
                            name: '',
                            image: ''))
                    .priceHours;
                final driverName = controller.driverList
                    .firstWhere((d) => d.id == usage.driverId,
                        orElse: () => Driver(
                            id: -1,
                            name: 'Unknown',
                            licenseNumber: '',
                            phone: ''))
                    .name;
                final rental = controller.rentalList
                    .firstWhere((r) => r.id == usage.rentalId,
                        orElse: () => Rental(
                              id: -1,
                              clientId: 0,
                              tractorId: 0,
                              equipmentId: 0,
                              rentalDate: DateTime.now(), // Default date value
                            ));
                // Find invoice based on usage.id
                final invoice = controller.invoiceList.firstWhere(
                    (i) => i.usageId == usage.id,
                    orElse: () => Invoice(
                        id: -1,
                        usageId: -1,
                        totalPrice: 0.0,
                        paymentStatus: 'Unknown'));

                final client = controller.clientList.firstWhere(
                    (c) => c.id == rental.clientId,
                    orElse: () =>
                        Client(id: 0, name: '', phone: '', address: ''));
                final clientName = client.name;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // Adds a subtle shadow for depth

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Row with ID, Client Name, and Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${usage.id} ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' | ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: clientName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Constants.azreg,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              DateFormat('MM-dd-yyyy').format(usage.startTime),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Second Row with Driver, Tractor, and Equipment
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 14),
                                    children: [
                                      TextSpan(text: driverName),
                                      const TextSpan(text: ' | '),
                                      TextSpan(text: tractorName),
                                      const TextSpan(text: ' | '),
                                      TextSpan(text: equipmentName),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),

                                // Invoice Details
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 14),
                                    children: [
                                      const TextSpan(text: 'Facture: '),
                                      TextSpan(
                                        text: '${invoice.id} | ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: invoice.paymentStatus,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: invoice.paymentStatus == 'Paid'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),

                                // Usage Time Information

                                Text(
                                  '${DateFormat('MM-dd-yyyy | HH:mm:ss').format(usage.startTime)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${DateFormat('MM-dd-yyyy | HH:mm:ss').format(usage.endTime)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 8.0),

                                // Hours and Price Calculation
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${usage.hoursUsed.toInt()} H : ${(usage.hoursUsed * 60 % 60).toInt()} Min',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Constants.azreg,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' | ${usage.location}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8.0),

                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Total : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${usage.hoursUsed.toStringAsFixed(2)} * $equipmentPrice = ${invoice.totalPrice.toStringAsFixed(2)} Dinar',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Constants.azreg),
                                  onPressed: () => Get.to(() => UsageFormPage(
                                        usage: usage,
                                        controller: controller,
                                      )),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      _showDeleteConfirmationDialog(
                                          context, usage.id!),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Edit and Delete Buttons
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => UsageFormPage(controller: controller)),
        backgroundColor: Constants.azreg,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class UsageFormPage extends GetView<UsageController> {
  final Usage? usage;
  final UsageController controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController tractorIdController = TextEditingController();
  final TextEditingController equipmentIdController = TextEditingController();
  final TextEditingController driverIdController = TextEditingController();
  final TextEditingController rentalIdController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  UsageFormPage({this.usage, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(usage == null ? 'Add Usage' : 'Update Usage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<int>(
                value: usage?.tractorId,
                decoration: InputDecoration(
                  hintText: 'Tractor',
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.agriculture, size: 20),
                ),
                items: controller.tractorList.map((tractor) {
                  return DropdownMenuItem<int>(
                    value: tractor.id,
                    child: Text(tractor.name),
                  );
                }).toList(),
                onChanged: (value) {
                  tractorIdController.text = value?.toString() ?? '';
                  print(
                      "Selected Tractor ID: ${tractorIdController.text}"); // Print selected tractor ID
                },
                validator: (value) {
                  if (value == null) return 'Please select a tractor';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: usage?.equipmentId,
                decoration: InputDecoration(
                  hintText: 'Equipment',
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.build, size: 20),
                ),
                items: controller.equipmentList.map((equipment) {
                  return DropdownMenuItem<int>(
                    value: equipment.id,
                    child: Text(equipment.name),
                  );
                }).toList(),
                onChanged: (value) {
                  equipmentIdController.text = value?.toString() ?? '';
                  print(
                      "Selected equipmentIdController ID: ${equipmentIdController.text}");
                },
                validator: (value) {
                  if (value == null) return 'Please select equipment';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: usage?.driverId,
                decoration: InputDecoration(
                  hintText: 'Driver',
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.person, size: 20),
                ),
                items: controller.driverList.map((driver) {
                  return DropdownMenuItem<int>(
                    value: driver.id,
                    child: Text(driver.name),
                  );
                }).toList(),
                onChanged: (value) {
                  driverIdController.text = value?.toString() ?? '';
                  print(
                      "Selected driverIdController ID: ${driverIdController.text}");
                },
                validator: (value) {
                  if (value == null) return 'Please select a driver';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: usage?.rentalId,
                decoration: InputDecoration(
                  hintText: 'Rental',
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.assignment, size: 20),
                ),
                items: controller.rentalList.map((rental) {
                  return DropdownMenuItem<int>(
                    value: rental.id,
                    child: Text('Rental ${rental.id}'),
                  );
                }).toList(),
                onChanged: (value) {
                  rentalIdController.text = value?.toString() ?? '';
                  print(
                      "Selected rentalIdController ID: ${rentalIdController.text}");
                },
                validator: (value) {
                  if (value == null) return 'Please select a rental';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'Location',
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DateTimeFormField(
                initialValue: usage?.startTime,
                decoration: InputDecoration(
                  hintText: 'Start Time',
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                onChanged: (DateTime? value) {
                  startTimeController.text = value != null
                      ? DateFormat('MM-dd-yyyy HH:mm:ss').format(value)
                      : '';
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select start time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DateTimeFormField(
                initialValue: usage?.endTime,
                decoration: InputDecoration(
                  hintText: 'End Time',
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                onChanged: (DateTime? value) {
                  endTimeController.text = value != null
                      ? DateFormat('MM-dd-yyyy HH:mm:ss').format(value)
                      : '';
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select end time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: taskDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Task Description',
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final startTime = DateFormat('MM-dd-yyyy HH:mm:ss')
                          .parse(startTimeController.text);
                      final endTime = DateFormat('MM-dd-yyyy HH:mm:ss')
                          .parse(endTimeController.text);

                      final hoursUsed =
                          endTime.difference(startTime).inMinutes / 60.0;
                      print("Tractor ID: ${tractorIdController.text}");
                      print("Equipment ID: ${equipmentIdController.text}");
                      print("Driver ID: ${driverIdController.text}");
                      print("Rental ID: ${rentalIdController.text}");
                      print("Location: ${locationController.text}");
                      print("Start Time: ${startTimeController.text}");
                      print("End Time: ${endTimeController.text}");
                      print("End Time: ${hoursUsed}");
                      print(
                          "Task Description: ${taskDescriptionController.text}");

                      final newUsage = Usage(
                        id: usage?.id,
                        tractorId: int.parse(tractorIdController.text),
                        equipmentId: int.parse(equipmentIdController.text),
                        driverId: int.parse(driverIdController.text),
                        rentalId: int.parse(rentalIdController.text),
                        location: locationController.text,
                        startTime: startTime,
                        endTime: endTime,
                        hoursUsed: hoursUsed,
                        taskDescription: taskDescriptionController.text,
                      );

                      if (usage == null) {
                        controller.addUsage(newUsage);
                        controller.fetchUsage();
                        controller.fetchDrivers();
                        controller.fetchEquipment();
                        controller.fetchInvoices();
                        controller.fetchRentals();
                      } else {
                        controller.updateUsage(newUsage);
                      }

                      Get.back();
                    } catch (e) {
                      print(e);
                      Get.snackbar(
                          'Error', 'Invalid date format: ${e.toString()}');
                    }
                  }
                },
                child: Text(usage == null ? 'Add Usage' : 'Update Usage'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
