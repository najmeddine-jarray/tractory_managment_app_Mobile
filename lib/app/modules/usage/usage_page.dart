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
      content: Text('Are you sure you want to delete this usage?'),
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
              icon: Icon(
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
            return Center(child: CircularProgressIndicator());
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
                final rentalId = controller.rentalList
                    .firstWhere((r) => r.id == usage.rentalId,
                        orElse: () => Rental(
                            id: -1,
                            clientId: 0,
                            tractorId: 0,
                            equipmentId: 0,
                            rentalDate: DateTime.now()))
                    .id;
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
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${usage.id} | ${clientName}'),

                            Text(
                              '${usage.location} ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constants.azreg,
                              ),
                            ),
                            // Text(
                            //   '${DateFormat('MM-dd-yyyy').format(usage.startTime)}',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     color: Constants.azreg,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        title: Row(
                          children: [
                            Text('| ${tractorName} |'),
                            Text(' ${driverName} | '),
                            Text('${equipmentName} |'),
                          ],
                        ),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(10.0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DateFormat('MM-dd-yyyy | HH:mm:ss').format(usage.startTime)}',
                                ),
                                Text(
                                  '${DateFormat('MM-dd-yyyy | HH:mm:ss').format(usage.endTime)}',
                                ),
                                // Text(
                                // 'Hours: ${usage.hoursUsed} * ${equipmentPrice}'),
                                Text('Task: ${usage.taskDescription}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide.none,
                        ),
                        title: Text(
                            'Facture: ${invoice.id} | ${invoice.paymentStatus}'),
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DateFormat('MM-dd-yyyy | HH:mm:ss').format(usage.startTime)}',
                                ),
                                Text(
                                  '${DateFormat('MM-dd-yyyy | HH:mm:ss').format(usage.endTime)}',
                                ),
                                Text(
                                    'Hours: ${usage.hoursUsed} * ${equipmentPrice}'),
                                Text(
                                  'Total Price: ${invoice.totalPrice} Dinar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.azreg,
                                  ),
                                ),
                                // Add more invoice details here if needed
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Constants.azreg,
                                  ),
                                  onPressed: () => Get.to(() => UsageFormPage(
                                        usage: usage,
                                        controller: controller,
                                      )),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      _showDeleteConfirmationDialog(
                                          context, usage.id!),
                                ),
                              ],
                            ),
                            Text(
                              '${DateFormat('MM-dd-yyyy').format(usage.startTime)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constants.azreg,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => UsageFormPage(controller: controller)),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Constants.azreg,
      ),
    );
  }
}

class UsageFormPage extends GetView<UsageController> {
  final Usage? usage;
  final UsageController controller;

  UsageFormPage({this.usage, required this.controller});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tractorIdController = TextEditingController();
    final equipmentIdController = TextEditingController();
    final driverIdController = TextEditingController();
    final rentalIdController = TextEditingController();
    final locationController = TextEditingController();
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();
    final taskDescriptionController = TextEditingController();

    if (usage != null) {
      tractorIdController.text = usage!.tractorId.toString();
      equipmentIdController.text = usage!.equipmentId.toString();
      driverIdController.text = usage!.driverId.toString();
      rentalIdController.text = usage!.rentalId.toString();
      locationController.text = usage!.location;
      startTimeController.text =
          DateFormat('MM-dd-yyyy HH:mm:ss').format(usage!.startTime);
      endTimeController.text =
          DateFormat('MM-dd-yyyy HH:mm:ss').format(usage!.endTime);
      taskDescriptionController.text = usage!.taskDescription;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(usage == null ? 'Add Usage' : 'Update Usage'),
        backgroundColor: Constants.azreg,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<int>(
                value: usage?.tractorId,
                decoration: InputDecoration(labelText: 'Tractor'),
                items: controller.tractorList.map((tractor) {
                  return DropdownMenuItem<int>(
                    value: tractor.id,
                    child: Text(tractor.name),
                  );
                }).toList(),
                onChanged: (value) {
                  tractorIdController.text = value.toString();
                },
                validator: (value) {
                  if (value == null) return 'Please select a tractor';
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: usage?.equipmentId,
                decoration: InputDecoration(labelText: 'Equipment'),
                items: controller.equipmentList.map((equipment) {
                  return DropdownMenuItem<int>(
                    value: equipment.id,
                    child: Text(equipment.name),
                  );
                }).toList(),
                onChanged: (value) {
                  equipmentIdController.text = value.toString();
                },
                validator: (value) {
                  if (value == null) return 'Please select equipment';
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: usage?.driverId,
                decoration: InputDecoration(labelText: 'Driver'),
                items: controller.driverList.map((driver) {
                  return DropdownMenuItem<int>(
                    value: driver.id,
                    child: Text(driver.name),
                  );
                }).toList(),
                onChanged: (value) {
                  driverIdController.text = value.toString();
                },
                validator: (value) {
                  if (value == null) return 'Please select a driver';
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: usage?.rentalId,
                decoration: InputDecoration(labelText: 'Rental'),
                items: controller.rentalList.map((rental) {
                  return DropdownMenuItem<int>(
                    value: rental.id,
                    child: Text('Rental ${rental.id}'),
                  );
                }).toList(),
                onChanged: (value) {
                  rentalIdController.text = value.toString();
                },
                validator: (value) {
                  if (value == null) return 'Please select a rental';
                  return null;
                },
              ),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              DateTimeFormField(
                initialValue: usage?.startTime,
                decoration: InputDecoration(labelText: 'Start Time'),
                mode: DateTimeFieldPickerMode.dateAndTime,
                onChanged: (DateTime? value) {
                  startTimeController.text =
                      DateFormat('MM-dd-yyyy HH:mm:ss').format(value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select start time';
                  }
                  return null;
                },
              ),
              DateTimeFormField(
                initialValue: usage?.endTime,
                decoration: InputDecoration(labelText: 'End Time'),
                mode: DateTimeFieldPickerMode.dateAndTime,
                onChanged: (DateTime? value) {
                  endTimeController.text =
                      DateFormat('MM-dd-yyyy HH:mm:ss').format(value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select end time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: taskDescriptionController,
                decoration: InputDecoration(labelText: 'Task Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.azreg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
