import 'package:teslo_flutter_app/features/auth/domain/domain.dart';

class UserMapper {
  static userJsonToEntity(Map<String, dynamic> json) => User(
    email: json['email'],
    id: json['id'],
    fullName: json['fullName'],
    token: json['token'],
    roles: List<String>.from(json['roles'].map((role) => role)),
  );
}
