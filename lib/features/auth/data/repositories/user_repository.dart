import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> addUser(String userId, String fullName, String phoneNumber) async {
    try {
      await _firebaseFirestore.collection('users').doc(userId).set({
        'fullName': fullName,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }
}
