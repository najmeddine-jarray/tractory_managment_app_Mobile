import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './OTP_controller.dart';

class OtpPage extends GetView<OtpController> {
    
    const OtpPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('OtpPage'),),
            body: Container(),
        );
    }
}