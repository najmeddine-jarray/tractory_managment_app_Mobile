import 'package:get/get.dart';
import 'package:tractory/app/data/services/client_Services.dart';
import 'package:tractory/app/modules/client/client_controller.dart';

class ClientBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientService>(() => ClientService()); // Register ClientService
    Get.lazyPut<ClientController>(() => ClientController());
  }
}
