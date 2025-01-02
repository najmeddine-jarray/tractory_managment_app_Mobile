import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tractory/utils/constants.dart';
import './report_controller.dart';

class ReportPage extends GetView<ReportController> {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Constants.azreg,
        toolbarHeight: 50,
        shape: const RoundedRectangleBorder(
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
                          width: width * .28,
                          height: height * .10,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.agriculture,
                                        size: 20, color: Constants.azreg),
                                    Text(
                                      "Tractors",
                                      style: Get.theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${controller.numberOfTractors.value}",
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .28,
                          height: height * .10,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.handyman_rounded,
                                        size: 20,
                                        color: Constants
                                            .azreg), // Replace with actual icon
                                    Text(
                                      "Equipes",
                                      style: Get.theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${controller.numberOfEquipments.value}",
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .28,
                          height: height * .10,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.person,
                                        size: 20,
                                        color: Constants
                                            .azreg), // Replace with actual icon
                                    Text(
                                      "Drivers",
                                      style: Get.theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${controller.numberOfDrivers.value}",
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   width: width * .8,
                    //   height: height * .12,
                    //   child: Card(
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Icon(Icons.attach_money,
                    //                 size: 25, color: Constants.azreg),
                    //             Text(
                    //               "Revenues",
                    //               style: Get.theme.textTheme.titleLarge,
                    //             ),
                    //           ],
                    //         ),
                    //         Text(
                    //           "${controller.totalRevenue.value.toStringAsFixed(2)} Dinar",
                    //           style: Get.theme.textTheme.headlineSmall,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * .28,
                          height: height * .12,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.group,
                                        size: 20, color: Constants.azreg),
                                    Text(
                                      "Clients",
                                      style: Get.theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${controller.numberOfClients.value}",
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .28,
                          height: height * .12,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.receipt,
                                        size: 20,
                                        color: Constants
                                            .azreg), // Replace with actual icon
                                    Text(
                                      "Factures",
                                      style: Get.theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${controller.numberOfInvoices.value}",
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .28,
                          height: height * .12,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.cancel,
                                        size: 20,
                                        color: Constants
                                            .azreg), // Replace with actual icon
                                    Text(
                                      "UnPaid",
                                      style: Get.theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${controller.noPay.value}",
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * .84,
                      height: height * .12,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.paid,
                                    size: 25, color: Constants.azreg),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Revenus",
                                  style: Get.theme.textTheme.titleLarge,
                                ),
                              ],
                            ),
                            Text(
                              "${controller.totalRevenue.value.toStringAsFixed(2)} Dinar",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.fetchReportData,
        backgroundColor: Constants.azreg,
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }
}
