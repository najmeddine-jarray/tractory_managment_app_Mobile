import 'package:get/get.dart';
import '../../data/models/tractor_Model.dart';
import '../../data/services/tractor_Services.dart';

class TractorController extends GetxController {
  var tractorList = <Tractor>[].obs;
  var filteredTractors = <Tractor>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchTractors();
    super.onInit();
  }

  void fetchTractors() async {
    try {
      isLoading(true);
      var tractorService = Get.find<TractorService>();
      var tractors = await tractorService.getAllTractors();
      tractorList.assignAll(tractors);
      filteredTractors.assignAll(tractors); // Initialize filteredTractors
    } catch (e) {
      var tractorService = Get.find<TractorService>();
      var tractors = await tractorService.getAllTractors();
      tractorList.assignAll(tractors);
      filteredTractors.assignAll(tractors);
      // errorMessage('Failed to load tractors');
    } finally {
      isLoading(false);
    }
  }

  void filterTractors(String query) {
    if (query.isEmpty) {
      filteredTractors
          .assignAll(tractorList); // Show all tractors if query is empty
    } else {
      filteredTractors.assignAll(tractorList.where((tractor) =>
          tractor.name.toLowerCase().contains(query) ||
          tractor.type.toLowerCase().contains(query)));
    }
  }

  void addTractor(Tractor tractor) async {
    try {
      var tractorService = Get.find<TractorService>();
      await tractorService.createTractor(tractor);
      fetchTractors();
    } catch (e) {
      errorMessage.value = 'Failed to add tractor: $e';
    }
  }

  void updateTractor(Tractor tractor) async {
    try {
      var tractorService = Get.find<TractorService>();
      await tractorService.updateTractor(tractor);
      fetchTractors();
    } catch (e) {
      fetchTractors();

      errorMessage.value = 'Failed to update tractor: $e';
    }
  }

  void deleteTractor(int id) async {
    try {
      var tractorService = Get.find<TractorService>();
      await tractorService.deleteTractor(id);
      fetchTractors();
    } catch (e) {
      errorMessage.value = 'Failed to delete tractor: $e';
    }
  }
}
