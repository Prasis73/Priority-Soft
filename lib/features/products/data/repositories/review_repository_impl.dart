import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get_shoes/features/products/data/models/review_model.dart';

class ReviewRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Review>> getReview({String? id}) async {
    final querySnapshot = id == null
        ? await _firestore.collection('review').get()
        : await _firestore
            .collection('review')
            .where("productId", isEqualTo: id)
            .get();

    return querySnapshot.docs.map((doc) => Review.fromSnapshot(doc)).toList();
  }
}
