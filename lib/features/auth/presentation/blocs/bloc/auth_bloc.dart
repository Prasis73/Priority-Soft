import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/features/auth/domain/usecases/login_usecase.dart';
import 'package:get_shoes/features/auth/domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({required this.loginUseCase, required this.registerUseCase})
      : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthFailure(error: 'Failed to sign in'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(
          event.email, event.password, event.fullName, event.phoneNumber);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthFailure(error: 'Failed to register'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await loginUseCase.authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
