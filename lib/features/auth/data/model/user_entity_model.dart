import 'package:event_user/features/auth/domain/entity/user_entity.dart';

class UserEntityModel extends UserEntity {
  UserEntityModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory UserEntityModel.fromJson(Map<String, dynamic> json) =>
      UserEntityModel(
        name: json['name'].toString(),
        email: json['email'].toString(),
        phone: json['phone'].toString(),
        token: json['token'].toString(),
      );
}
