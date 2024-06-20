import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_shoes/features/auth/data/repositories/auth_repository.dart';


class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<User?> call(String email, String password) async {
    return await authRepository.signInWithEmailAndPassword(email, password);
  }
}
