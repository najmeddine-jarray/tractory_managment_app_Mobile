// lib/data/services/invoice_service.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/invoice_Model.dart';

class InvoiceService extends GetxService {
  Future<List<Invoice>> getAllInvoices() async {
    final response = await http.get(
        Uri.parse('https://tractor-managment-app-node.onrender.com/invoices'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Invoice.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load invoices');
    }
  }

  Future<void> addInvoice(Invoice invoice) async {
    final response = await http.post(
      Uri.parse('https://tractor-managment-app-node.onrender.com/invoices'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(invoice.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create invoice');
    }
  }

  Future<void> updateInvoice(Invoice invoice) async {
    final response = await http.put(
      Uri.parse(
          'https://tractor-managment-app-node.onrender.com/invoices/${invoice.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(invoice.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update invoice');
    }
  }

  Future<void> deleteInvoice(int id) async {
    final response = await http.delete(
      Uri.parse('https://tractor-managment-app-node.onrender.com/invoices/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete invoice');
    }
  }
}
