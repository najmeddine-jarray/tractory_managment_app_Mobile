import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  double fontSize = 2;
  double containerSize = 1.5;
  double textOpacity = 0.0;
  double containerOpacity = 0.0;

  @override
  void onInit() {
    super.onInit();
    _startSplashSequence();
  }

  void _startSplashSequence() async {
    await Future.delayed(const Duration(seconds: 2));
    fontSize = 1.1;
    update(); // Notify listeners

    await Future.delayed(const Duration(seconds: 2));
    containerSize = 2;
    containerOpacity = 1;
    textOpacity = 1.0;
    update(); // Notify listeners

    await Future.delayed(const Duration(seconds: 1));
    Get.offNamed(Routes.HOME); // Navigate to the next page
  }
}
