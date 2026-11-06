class OrderModel {
  final int id;
  final String serviceTitle;
  final String customerName;
  final double totalPrice;
  final String status;

  OrderModel({
    required this.id,
    required this.serviceTitle,
    required this.customerName,
    required this.totalPrice,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      serviceTitle: json['service_title'] ?? '',
      customerName: json['customer_name'] ?? '',
      totalPrice: double.parse(json['total_price'].toString()),
      status: json['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_title': serviceTitle,
      'customer_name': customerName,
      'total_price': totalPrice,
      'status': status,
    };
  }
}