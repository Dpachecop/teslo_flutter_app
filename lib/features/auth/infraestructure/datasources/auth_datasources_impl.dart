import 'package:dio/dio.dart';
import 'package:teslo_flutter_app/config/constants/enviroment.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/mappers/user_mapper.dart';

import '../../domain/domain.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      // ignore: empty_catches
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<User> register(String email, String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
