import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_shoes/features/products/data/models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProducts({Map<String, dynamic>? filters}) async {
    Query query = _firestore.collection('products');

    if (filters != null) {
      if (filters.containsKey('brand') && filters['brand'] != null) {
        query = query.where("brand", isEqualTo: filters['brand']);
      }
      if (filters.containsKey('priceRange') && filters['priceRange'] != null) {
        query = query
            .where("price",
                isGreaterThanOrEqualTo: filters['priceRange']['min'])
            .where("price", isLessThanOrEqualTo: filters['priceRange']['max']);
      }
      if (filters.containsKey('colors') && filters['colors'] != null) {
        query = query.where("colors", arrayContains: filters['colors']);
      }
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
  }

}
