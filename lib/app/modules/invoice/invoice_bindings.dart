import 'package:get/get.dart';
import '../../data/services/invoice_Services.dart';
import './invoice_controller.dart';

class InvoiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceService>(() => InvoiceService());
    Get.lazyPut<InvoiceController>(() => InvoiceController());
  }
}
