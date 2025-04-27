import 'package:teslo_flutter_app/features/auth/domain/domain.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/datasources/auth_datasources_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({AuthDatasource? authDatasource})
    : authDatasource = authDatasource ?? AuthDatasourcesImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return authDatasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return authDatasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String name) {
    return authDatasource.register(email, password, name);
  }
}
