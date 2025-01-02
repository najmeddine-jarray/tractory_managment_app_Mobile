import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './Splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<SplashController>(
        builder: (controller) {
          return Stack(
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: MediaQuery.of(context).size.height /
                        controller.fontSize,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    opacity: controller.textOpacity,
                    child: const Text(
                      'Sanity APP',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Fixed size for text
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  opacity: controller.containerOpacity,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 2000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: MediaQuery.of(context).size.width /
                          controller.containerSize,
                      width: MediaQuery.of(context).size.width /
                          controller.containerSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png', // Ensure this path matches the actual file location
                        // Adjust size as needed
                      )

                      // child: Image.asset(
                      //   'assets/images/logo.png',
                      //   scale: 1,
                      // )
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
