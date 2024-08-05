// lib/data/services/rental_service.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tractory/utils/constants.dart';
import 'dart:convert';
import '../models/rental_Model.dart';

class RentalService extends GetxService {
  final baseUrl = '${Constants.baseUrl}/rentals';

  Future<List<Rental>> getAllRentals() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Rental.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load rentals');
    }
  }

  Future<void> addRental(Rental rental) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rental.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add rental');
    }
  }

  Future<void> updateRental(Rental rental) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${rental.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(rental.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update rental');
      }
    } catch (e) {
      throw Exception('Failed to update rental: $e');
    }
  }

  Future<void> deleteRental(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete rental');
    }
  }
}
