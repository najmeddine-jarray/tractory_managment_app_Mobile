import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './Login_controller.dart';

class LoginPage extends GetView<LoginController> {
    
    const LoginPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('LoginPage'),),
            body: Container(),
        );
    }
}