// lib/ui/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractory/app/modules/client/client_page.dart';
import 'package:tractory/app/modules/driver/driver_page.dart';
import 'package:tractory/app/modules/equipement/equipement_page.dart';
import 'package:tractory/app/modules/expense/expense_page.dart';
import 'package:tractory/app/modules/home/Home_controller.dart';
import 'package:tractory/app/modules/invoice/invoice_page.dart';
import 'package:tractory/app/modules/rental/rental_page.dart';
import 'package:tractory/app/modules/report/report_page.dart';
import 'package:tractory/app/modules/tractor/tractor_page.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:tractory/app/modules/usage/usage_page.dart';
import 'package:tractory/utils/constants.dart';

class HomePage extends GetView<HomeController> {
  final List<Widget> _pages = [
    ReportPage(),
    DriverPage(),
    TractorPage(),
    EquipmentPage(),
    ExpensePage(),
    ClientPage(),
    RentalPage(),
    UsagePage(),
    InvoicePage(),
  ];

  final SideMenuController sideMenu = SideMenuController();

  @override
  Widget build(BuildContext context) {
    sideMenu.addListener((index) {
      controller.changePage(index);
    });
    final theme = Theme.of(context);
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: SideMenu(
                controller: sideMenu,
                style: SideMenuStyle(
                  displayMode: SideMenuDisplayMode.auto,
                  showHamburger: false,
                  arrowCollapse: Colors.cyan,
                  toggleColor: Colors.blueGrey,
                  hoverColor: Colors.blue[100],
                  unselectedIconColor:
                      isDark ? Constants.azreg : Constants.ktiba,
                  selectedHoverColor: Colors.blue[100],
                  selectedColor: Constants.azreg,
                  selectedTitleTextStyle: const TextStyle(color: Colors.white),
                  selectedIconColor: Colors.white,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                title: Column(
                  children: [
                    // ConstrainedBox(
                    //   constraints: const BoxConstraints(
                    //     maxHeight: 150,
                    //     maxWidth: 150,
                    //   ),
                    // ),
                    // const Divider(
                    //   height: 0,
                    //   indent: 8.0,
                    //   endIndent: 8.0,
                    // ),
                  ],
                ),
                items: [
                  SideMenuItem(
                    title: 'Report',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.dashboard),
                  ),
                  SideMenuItem(
                    title: 'Driver',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.person),
                  ),
                  SideMenuItem(
                    title: 'Tractor',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.agriculture),
                  ),
                  SideMenuItem(
                    title: 'Equipment',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.handyman),
                  ),
                  SideMenuItem(
                    title: 'Expense',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.paid),
                  ),
                  SideMenuItem(
                    title: 'Client',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.group_add),
                  ),
                  SideMenuItem(
                    title: 'Rental',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                  SideMenuItem(
                    title: 'Usage',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.electric_bolt),
                  ),
                  SideMenuItem(
                    title: 'Invoice',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      controller.changePage(index);
                    },
                    icon: Icon(Icons.attach_money),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              width: .5,
              endIndent: 0,
              indent: 5,
              color: isDark ? Colors.black : Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Obx(() {
                  return _pages[controller.selectedIndex.value];
                }),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Obx(() {
      //   return BottomNavigationBar(
      //     showUnselectedLabels: false,
      //     elevation: 10,
      //     fixedColor: Color.fromARGB(255, 5, 77, 172),
      //     unselectedItemColor: Colors.grey,
      //     type: BottomNavigationBarType.fixed,
      //     iconSize: 24,
      //     selectedFontSize: 14,
      //     currentIndex: controller.selectedIndex.value,
      //     onTap: (index) {
      //       controller.changePage(index);
      //       sideMenu.changePage(index);
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Drivers',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.track_changes_outlined),
      //         label: 'Tractor',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.polymer_sharp),
      //         label: 'Equipment',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.price_check_outlined),
      //         label: 'Expenses',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Client',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Rental',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Usage',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Invoice',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Report',
      //       ),
      //     ],
      //   );
      // }),
    );
  }
}
