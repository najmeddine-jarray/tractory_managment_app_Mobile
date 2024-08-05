import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tractory/utils/constants.dart';
import 'dart:convert';

import '../models/expense_Model.dart';

class ExpenseService extends GetxService {
  final String baseUrl = '${Constants.baseUrl}/expenses';
  Future<List<Expense>> getAllExpenses() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Expense.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<void> addExpense(Expense expense) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add expense');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${expense.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update expense');
    }
  }

  Future<void> deleteExpense(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete expense');
    }
  }
}
