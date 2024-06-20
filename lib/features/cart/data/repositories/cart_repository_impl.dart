import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_shoes/features/cart/data/models/cart_item_model.dart';

class CartRepository {
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');
  Future<List<CartItem>> fetchCartItems() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final querySnapshot =
          await cartCollection.where('userId', isEqualTo: uid).get();
      return querySnapshot.docs
          .map((doc) => CartItem.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addCartItem(CartItem cartItem) async {
    try {
      DocumentReference docRef = await cartCollection.add(cartItem.toMap());
      String docId = docRef.id;
      await docRef.update({'id': docId});
    } catch (e) {
      print('Error adding cart item: $e');
    }
  }

  Future<void> updateCartItem(CartItem cartItem) async {
    try {
      await cartCollection.doc(cartItem.id).update(cartItem.toMap());
    } catch (e) {
      print('Error updating cart item: $e');
    }
  }

  Future<void> removeCartItem(String cartItemId) async {
    try {
      await cartCollection.doc(cartItemId).delete();
    } catch (e) {
      print('Error removing cart item: $e');
    }
  }
}
