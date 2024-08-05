import 'package:get/get.dart';
import 'package:tractory/app/data/services/client_Services.dart';
import 'package:tractory/app/data/services/tractor_Services.dart';

import '../../data/services/invoice_Services.dart';

class ReportController extends GetxController {
  final TractorService tractorService = Get.find<TractorService>();
  final ClientService clientService = Get.find<ClientService>();
  final InvoiceService invoiceService = Get.find<InvoiceService>();

  var numberOfTractors = 0.obs;
  var numberOfClients = 0.obs;
  var totalRevenue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReportData();
  }

  void fetchReportData() async {
    try {
      // Fetch number of tractors
      final tractors = await tractorService.getAllTractors();
      numberOfTractors.value = tractors.length;

      // Fetch number of clients
      final clients = await clientService.getAllClients();
      numberOfClients.value = clients.length;

      // Fetch invoices and calculate total revenue for paid invoices
      final invoices = await invoiceService.getAllInvoices();
      totalRevenue.value = invoices
          .where((invoice) => invoice.paymentStatus == 'Paid')
          .fold(0.0, (sum, invoice) => sum + invoice.totalPrice);
    } catch (e) {
      print("Error fetching report data: $e");
    }
  }
}
