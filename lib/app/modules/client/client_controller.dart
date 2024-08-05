import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/client_Model.dart';
import '../../data/services/client_Services.dart';

class ClientController extends GetxController {
  var clients = <Client>[].obs;
  var filteredClients = <Client>[].obs; // For storing filtered clients
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  TextEditingController filterController = TextEditingController();

  @override
  void onInit() {
    fetchClients();
    filterController
        .addListener(filterClients); // Listen to changes in filter text
    super.onInit();
  }

  void fetchClients() async {
    try {
      isLoading.value = true;
      var clientService = Get.find<ClientService>();
      var clientList = await clientService.getAllClients();
      clients.assignAll(clientList);
      filterClients(); // Apply filter after fetching clients
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Failed to load clients: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void filterClients() {
    String filter = filterController.text.toLowerCase();
    if (filter.isEmpty) {
      filteredClients.assignAll(clients); // Show all if no filter
    } else {
      filteredClients.assignAll(clients
          .where((client) =>
              client.name.toLowerCase().contains(filter) ||
              client.phone.toLowerCase().contains(filter) ||
              client.address.toLowerCase().contains(filter))
          .toList());
    }
  }

  @override
  void onClose() {
    filterController.dispose(); // Dispose of controller when not needed
    super.onClose();
  }

  void addClient(Client client) async {
    try {
      var clientService = Get.find<ClientService>();
      await clientService.createClient(client);
      fetchClients();
    } catch (e) {
      errorMessage.value = 'Failed to add client: $e';
    }
  }

  void updateClient(Client client) async {
    try {
      var clientService = Get.find<ClientService>();
      await clientService.updateClient(client);
      fetchClients();
    } catch (e) {
      errorMessage.value = 'Failed to update client: $e';
    }
  }

  void deleteClient(int id) async {
    try {
      var clientService = Get.find<ClientService>();
      await clientService.deleteClient(id);
      fetchClients();
    } catch (e) {
      errorMessage.value = 'Failed to delete client: $e';
    }
  }
}
