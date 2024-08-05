class Client {
  int? id;
  String name;
  String phone;
  String address;

  Client(
      {this.id,
      required this.name,
      required this.phone,
      required this.address});

  // Factory method to create a Client instance from JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  // Method to convert a Client instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
    };
  }
}
