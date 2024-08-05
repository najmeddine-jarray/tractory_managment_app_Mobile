import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './Sign_controller.dart';

class SignPage extends GetView<SignController> {
    
    const SignPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('SignPage'),),
            body: Container(),
        );
    }
}