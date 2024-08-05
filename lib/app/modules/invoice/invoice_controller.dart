// lib/controllers/invoice_controller.dart
import 'package:get/get.dart';
import '../../data/models/invoice_Model.dart';
import '../../data/services/invoice_Services.dart';

class InvoiceController extends GetxController {
  var invoiceList = <Invoice>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchInvoices();
    super.onInit();
  }

  void fetchInvoices() async {
    try {
      isLoading(true);
      var invoiceService = Get.find<InvoiceService>();
      var invoices = await invoiceService.getAllInvoices();
      invoiceList.assignAll(invoices);
    } finally {
      isLoading(false);
    }
  }

  void addInvoice(Invoice invoice) async {
    try {
      var invoiceService = Get.find<InvoiceService>();
      await invoiceService.addInvoice(invoice);
      fetchInvoices();
    } catch (e) {
      print("Error adding invoice: $e");
    }
  }

  void updateInvoice(Invoice invoice) async {
    try {
      var invoiceService = Get.find<InvoiceService>();
      await invoiceService.updateInvoice(invoice);
      fetchInvoices();
    } catch (e) {
      print("Error updating invoice: $e");
    }
  }

  void deleteInvoice(int id) async {
    try {
      var invoiceService = Get.find<InvoiceService>();
      await invoiceService.deleteInvoice(id);
      fetchInvoices();
    } catch (e) {
      print("Error deleting invoice: $e");
    }
  }
}
