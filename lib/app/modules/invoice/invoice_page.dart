// lib/ui/pages/invoice_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractory/app/data/models/invoice_Model.dart';
import 'package:tractory/utils/constants.dart';
import 'invoice_controller.dart';

class InvoicePage extends GetView<InvoiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Invoices',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Constants.azreg,
        toolbarHeight: 50,
        actions: [
          IconButton(
              onPressed: () {
                controller.fetchInvoices();
              },
              icon: Icon(
                Icons.refresh_outlined,
              ))
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.invoiceList.length,
            itemBuilder: (context, index) {
              final invoice = controller.invoiceList[index];
              return Card(
                child: ListTile(
                  title: Text('Invoice ID: ${invoice.id}'),
                  subtitle: Text(
                      'Usage ID: ${invoice.usageId}\nTotal Price: ${invoice.totalPrice} Dinar\nPayment Status: ${invoice.paymentStatus}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Constants.azreg,
                        ),
                        onPressed: () =>
                            _showInvoiceDialog(context, invoice: invoice),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            _showDeleteConfirmationDialog(context, invoice.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

  void _showInvoiceDialog(BuildContext context, {Invoice? invoice}) {
    final TextEditingController totalPriceController = TextEditingController();
    final List<String> paymentStatusOptions = ['Pending', 'Paid', 'Overdue'];
    String selectedPaymentStatus = 'Pending'; // Default value
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    if (invoice != null) {
      totalPriceController.text = invoice.totalPrice.toString();
      selectedPaymentStatus = invoice.paymentStatus;
    }

    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 20),
      contentPadding: EdgeInsets.all(20),
      radius: 10,
      title: invoice == null ? 'Add Invoice' : 'Edit Invoice',
      confirm: ElevatedButton(
        onPressed: () {
          final double totalPrice =
              double.tryParse(totalPriceController.text) ?? 0.0;

          if (invoice == null) {
            // Add new invoice
            final newInvoice = Invoice(
              usageId: 1, // Replace with actual usage ID
              totalPrice: totalPrice,
              paymentStatus: selectedPaymentStatus,
            );
            controller.addInvoice(newInvoice);
          } else {
            // Update existing invoice
            final updatedInvoice = invoice.copyWith(
              totalPrice: totalPrice,
              paymentStatus: selectedPaymentStatus,
            );
            controller.updateInvoice(updatedInvoice);
          }
          Get.back(); // Close the dialog
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Constants.azreg : Constants.ktiba),
        child: Text(
          invoice == null ? 'Add Invoice' : 'Edit Invoice',
          style: TextStyle(
              color: isDark ? Constants.secondaryColor : Constants.azreg),
        ),
      ),
      content: Column(
        children: [
          TextField(
            controller: totalPriceController,
            decoration: InputDecoration(
              hintText: 'Total Price',
              labelText: 'Total Price',
              fillColor: Colors.blueGrey.withOpacity(.1),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedPaymentStatus,
            decoration: InputDecoration(
              hintText: 'status',
              labelText: 'status',
              fillColor: Colors.blueGrey.withOpacity(.1),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            items: paymentStatusOptions.map((String status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (String? newValue) {
              selectedPaymentStatus = newValue!;
            },
            hint: Text('Select Payment Status'),
          ),
        ],
      ),
      textConfirm: invoice == null ? 'Add' : 'Update',
      cancel: TextButton(
        onPressed: () => Get.back(), // Close dialog
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.red),
        ),
      ),
      confirmTextColor: Colors.white,
      onConfirm: () {},
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int id) {
    Get.defaultDialog(
      title: 'Delete Invoice',
      content: Text('Are you sure you want to delete this invoice?'),
      confirm: ElevatedButton(
        onPressed: () {
          controller.deleteInvoice(id);
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
