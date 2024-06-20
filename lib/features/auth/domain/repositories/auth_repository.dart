import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> registerWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
