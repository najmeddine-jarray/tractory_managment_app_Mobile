part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const TRACTOR_MANAGEMENT = _Paths.TRACTOR_MANAGEMENT;
  static const CLIENT_MANAGEMENT = _Paths.CLIENT_MANAGEMENT;
  static const RENTAL_MANAGEMENT = _Paths.RENTAL_MANAGEMENT;
  static const INVOICE_MANAGEMENT = _Paths.INVOICE_MANAGEMENT;
  static const EXPENSE_MANAGEMENT = _Paths.EXPENSE_MANAGEMENT;
  static const REPORT_MANAGEMENT = _Paths.REPORT_MANAGEMENT;
  static const DRIVER_MANAGEMENT = _Paths.DRIVER_MANAGEMENT;
  static const USAGE_MANAGEMENT = _Paths.USAGE_MANAGEMENT;
  static const EQUIPMENT_MANAGEMENT = _Paths.EQUIPMENT_MANAGEMENT;
  static const HARVESTING_MACHINERY_MANAGEMENT =
      _Paths.HARVESTING_MACHINERY_MANAGEMENT;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const TRACTOR_MANAGEMENT = '/tractor-management';
  static const CLIENT_MANAGEMENT = '/client-management';
  static const RENTAL_MANAGEMENT = '/rental-management';
  static const INVOICE_MANAGEMENT = '/invoice-management';
  static const EXPENSE_MANAGEMENT = '/expense-management';
  static const REPORT_MANAGEMENT = '/report-management';
  static const DRIVER_MANAGEMENT = '/driver-management';
  static const USAGE_MANAGEMENT = '/usage-management';
  static const EQUIPMENT_MANAGEMENT = '/equipment-management';
  static const HARVESTING_MACHINERY_MANAGEMENT =
      '/harvesting-machinery-management';
}
