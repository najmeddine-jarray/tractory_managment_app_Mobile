import 'package:get/get.dart';
import 'package:tractory/app/data/models/driver_Model.dart';
import 'package:tractory/app/data/services/driver_Services.dart';

class DriverController extends GetxController {
  var drivers = <Driver>[].obs;
  var filteredDrivers = <Driver>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  // Fetch all drivers from the API
  @override
  void onInit() {
    fetchDrivers();
    super.onInit();
  }

  void fetchDrivers() async {
    try {
      isLoading(true);
      var driverService = Get.find<DriverService>();
      var driverList = await driverService.getAllDrivers();
      drivers.assignAll(driverList);
      filteredDrivers.assignAll(driverList); // Initialize filteredDrivers
    } catch (e) {
      errorMessage('Failed to load drivers');
    } finally {
      isLoading(false);
    }
  }

  void filterDrivers(String query) {
    if (query.isEmpty) {
      filteredDrivers.assignAll(drivers);
    } else {
      filteredDrivers.assignAll(
          drivers.where((driver) => driver.name.toLowerCase().contains(query)));
      filteredDrivers.assignAll(drivers
          .where((driver) => driver.phone.toLowerCase().contains(query)));
      filteredDrivers.assignAll(drivers.where(
          (driver) => driver.licenseNumber.toLowerCase().contains(query)));
    }
  }

  // Add a new driver
  void addDriver(Driver driver) async {
    try {
      var driverService = Get.find<DriverService>();
      await driverService.createDriver(driver);
      fetchDrivers(); // Refresh the list after adding
    } catch (e) {
      errorMessage.value = 'Failed to add driver: $e';
    }
  }

  // Update an existing driver
  void updateDriver(Driver driver) async {
    try {
      var driverService = Get.find<DriverService>();
      await driverService.updateDriver(driver);
      fetchDrivers(); // Refresh the list after updating
    } catch (e) {
      errorMessage.value = 'Failed to update driver: $e';
    }
  }

  // Delete a driver
  void deleteDriver(int id) async {
    try {
      var driverService = Get.find<DriverService>();
      await driverService.deleteDriver(id);
      fetchDrivers(); // Refresh the list after deleting
    } catch (e) {
      errorMessage.value = 'Failed to delete driver: $e';
    }
  }
}
