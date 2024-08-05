// lib/data/services/equipment_service.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tractory/utils/constants.dart';
import 'dart:convert';

import '../models/equipment_Model.dart';

class EquipmentService extends GetxService {
  final String baseUrl = '${Constants.baseUrl}/equipments';

  Future<List<Equipment>> getAllEquipment() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Equipment.fromJson(item)).toList();
      } else {
        print('Failed to load equipment: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<void> createEquipment(Equipment equipment) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(equipment.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create equipment');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> updateEquipment(Equipment equipment) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${equipment.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(equipment.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update equipment');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> deleteEquipment(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete equipment');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
