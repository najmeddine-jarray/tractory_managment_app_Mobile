import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tractory/utils/constants.dart';
import 'dart:convert';
import '../models/driver_Model.dart';

class DriverService extends GetxService {
  // Base URL for the API
  final String baseUrl = '${Constants.baseUrl}/drivers';

  // Method to get all drivers
  Future<List<Driver>> getAllDrivers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((driver) => Driver.fromJson(driver)).toList();
    } else {
      throw Exception('Failed to load drivers: ${response.reasonPhrase}');
    }
  }

  // Method to create a new driver
  Future<Driver> createDriver(Driver driver) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(driver.toJson()),
    );

    if (response.statusCode == 201) {
      return Driver.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create driver: ${response.reasonPhrase}');
    }
  }

  // Method to update an existing driver
  Future<Driver> updateDriver(Driver driver) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${driver.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(driver.toJson()),
    );

    if (response.statusCode == 200) {
      return Driver.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update driver: ${response.reasonPhrase}');
    }
  }

  // Method to delete a driver
  Future<void> deleteDriver(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete driver: ${response.reasonPhrase}');
    }
  }
}
