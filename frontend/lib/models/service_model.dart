class ServiceModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String providerName;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.providerName,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      providerName: json['provider_name'] ?? 'Provider',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'provider_name': providerName,
    };
  }
}