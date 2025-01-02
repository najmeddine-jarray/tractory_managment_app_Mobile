import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart'; // Ensure you have this import for DateFormat
import 'package:tractory/app/modules/expense/expense_controller.dart';
import 'package:tractory/utils/constants.dart';
import '../../data/models/expense_Model.dart';

class ExpensePage extends GetView<ExpenseController> {
  ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Expenses',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Constants.azreg,
        toolbarHeight: 50,
        actions: [
          IconButton(
              onPressed: () {
                controller.fetchExpenses();
                controller.fetchTractors();
              },
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      hintText: 'Tractor',
                      fillColor: Colors.blueGrey.withOpacity(.1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.agriculture,
                      ),
                    ),
                    value: controller.selectedTractorId.value,
                    hint: Text('Select Tractor'),
                    onChanged: (newValue) {
                      controller.selectedTractorId.value = newValue;
                      controller
                          .filterExpenses(); // Filter expenses based on selection
                    },
                    items: controller.tractorList.map((tractor) {
                      return DropdownMenuItem<int>(
                        value: tractor.id,
                        child: Text(tractor.name),
                      );
                    }).toList(),
                  ),
                ),
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else if (controller.errorMessage.value.isNotEmpty) {
            return Center(
                child: Text(controller.errorMessage.value,
                    style: TextStyle(color: Colors.red)));
          } else {
            return Column(
              children: [
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    hintText: 'Tractor',
                    fillColor: Colors.blueGrey.withOpacity(.1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.agriculture,
                    ),
                  ),
                  value: controller.selectedTractorId.value,
                  hint: Text('Select Tractor'),
                  onChanged: (newValue) {
                    controller.selectedTractorId.value = newValue;
                    controller
                        .filterExpenses(); // Filter expenses based on selection
                  },
                  items: controller.tractorList.map((tractor) {
                    return DropdownMenuItem<int>(
                      value: tractor.id,
                      child: Text(tractor.name),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: Obx(() {
                    if (controller.filteredExpenses.isEmpty) {
                      return Center(child: Text('No results'));
                    } else {
                      return ListView.builder(
                        itemCount: controller.filteredExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = controller.filteredExpenses[index];
                          return Card(
                            elevation: 1,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10.0),
                              title: Text(
                                  '${expense.id} | Tractor: ${controller.getTractorNameById(expense.tractorId)}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Fuel Cost: ${expense.fuelCost} Dinar'),
                                  Text(
                                      'Date: ${DateFormat('MM-dd-yyyy').format(expense.date)}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Constants.azreg),
                                    onPressed: () => _showExpenseDialog(context,
                                        expense: expense),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () =>
                                        _showDeleteConfirmationDialog(
                                            context, expense.id!),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ],
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExpenseDialog(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Constants.azreg,
      ),
    );
  }

  void _showExpenseDialog(BuildContext context, {Expense? expense}) {
    final isEdit = expense != null;

    final tractorIdController = TextEditingController(
        text: isEdit ? expense!.tractorId.toString() : '');
    final fuelCostController =
        TextEditingController(text: isEdit ? expense!.fuelCost.toString() : '');
    final dateController = TextEditingController(
        text: isEdit
            ? DateFormat('MM-dd-yyyy HH:mm:ss').format(expense!.date)
            : '');
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    Get.defaultDialog(
      title: isEdit ? 'Edit Expense' : 'Add Expense',
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => DropdownButtonFormField<int>(
                    value: isEdit ? expense!.tractorId : null,
                    decoration: InputDecoration(
                      hintText: 'Tractor',
                      fillColor: Colors.blueGrey.withOpacity(.1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.agriculture,
                      ),
                    ),
                    items: controller.tractorList.map((tractor) {
                      return DropdownMenuItem<int>(
                        value: tractor.id,
                        child: Text('Tractor: ${tractor.name}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedTractorId.value = value!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a Tractor';
                      }
                      return null;
                    },
                  )),
              SizedBox(height: 10),
              TextFormField(
                controller: fuelCostController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Fuel Cost',
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.attach_money,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Fuel Cost';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DateTimeField(
                mode: DateTimeFieldPickerMode.date,
                decoration: InputDecoration(
                  hintText: 'Date',
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                  ),
                ),
                onChanged: (DateTime? value) {
                  dateController.text =
                      DateFormat('MM-dd-yyyy HH:mm:ss').format(value!);
                },
              ),
            ],
          ),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final newExpense = Expense(
              id: isEdit ? expense!.id : null,
              tractorId: controller.selectedTractorId.value!,
              fuelCost: double.parse(fuelCostController.text),
              date: DateFormat('MM-dd-yyyy').parse(dateController.text),
            );
            if (isEdit) {
              controller.updateExpense(newExpense);
            } else {
              controller.addExpense(newExpense);
            }
            Get.back(); // Close dialog
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Constants.azreg : Constants.ktiba),
        child: Text(
          isEdit ? 'Update Expense' : 'Add Expense',
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
      content: Text('Are you sure you want to delete this expense?'),
      confirm: ElevatedButton(
        onPressed: () {
          controller.deleteExpense(id);
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

  final _formKey = GlobalKey<FormState>();
}
