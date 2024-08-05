class Tractor {
  int? id;
  String type;
  String name;
  String image;
  int power;
  // double hoursUsed;
  String maintenanceStatus;

  Tractor({
    this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.power,
    // required this.hoursUsed,
    this.maintenanceStatus = 'Good',
  });

  factory Tractor.fromJson(Map<String, dynamic> json) {
    return Tractor(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      image: json['image'],
      power: json['power'],
      // hoursUsed: (json['hours_used'] ?? 0).toDouble(), // Convert to double
      maintenanceStatus: json['maintenance_status'] ?? 'Good',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'image': image,
      'power': power,
      // 'hours_used': hoursUsed,
      'maintenance_status': maintenanceStatus,
    };
  }
}
