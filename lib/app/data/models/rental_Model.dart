import 'package:intl/intl.dart';

class Rental {
  int? id;
  int clientId;
  int tractorId;
  int equipmentId;
  DateTime rentalDate;

  Rental({
    this.id,
    required this.clientId,
    required this.tractorId,
    required this.equipmentId,
    required this.rentalDate,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      id: json['id'],
      clientId: json['client_id'],
      tractorId: json['tractor_id'],
      equipmentId: json['equipment_id'],
      rentalDate: DateTime.parse(json['rental_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'tractor_id': tractorId,
      'equipment_id': equipmentId,
      'rental_date': DateFormat('MM-dd-yyyy').format(rentalDate),
    };
  }
}
