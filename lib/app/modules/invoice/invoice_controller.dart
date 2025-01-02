// lib/controllers/invoice_controller.dart
import 'package:get/get.dart';
import '../../data/models/client_Model.dart';
import '../../data/models/invoice_Model.dart';
import '../../data/models/rental_Model.dart';
import '../../data/models/usage_Model.dart';
import '../../data/services/client_Services.dart';
import '../../data/services/invoice_Services.dart';
import '../../data/services/rental_Services.dart';
import '../../data/services/usage_Services.dart';

class InvoiceController extends GetxController {
  var invoiceList = <Invoice>[].obs;
  var isLoading = true.obs;
  var usageList = <Usage>[].obs; // قائمة البيانات الخاصة بـ Usage
  var rentalList = <Rental>[].obs; // قائمة بيانات Rental
  var clientList = <Client>[].obs; // قائمة بيانات العملاء

  @override
  void onInit() {
    fetchInvoices();
    fetchUsageData();

    fetchRentalData(); // جلب بيانات Rental
    // استدعاء الدالة لتحميل بيانات Usage
    fetchClientData(); // جلب بيانات العملاء

    super.onInit();
  }

  void fetchInvoices() async {
    try {
      isLoading(true);
      var invoiceService = Get.find<InvoiceService>();
      var invoices = await invoiceService.getAllInvoices();
      invoiceList.assignAll(invoices);

      // print("Invoices fetched: $invoices");
    } finally {
      isLoading(false);
    }
  }

  void fetchUsageData() async {
    try {
      var usageService = Get.find<UsageService>();
      var usages = await usageService.getAllUsage();
      usageList.assignAll(usages);
    } catch (e) {
      print("Error fetching usage data: $e");
    }
  }

  void fetchRentalData() async {
    try {
      var rentalService = Get.find<RentalService>();
      var rentals = await rentalService.getAllRentals();
      rentalList.assignAll(rentals);
    } catch (e) {
      print("Error fetching rental data: $e");
    }
  }

  void fetchClientData() async {
    try {
      var clientService = Get.find<ClientService>();
      var clients = await clientService.getAllClients();
      clientList.assignAll(clients);
    } catch (e) {
      print("Error fetching client data: $e");
    }
  }

  Usage? getUsageByUsageId(int usageId) {
    return usageList.firstWhereOrNull((usage) => usage.id == usageId);
  }

  Rental? getRentalById(int rentalId) {
    return rentalList.firstWhereOrNull((rental) => rental.id == rentalId);
  }

  Client? getClientById(int clientId) {
    return clientList.firstWhereOrNull((client) => client.id == clientId);
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
