import 'package:intl/intl.dart';

class Report {
  int? id;
  String reportType;
  String content;
  DateTime date;

  Report({
    this.id,
    required this.reportType,
    required this.content,
    required this.date,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      reportType: json['report_type'],
      content: json['content'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report_type': reportType,
      'content': content,
      'date': DateFormat('MM-dd-yyyy HH:mm:ss').format(date),
    };
  }
}
