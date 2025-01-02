class Invoice {
  int? id;
  int usageId;
  double totalPrice;
  String paymentStatus;

  Invoice({
    this.id,
    required this.usageId,
    required this.totalPrice,
    this.paymentStatus = 'Pending',
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      usageId: json['usage_id'],
      totalPrice: (json['total_price'] as num).toDouble(),
      paymentStatus: json['payment_status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usage_id': usageId,
      'total_price': totalPrice,
      'payment_status': paymentStatus,
    };
  }

  // Add copyWith method
  Invoice copyWith({
    int? id,
    int? usageId,
    double? totalPrice,
    String? paymentStatus,
  }) {
    return Invoice(
      id: id ?? this.id,
      usageId: usageId ?? this.usageId,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }

  // Override toString() method
  @override
  String toString() {
    return 'Invoice(id: $id, usageId: $usageId, totalPrice: $totalPrice, paymentStatus: $paymentStatus)';
  }
}
