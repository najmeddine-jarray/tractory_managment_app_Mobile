import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractory/utils/constants.dart';
import '../../data/models/client_Model.dart';
import 'client_controller.dart';

class ClientPage extends GetView<ClientController> {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Clients',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Constants.azreg,
        toolbarHeight: 50,
        actions: [
          IconButton(
              onPressed: () => controller.fetchClients(),
              icon: const Icon(
                Icons.refresh_outlined,
              ))
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: controller.filterController,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Filter by Client name',
                    prefixIcon: const Icon(Icons.search_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (controller.errorMessage.value.isNotEmpty) {
          return Center(
              child: Text(controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red)));
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: controller.filterController,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Filter by Client name',
                    prefixIcon: Icon(Icons.search_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.filteredClients.isEmpty) {
                    return Center(child: Text('No results'));
                  } else {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                      child: ListView.builder(
                        itemCount: controller.filteredClients.length,
                        itemBuilder: (context, index) {
                          final client = controller.filteredClients[index];
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header Row: Icon, Title, and Action Buttons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.person_outline,
                                            size: 24,
                                            color: Colors.blueGrey,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "${client.id} | ${client.name}",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Constants.azreg),
                                            tooltip: "Edit Client",
                                            onPressed: () => _showClientDialog(
                                                context,
                                                client: client),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            tooltip: "Delete Client",
                                            onPressed: () => Get.defaultDialog(
                                              title: 'Delete Client',
                                              middleText:
                                                  'Are you sure you want to delete this client?',
                                              confirm: ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .deleteClient(client.id!);
                                                  Get.back(); // Close dialog
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                                child: const Text('Delete'),
                                              ),
                                              cancel: TextButton(
                                                onPressed: () =>
                                                    Get.back(), // Close dialog
                                                child: const Text('Cancel'),
                                              ),
                                              titlePadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0),
                                              contentPadding:
                                                  const EdgeInsets.all(20.0),
                                              radius: 10.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      thickness: 1, color: Colors.grey),
                                  const SizedBox(height: 10),
                                  // Client Details
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        client.phone,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          client.address,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showClientDialog(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Constants.azreg,
      ),
    );
  }

  void _showClientDialog(BuildContext context, {Client? client}) {
    final isEdit = client != null;
    final nameController =
        TextEditingController(text: isEdit ? client!.name : '');
    final phoneController =
        TextEditingController(text: isEdit ? client!.phone : '');
    final addressController =
        TextEditingController(text: isEdit ? client!.address : '');

    final _formKey = GlobalKey<FormState>(); // Key for the Form
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    Get.defaultDialog(
      title: isEdit ? 'Edit Client' : 'Add Client',
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  hintText: "Name",
                  prefixIcon: const Icon(Icons.person, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLength: 50, // Set maximum length here
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  } else if (value.length > 50) {
                    return 'Name cannot be more than 50 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  hintText: "Phone",
                  prefixIcon: const Icon(Icons.phone, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLength: 15, // Set maximum length here
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  } else if (value.length > 15) {
                    return 'Phone number cannot be more than 15 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  hintText: "Address",
                  prefixIcon: const Icon(Icons.location_on, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLength: 100, // Set maximum length here
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  } else if (value.length > 100) {
                    return 'Address cannot be more than 100 characters';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            final newClient = Client(
              id: isEdit ? client!.id : null,
              name: nameController.text,
              phone: phoneController.text,
              address: addressController.text,
            );

            if (isEdit) {
              controller.updateClient(newClient);
            } else {
              controller.addClient(newClient);
            }

            Get.back(); // Close dialog
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Constants.azreg : Constants.ktiba),
        child: Text(
          isEdit ? 'Update Client' : 'Add Client',
          style: TextStyle(
              color: isDark ? Constants.secondaryColor : Constants.azreg),
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(), // Close dialog
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.red),
        ),
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      contentPadding: const EdgeInsets.all(20),
      radius: 10,
    );
  }
}
