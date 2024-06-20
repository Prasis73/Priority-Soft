import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;

  RegisterRequested({required this.email, required this.password, required this.fullName, required this.phoneNumber});

  @override
  List<Object?> get props => [email, password, fullName, phoneNumber];
}

class LogoutRequested extends AuthEvent {}
