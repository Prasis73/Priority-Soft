import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final List<dynamic> imageUrl;
  final int price;
  final int reviewsCount;
  final int averageRating;
  final String brand;
  final List<dynamic> colors;
  final String description;
  final List<dynamic> sizes;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.reviewsCount,
    required this.averageRating,
    required this.brand,
    required this.colors,
    required this.description,
    required this.sizes,
  });

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Product(
      id: data['id'] ?? '',
      name: data['name'] ?? "",
      imageUrl: List<String>.from(data['imageUrl']),
      price: data['price'] ?? 0,
      reviewsCount: data['reviewsCount'] ?? 0,
      averageRating: data['averageRating'] ?? 0,
      brand: data['brand'] ?? "",
      colors: List<String>.from(data['colors']),
      description: data['description'] ?? "",
      sizes: List<String>.from(data['sizes']),
    );
  }

  Product copyWith({
    String? id,
    String? name,
    List<dynamic>? imageUrl,
    int? price,
    int? reviewsCount,
    int? averageRating,
    String? brand,
    List<dynamic>? colors,
    String? description,
    List<dynamic>? sizes,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      averageRating: averageRating ?? this.averageRating,
      brand: brand ?? this.brand,
      colors: colors ?? this.colors,
      description: description ?? this.description,
      sizes: sizes ?? this.sizes,
    );
  }
}
