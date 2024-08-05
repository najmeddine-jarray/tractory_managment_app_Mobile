import 'package:get/get.dart';
import '../../data/models/rental_Model.dart';
import '../../data/services/rental_Services.dart';
import '../../data/models/client_Model.dart';
import '../../data/models/tractor_Model.dart';
import '../../data/models/equipment_Model.dart';
import '../../data/services/client_Services.dart';
import '../../data/services/tractor_Services.dart';
import '../../data/services/equipment_Services.dart';

class RentalController extends GetxController {
  var rentalList = <Rental>[].obs;
  var filteredRentals = <Rental>[].obs;
  var clientList = <Client>[].obs;
  var tractorList = <Tractor>[].obs;
  var equipmentList = <Equipment>[].obs;
  var isLoading = true.obs;

  var filterText = ''.obs; // Observing the filter text
  Future<void> fetchAllData() async {
    try {
      isLoading(true);
      // Fetch all data concurrently
      await Future.wait<void>([
        fetchRentals(),
        fetchClients(),
        fetchTractors(),
        fetchEquipment(),
      ]);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  Future<void> fetchRentals() async {
    try {
      isLoading(true);
      var rentalService = Get.find<RentalService>();
      var rentals = await rentalService.getAllRentals();
      rentalList.assignAll(rentals);
      applyFilter(); // Apply filter after fetching rentals
    } catch (e) {
      print("Error fetching rentals: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchClients() async {
    try {
      var clientService = Get.find<ClientService>();
      var clients = await clientService.getAllClients();
      clientList.assignAll(clients);
    } catch (e) {
      print("Error fetching clients: $e");
    }
  }

  Future<void> fetchTractors() async {
    try {
      var tractorService = Get.find<TractorService>();
      var tractors = await tractorService.getAllTractors();
      tractorList.assignAll(tractors);
    } catch (e) {
      print("Error fetching tractors: $e");
    }
  }

  Future<void> fetchEquipment() async {
    try {
      var equipmentService = Get.find<EquipmentService>();
      var equipment = await equipmentService.getAllEquipment();
      equipmentList.assignAll(equipment);
    } catch (e) {
      print("Error fetching equipment: $e");
    }
  }

  void applyFilter() {
    var query = filterText.value.toLowerCase();
    filteredRentals.value = rentalList.where((rental) {
      final clientName = clientList
          .firstWhere((client) => client.id == rental.clientId,
              orElse: () => Client(name: '', phone: '', address: ''))
          .name
          .toLowerCase();
      final tractorName = tractorList
          .firstWhere((tractor) => tractor.id == rental.tractorId,
              orElse: () => Tractor(name: '', type: '', image: '', power: 0))
          .name
          .toLowerCase();
      final equipmentName = equipmentList
          .firstWhere((equipment) => equipment.id == rental.equipmentId,
              orElse: () =>
                  Equipment(name: '', type: '', image: '', priceHours: 0))
          .name
          .toLowerCase();

      return clientName.contains(query) ||
          tractorName.contains(query) ||
          equipmentName.contains(query);
    }).toList();

    // Order by date, with most recent first
    filteredRentals.sort((a, b) => b.rentalDate.compareTo(a.rentalDate));
  }

  void setFilterText(String text) {
    filterText.value = text;
    applyFilter();
  }

  void addRental(Rental rental) async {
    try {
      var rentalService = Get.find<RentalService>();
      await rentalService.addRental(rental);
      fetchRentals();
    } catch (e) {
      print("Error adding rental: $e");
    }
  }

  void updateRental(Rental rental) async {
    try {
      var rentalService = Get.find<RentalService>();
      await rentalService.updateRental(rental);
      fetchRentals();
    } catch (e) {
      fetchRentals();

      // print("Error updating rental: $e");
    }
  }

  void deleteRental(int id) async {
    try {
      var rentalService = Get.find<RentalService>();
      await rentalService.deleteRental(id);
      fetchRentals();
    } catch (e) {
      print("Error deleting rental: $e");
    }
  }
}
