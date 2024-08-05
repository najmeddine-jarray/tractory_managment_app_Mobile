import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tractory/utils/constants.dart';
import 'dart:convert';
import '../models/tractor_Model.dart';

class TractorService extends GetxService {
  final String baseUrl = '${Constants.baseUrl}/tractors';

  Future<List<Tractor>> getAllTractors() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Tractor.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load tractors');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Tractor> createTractor(Tractor tractor) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tractor.toJson()),
    );
    if (response.statusCode == 201) {
      return Tractor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create tractor');
    }
  }

  Future<Tractor> updateTractor(Tractor tractor) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${tractor.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tractor.toJson()),
    );
    if (response.statusCode == 200) {
      return Tractor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update tractor');
    }
  }

  Future<void> deleteTractor(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete tractor');
    }
  }
}
