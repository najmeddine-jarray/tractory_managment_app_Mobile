import 'package:get/get.dart';
import 'package:tractory/app/data/services/client_Services.dart';
import 'package:tractory/app/data/services/invoice_Services.dart';
import 'package:tractory/app/data/services/tractor_Services.dart';
import './report_controller.dart';

class ReportBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceService>(() => InvoiceService());
    Get.lazyPut<TractorService>(() => TractorService());
    Get.lazyPut<ClientService>(() => ClientService());
    Get.lazyPut<ReportController>(() => ReportController());
  }
}
