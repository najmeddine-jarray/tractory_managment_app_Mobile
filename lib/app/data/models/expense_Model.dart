import 'package:intl/intl.dart';

class Expense {
  int? id;
  int tractorId;
  double fuelCost;
  DateTime date;

  Expense({
    this.id,
    required this.tractorId,
    required this.fuelCost,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      tractorId: json['tractor_id'],
      fuelCost: (json['fuel_cost'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tractor_id': tractorId,
      'fuel_cost': fuelCost,
      'date': DateFormat('MM-dd-yyyy').format(date),
    };
  }
}
