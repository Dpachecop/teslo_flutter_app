import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_flutter_app/features/auth/domain/domain.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/repositories/auth_repository_impl.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/services/key_value_storage_service.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } catch (e) {
      logout(errorMessage: 'Error no identificado');
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>("token");
    if (token == null) return logout();
    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue("token", user.token);

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: user,
      errorMessage: '',
    );
  }

  Future<void> logout({String? errorMessage}) async {
    await keyValueStorageService.removeKey("token");
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
      errorMessage: errorMessage ?? '',
    );
  }
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
