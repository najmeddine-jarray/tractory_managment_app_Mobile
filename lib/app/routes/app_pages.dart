import 'package:tractory/app/modules/client/client_bindings.dart';
import 'package:tractory/app/modules/client/client_page.dart';
import 'package:tractory/app/modules/driver/driver_bindings.dart';
import 'package:tractory/app/modules/driver/driver_page.dart';
import 'package:tractory/app/modules/equipement/equipement_bindings.dart';
import 'package:tractory/app/modules/equipement/equipement_page.dart';
import 'package:tractory/app/modules/expense/expense_page.dart';
import 'package:tractory/app/modules/home/Home_bindings.dart';
import 'package:tractory/app/modules/home/Home_page.dart';
import 'package:tractory/app/modules/invoice/invoice_bindings.dart';
import 'package:tractory/app/modules/invoice/invoice_page.dart';
import 'package:tractory/app/modules/rental/rental_bindings.dart';
import 'package:tractory/app/modules/rental/rental_page.dart';
import 'package:tractory/app/modules/report/report_bindings.dart';
import 'package:tractory/app/modules/report/report_page.dart';
import 'package:tractory/app/modules/tractor/tractor_bindings.dart';
import 'package:tractory/app/modules/tractor/tractor_page.dart';
import 'package:tractory/app/modules/usage/usage_bindings.dart';
import 'package:tractory/app/modules/usage/usage_page.dart';

import 'package:get/get.dart';

import '../modules/expense/expense_bindings.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.TRACTOR_MANAGEMENT,
      page: () => TractorPage(),
      binding: TractorBindings(),
    ),
    GetPage(
      name: Routes.CLIENT_MANAGEMENT,
      page: () => ClientPage(),
      binding: ClientBindings(),
    ),
    GetPage(
      name: Routes.RENTAL_MANAGEMENT,
      page: () => RentalPage(),
      binding: RentalBindings(),
    ),
    GetPage(
      name: Routes.INVOICE_MANAGEMENT,
      page: () => InvoicePage(),
      binding: InvoiceBindings(),
    ),
    GetPage(
      name: Routes.EXPENSE_MANAGEMENT,
      page: () => ExpensePage(),
      binding: ExpenseBindings(),
    ),
    GetPage(
      name: Routes.REPORT_MANAGEMENT,
      page: () => ReportPage(),
      binding: ReportBindings(),
    ),
    GetPage(
      name: Routes.DRIVER_MANAGEMENT,
      page: () => DriverPage(),
      binding: DriverBindings(),
    ),
    GetPage(
      name: Routes.USAGE_MANAGEMENT,
      page: () => UsagePage(),
      binding: UsageBindings(),
    ),
    GetPage(
      name: Routes.EQUIPMENT_MANAGEMENT,
      page: () => EquipmentPage(),
      binding: EquipementBindings(),
    ),
    // GetPage(
    //     name: Routes.HARVESTING_MACHINERY_MANAGEMENT,
    //     page: () => HarvestingMachineryManagementScreen()),
  ];
}
