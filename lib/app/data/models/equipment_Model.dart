class Equipment {
  int? id;
  String type;
  String name;
  String image;
  // int hoursUsed;
  double priceHours;
  String maintenanceStatus;

  Equipment({
    this.id,
    required this.type,
    required this.name,
    required this.image,
    // required this.hoursUsed,
    required this.priceHours,
    this.maintenanceStatus = 'Good',
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      image: json['image'],
      // hoursUsed: json['hours_used'],
      priceHours: (json['Price_hours'] ?? 0)
          .toDouble(), // Provide a default value and convert to double
      maintenanceStatus: json['maintenance_status'] ?? 'Good',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'image': image,
      // 'hours_used': hoursUsed,
      'Price_hours': priceHours,
      'maintenance_status': maintenanceStatus,
    };
  }
}
