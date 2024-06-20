class CartItem {
  final String id;
  final String productId;
  final String userId;
  final String color;
  final int size;
  final int quantity;
  final int price;
  final String brand;
  final String name;
  final String image;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
    required this.brand,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'color': color,
      'size': size,
      'quantity': quantity,
      'price': price,
      'brand': brand,
      'name': name,
      'image': image,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      userId: map['userId'],
      productId: map['productId'],
      color: map['color'],
      size: map['size'],
      quantity: map['quantity'],
      price: map['price'],
      brand: map['brand'],
      name: map['name'],
      image: map['image'],
    );
  }

  CartItem copyWith({
    String? id,
    String? productId,
    String? brand,
    String? userId,
    String? color,
    int? size,
    int? quantity,
    int? price,
    String? name,
    String? image,
  }) {
    return CartItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }
}
