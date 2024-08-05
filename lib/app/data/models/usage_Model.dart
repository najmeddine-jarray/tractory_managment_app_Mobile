import 'package:intl/intl.dart';

class Usage {
  int? id;
  int tractorId;
  int equipmentId;
  int driverId;
  int rentalId;
  String location;
  int? invoiceId;
  DateTime startTime;
  DateTime endTime;
  double
      hoursUsed; // Make sure this is double if the data is a floating-point number
  String taskDescription;

  Usage({
    this.id,
    required this.tractorId,
    required this.equipmentId,
    required this.driverId,
    required this.rentalId,
    required this.location,
    this.invoiceId,
    required this.startTime,
    required this.endTime,
    required this.hoursUsed,
    required this.taskDescription,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      id: json['id'],
      tractorId: json['tractor_id'],
      equipmentId: json['equipment_id'],
      driverId: json['driver_id'],
      rentalId: json['rental_id'],
      location: json['location'],
      invoiceId: json['invoice_id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      hoursUsed: (json['hours_used'] as num).toDouble(), // Convert to double
      taskDescription: json['task_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tractor_id': tractorId,
      'equipment_id': equipmentId,
      'driver_id': driverId,
      'rental_id': rentalId,
      'location': location,
      'invoice_id': invoiceId,
      'start_time': DateFormat('MM-dd-yyyy HH:mm:ss').format(startTime),
      'end_time': DateFormat('MM-dd-yyyy HH:mm:ss').format(endTime),
      'hours_used': hoursUsed,
      'task_description': taskDescription,
    };
  }
}
