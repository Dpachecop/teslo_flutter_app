import 'package:dio/dio.dart';
import 'package:teslo_flutter_app/config/constants/enviroment.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:teslo_flutter_app/features/auth/infraestructure/mappers/user_mapper.dart';

import '../../domain/domain.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));
  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get(
        '/auth/check-status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('token no valido');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisa tu conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
          e.response?.data['message'] ?? 'Error no identificado',
        );
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisa tu conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
