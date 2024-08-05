import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/expense_Model.dart';

class ExpenseService extends GetxService {
  Future<List<Expense>> getAllExpenses() async {
    final response = await http.get(
        Uri.parse('https://tractor-managment-app-node.onrender.com/expenses'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Expense.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<void> addExpense(Expense expense) async {
    final response = await http.post(
      Uri.parse('https://tractor-managment-app-node.onrender.com/expenses'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add expense');
    }
  }

  Future<void> updateExpense(Expense expense) async {
    final response = await http.put(
      Uri.parse(
          'https://tractor-managment-app-node.onrender.com/expenses/${expense.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expense.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update expense');
    }
  }

  Future<void> deleteExpense(int id) async {
    final response = await http.delete(Uri.parse(
        'https://tractor-managment-app-node.onrender.com/expenses/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete expense');
    }
  }
}
