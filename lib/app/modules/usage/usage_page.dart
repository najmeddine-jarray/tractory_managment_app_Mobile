// import 'package:date_field/date_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:tractory/app/data/models/invoice_Model.dart';
// import 'package:tractory/utils/constants.dart';

// import 'usage_controller.dart';
// import '../../data/models/usage_Model.dart';

// class UsagePage extends GetView<UsageController> {
//   const UsagePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: const Text('Usages',
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//         backgroundColor: Constants.azreg,
//         toolbarHeight: 50,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return ListView.builder(
//             itemCount: controller.usageList.length,
//             itemBuilder: (context, index) {
//               final usage = controller.usageList[index];
//               final tractorName = controller.tractorList
//                   .firstWhere((t) => t.id == usage.tractorId)
//                   .name;
//               final equipmentName = controller.equipmentList
//                   .firstWhere((e) => e.id == usage.equipmentId)
//                   .name;
//               final equipmentPrice = controller.equipmentList
//                   .firstWhere((e) => e.id == usage.equipmentId)
//                   .priceHours;
//               final driverName = controller.driverList
//                   .firstWhere((d) => d.id == usage.driverId)
//                   .name;
//               final rentalId = controller.rentalList
//                       .firstWhere((r) => r.id == usage.rentalId)
//                       .id ??
//                   'Unknown Rental';
//               final invoice = controller.invoiceList.firstWhere(
//                   (i) => i.id == usage.invoiceId,
//                   orElse: () => Invoice(
//                       id: -1,
//                       usageId: -1,
//                       totalPrice: 0.0,
//                       paymentStatus: 'Unknown'));

//               return Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                   side: BorderSide.none,
//                 ),
//                 elevation: 1,
//                 child: Column(
//                   children: [
//                     ListTile(
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('${usage.id} | Location: ${usage.location}'),
//                         ],
//                       ),
//                     ),
//                     ExpansionTile(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         side: BorderSide.none,
//                       ),
//                       title: Text(
//                           '$rentalId | ${tractorName} | ${equipmentName} | ${driverName} '),
//                       children: [
//                         ListTile(
//                           contentPadding: const EdgeInsets.all(10.0),
//                           title: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Text('Driver: $driverName'),
//                               // Text('Rental: $rentalId'),
//                               // Text('Tractor: $tractorName'),
//                               // Text('Equipment: $equipmentName'),
//                               Text(
//                                   '${DateFormat('HH:mm').format(usage.startTime)} | ${DateFormat('HH:mm').format(usage.endTime)}'),
//                               Text('Hours Used: ${usage.hoursUsed}'),
//                               Text('Task: ${usage.taskDescription}'),
//                               // Text('Invoice ID: ${invoice.id}'),
//                               // Text('Invoice Usage ID: ${invoice.usageId}'),
//                               // Text(
//                               //     '${invoice.id} | Total Price: \$${invoice.totalPrice}'),
//                             ],
//                           ),
//                           // trailing: Column(
//                           //   children: [
//                           //     Row(
//                           //       mainAxisSize: MainAxisSize.min,
//                           //       children: [
//                           //         IconButton(
//                           //           icon: Icon(Icons.edit),
//                           //           onPressed: () => Get.to(() => UsageFormPage(
//                           //                 usage: usage,
//                           //                 controller: controller,
//                           //               )),
//                           //         ),
//                           //         IconButton(
//                           //           icon: Icon(Icons.delete),
//                           //           onPressed: () =>
//                           //               _showDeleteConfirmationDialog(
//                           //                   context, usage.id!),
//                           //         ),
//                           //       ],
//                           //     ),
//                           //   ],
//                           // ),
//                         ),
//                       ],
//                     ),
//                     ExpansionTile(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         side: BorderSide.none,
//                       ),
//                       title: Text('Facture: ${invoice.paymentStatus}'),
//                       children: [
//                         ListTile(
//                           title: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Text('Driver: $driverName'),
//                               // Text('Rental: $rentalId'),
//                               // Text('Tractor: $tractorName'),
//                               // Text('Equipment: $equipmentName'),

//                               // '${DateFormat('HH:mm').format(usage.startTime)} | ${DateFormat('HH:mm').format(usage.endTime)}'),
//                               // Text('Hours Used: ${usage.hoursUsed}'),
//                               // Text('Task: ${usage.taskDescription}'),
//                               // Text('Invoice ID: ${invoice.id}'),
//                               // Text('Invoice Usage ID: ${invoice.usageId}'),
//                               Text(
//                                   '${invoice.id} | Total Price: \$${invoice.totalPrice}'),
//                               Text(
//                                   'Start: ${DateFormat('HH:mm').format(usage.startTime)} | End: ${DateFormat('HH:mm').format(usage.endTime)}'),
//                               Text(
//                                   'Hours Used: ${usage.hoursUsed} * ${equipmentPrice}'),
//                               Text('Total Price = \$${invoice.totalPrice}'),
//                             ],
//                           ),
//                           // trailing: Column(
//                           //   children: [
//                           //     Row(
//                           //       mainAxisSize: MainAxisSize.min,
//                           //       children: [
//                           //         IconButton(
//                           //           icon: Icon(Icons.edit),
//                           //           onPressed: () => Get.to(() => UsageFormPage(
//                           //                 usage: usage,
//                           //                 controller: controller,
//                           //               )),
//                           //         ),
//                           //         IconButton(
//                           //           icon: Icon(Icons.delete),
//                           //           onPressed: () =>
//                           //               _showDeleteConfirmationDialog(
//                           //                   context, usage.id!),
//                           //         ),
//                           //       ],
//                           //     ),
//                           //   ],
//                           // ),
//                         ),
//                       ],
//                     ),
//                     ListTile(
//                       title: Column(
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.edit,
//                                   color: Constants.azreg,
//                                 ),
//                                 onPressed: () => Get.to(() => UsageFormPage(
//                                       usage: usage,
//                                       controller: controller,
//                                     )),
//                               ),
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () => _showDeleteConfirmationDialog(
//                                     context, usage.id!),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Get.to(() => UsageFormPage(controller: controller)),
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         backgroundColor: Constants.azreg,
//       ),
//     );
//   }

//   void _showDeleteConfirmationDialog(BuildContext context, int id) {
//     Get.defaultDialog(
//       title: 'Delete Usage',
//       content: Text('Are you sure you want to delete this usage?'),
//       textConfirm: 'Delete',
//       textCancel: 'Cancel',
//       onConfirm: () {
//         controller.deleteUsage(id);
//         Get.back();
//       },
//     );
//   }
// }

// class UsageFormPage extends StatelessWidget {
//   final Usage? usage;
//   final UsageController controller;

//   UsageFormPage({Key? key, this.usage, required this.controller})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isEdit = usage != null;

//     final tractorIdController =
//         TextEditingController(text: isEdit ? usage!.tractorId.toString() : '');
//     final equipmentIdController = TextEditingController(
//         text: isEdit ? usage!.equipmentId.toString() : '');
//     final driverIdController =
//         TextEditingController(text: isEdit ? usage!.driverId.toString() : '');
//     final rentalIdController =
//         TextEditingController(text: isEdit ? usage!.rentalId.toString() : '');

//     final locationController =
//         TextEditingController(text: isEdit ? usage!.location : '');
//     final startTimeController = TextEditingController(
//         text: isEdit
//             ? DateFormat('yyy-mm-dd HH:mm').format(usage!.startTime)
//             : '');
//     final endTimeController = TextEditingController(
//         text: isEdit
//             ? DateFormat('yyy-mm-dd HH:mm').format(usage!.endTime)
//             : '');
//     final hoursUsedController =
//         TextEditingController(text: isEdit ? usage!.hoursUsed.toDouble() : null);
//     final taskDescriptionController =
//         TextEditingController(text: isEdit ? usage!.taskDescription : '');

//     void _updateHoursUsed() {
//       final startTime = DateTime.tryParse(startTimeController.text);
//       final endTime = DateTime.tryParse(endTimeController.text);

//       if (startTime != null && endTime != null) {
//         final duration = endTime.difference(startTime);
//         final hours = duration.inHours + duration.inMinutes % 60 / 60.0;
//         hoursUsedController.text = hours.toStringAsFixed(2);
//       } else {
//         hoursUsedController.text = '';
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEdit ? 'Edit Usage' : 'Add Usage'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//           child: Obx(() {
//             if (controller.isLoading.value) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DropdownButtonFormField<int>(
//                     value: isEdit ? usage!.tractorId : null,
//                     decoration: InputDecoration(
//                       labelText: 'Tractor ID',
//                       border: OutlineInputBorder(),
//                     ),
//                     items: controller.tractorList.map((tractor) {
//                       return DropdownMenuItem<int>(
//                         value: tractor.id,
//                         child: Text(tractor.name),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       tractorIdController.text = value.toString();
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   DropdownButtonFormField<int>(
//                     value: isEdit ? usage!.equipmentId : null,
//                     decoration: const InputDecoration(
//                       labelText: 'Equipment ID',
//                       border: OutlineInputBorder(),
//                     ),
//                     items: controller.equipmentList.map((equipment) {
//                       return DropdownMenuItem<int>(
//                         value: equipment.id,
//                         child: Text(equipment.name),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       equipmentIdController.text = value.toString();
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   DropdownButtonFormField<int>(
//                     value: isEdit ? usage!.driverId : null,
//                     decoration: const InputDecoration(
//                       labelText: 'Driver ID',
//                       border: OutlineInputBorder(),
//                     ),
//                     items: controller.driverList.map((driver) {
//                       return DropdownMenuItem<int>(
//                         value: driver.id,
//                         child: Text(driver.name),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       driverIdController.text = value.toString();
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   DropdownButtonFormField<int>(
//                     value: isEdit ? usage!.rentalId : null,
//                     decoration: InputDecoration(
//                       labelText: 'Rental ID',
//                       border: OutlineInputBorder(),
//                     ),
//                     items: controller.rentalList.map((rental) {
//                       return DropdownMenuItem<int>(
//                         value: rental.id,
//                         child: Text(
//                             rental.id.toString()), // Customize this as needed
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       rentalIdController.text = value.toString();
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   TextFormField(
//                     controller: locationController,
//                     decoration: InputDecoration(
//                       labelText: 'Location',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   // Uncomment if needed
//                   // TextFormField(
//                   //   controller: invoiceIdController,
//                   //   decoration: InputDecoration(
//                   //     labelText: 'Invoice ID',
//                   //     border: OutlineInputBorder(),
//                   //   ),
//                   // ),
//                   SizedBox(height: 10),
//                   DateTimeFormField(
//                     initialValue: isEdit
//                         ? DateTime.parse(startTimeController.text)
//                         : null,
//                     decoration: InputDecoration(
//                       labelText: 'Start Time',
//                       border: OutlineInputBorder(),
//                     ),
//                     mode: DateTimeFieldPickerMode.dateAndTime,
//                     onChanged: (DateTime? value) {
//                       startTimeController.text = value?.toIso8601String() ?? '';
//                       _updateHoursUsed(); // Recalculate when start time changes
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   DateTimeFormField(
//                     initialValue:
//                         isEdit ? DateTime.parse(endTimeController.text) : null,
//                     decoration: InputDecoration(
//                       labelText: 'End Time',
//                       border: OutlineInputBorder(),
//                     ),
//                     mode: DateTimeFieldPickerMode.dateAndTime,
//                     onChanged: (DateTime? value) {
//                       endTimeController.text = value?.toIso8601String() ?? '';
//                       _updateHoursUsed(); // Recalculate when end time changes
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   TextFormField(
//                     controller: hoursUsedController,
//                     decoration: InputDecoration(
//                       labelText: 'Hours Used',
//                       border: OutlineInputBorder(),
//                     ),
//                     readOnly: true,
//                   ),
//                   SizedBox(height: 10),
//                   TextFormField(
//                     controller: taskDescriptionController,
//                     decoration: InputDecoration(
//                       labelText: 'Task Description',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       final usageData = Usage(
//                         id: isEdit ? usage!.id : null,
//                         tractorId: int.tryParse(tractorIdController.text) ?? 0,
//                         equipmentId:
//                             int.tryParse(equipmentIdController.text) ?? 0,
//                         driverId: int.tryParse(driverIdController.text) ?? 0,
//                         rentalId: int.tryParse(rentalIdController.text) ?? 0,
//                         location: locationController.text,
//                         startTime:
//                             DateTime.tryParse(startTimeController.text) ??
//                                 DateTime.now(),
//                         endTime: DateTime.tryParse(endTimeController.text) ??
//                             DateTime.now(),
//                         hoursUsed:
//                             double.tryParse(hoursUsedController.text) ?? 0.0,
//                         taskDescription: taskDescriptionController.text,
//                       );

//                       if (isEdit) {
//                         controller.updateUsage(usageData);
//                       } else {
//                         controller.addUsage(usageData);
//                       }

//                       Get.back();
//                     },
//                     child: Text(isEdit ? 'Update' : 'Add'),
//                   ),
//                 ],
//               );
//             }
//           }),
//         ),
//       ),
//     );
//   }
// }
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                // final rentalId = controller.rentalList
                //     .firstWhere((r) => r.id == usage.rentalId,
                //         orElse: () => Rental(id: -1, clientId: 0, tractorId: 0, equipmentId: 0, rentalDate: "2020-02-02"))
                //     .id;

                // Find invoice based on usage.id
                final invoice = controller.invoiceList.firstWhere(
                    (i) => i.usageId == usage.id,
                    orElse: () => Invoice(
                        id: -1,
                        usageId: -1,
                        totalPrice: 0.0,
                        paymentStatus: 'Unknown'));

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
                            Text('${usage.id} | Location: ${usage.location}'),
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
                      ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        title: Text(
                            ' | ${tractorName} | ${equipmentName} | ${driverName}'),
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
                                Text(
                                    'Hours: ${usage.hoursUsed} * ${equipmentPrice}'),
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
                            '${invoice.id} | Facture: ${invoice.paymentStatus}'),
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DateFormat('MM-dd | HH:mm:ss').format(usage.startTime)} | ${DateFormat('MM-dd | HH:mm:ss').format(usage.endTime)}',
                                ),
                                Text(
                                    'Hours: ${usage.hoursUsed} * ${equipmentPrice}'),
                                Text('Total Price: \$${invoice.totalPrice}'),
                                // Add more invoice details here if needed
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Row(
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
                              onPressed: () => _showDeleteConfirmationDialog(
                                  context, usage.id!),
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
