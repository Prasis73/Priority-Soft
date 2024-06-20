import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String comment;
  final Timestamp date;
  final String productId;
  final int rating;
  final String userId;

  Review({
    required this.id,
    required this.comment,
    required this.date,
    required this.productId,
    required this.rating,
    required this.userId,
  });

  factory Review.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Review(
      id: data['id'] ?? '',
      comment: data['comment'] ?? '',
      date: data['date'],
      productId: data['productId'] ?? '',
      rating: data['rating'] ?? 1,
      userId: data['userId'] ?? '',
    );
  }

  Review copyWith({
    String? id,
    String? comment,
    Timestamp? date,
    String? productId,
    int? rating,
    String? userId,
  }) {
    return Review(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      productId: productId ?? this.productId,
      rating: rating ?? this.rating,
      userId: userId ?? this.userId,
    );
  }
}
