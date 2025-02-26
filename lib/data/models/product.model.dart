import 'package:isar/isar.dart';

part 'product.model.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;

  final String name;
  final String photoUrl;
  final int productId;

  Product({
    required this.name,
    required this.photoUrl,
    required this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      photoUrl: json['photoUrl'],
      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photo_url': photoUrl,
      'product_id': productId,
    };
  }
}
