import 'package:get/get.dart';
import '../../data/services/expense_Services.dart';
import './expense_controller.dart';

class ExpenseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseService>(() => ExpenseService());
    Get.lazyPut<ExpenseController>(() => ExpenseController());
  }
}
