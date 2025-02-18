import 'dart:convert';

class ProductModel {
  final String productName;
  final double price;
  final double quantity;
  final String description;
  final String category;
  final List<String> images;
  final String? id;

  ProductModel({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.images,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'description': description,
      'category': category,
      'images': images,
      'id': id,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productName: map['productName'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      images: List<String>.from(map['images']),
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
