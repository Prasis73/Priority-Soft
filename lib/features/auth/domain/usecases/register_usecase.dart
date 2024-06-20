import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_shoes/features/auth/data/repositories/auth_repository.dart';
import 'package:get_shoes/features/auth/data/repositories/user_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  RegisterUseCase({required this.authRepository, required this.userRepository});

  Future<User?> call(String email, String password, String fullName,
      String phoneNumber) async {
    User? user =
        await authRepository.registerWithEmailAndPassword(email, password);
    if (user != null) {
      await userRepository.addUser(user.uid, fullName, phoneNumber);
    }
    return user;
  }
}
