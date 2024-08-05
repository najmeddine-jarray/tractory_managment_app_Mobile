class Driver {
  int? id;
  String name;
  String licenseNumber;
  String phone;

  Driver({
    this.id,
    required this.name,
    required this.licenseNumber,
    required this.phone,
  });

  // Factory method to create a Driver instance from JSON
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      name: json['name'] ?? '',
      licenseNumber: json['license_number'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // Method to convert a Driver instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'license_number': licenseNumber,
      'phone': phone,
    };
  }
}
