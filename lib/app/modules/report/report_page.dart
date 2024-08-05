import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tractory/utils/constants.dart';
import './report_controller.dart';

class ReportPage extends GetView<ReportController> {
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Constants.azreg,
        actions: [
          IconButton(
              onPressed: () {
                controller.fetchReportData(); // Refresh data
              },
              icon: Icon(
                Icons.refresh_outlined,
              ))
        ],
        toolbarHeight: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Obx(() => Column(
              children: [
                // Report List
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * .39,
                          height: height * .12,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Tractors",
                                  style: Get.theme.textTheme.titleLarge,
                                ),
                                Text(
                                  "${controller.numberOfTractors.value}",
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(),
                        SizedBox(
                          width: width * .39,
                          height: height * .12,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Clients",
                                  style: Get.theme.textTheme.titleLarge,
                                ),
                                Text(
                                  "${controller.numberOfClients.value}",
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * .8,
                      height: height * .12,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Revenue",
                              style: Get.theme.textTheme.titleLarge,
                            ),
                            Text(
                              "\$${controller.totalRevenue.value.toStringAsFixed(2)}",
                              style: Get.theme.textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            )),
      ),
    );
  }
}
