import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_flutter_app/features/auth/domain/domain.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/repositories/auth_repository_impl.dart';

final AuthProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void loginUser(String email, String password) async {}
  void registerUser(String email, String password) async {}
  void checkStatus(String email, String password) async {}
}

enum AuthStatus { authenticated, unauthenticated, checking }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String errorMessage;

  AuthState({
    this.status = AuthStatus.unauthenticated,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
