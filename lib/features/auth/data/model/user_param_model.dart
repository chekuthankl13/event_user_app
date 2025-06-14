import 'package:event_user/features/auth/domain/entity/user_param.dart';

class UserParamModel extends UserParam {
  UserParamModel({required super.email, required super.password});

  factory UserParamModel.fromEntity(UserParam data) =>
      UserParamModel(email: data.email, password: data.password);

  Map<String, String> toJson() => {"email": email, "password": password};
}

class UserParamModel2 extends UserParam2 {
  UserParamModel2({
    required super.email,
    required super.password,
    required super.phone,
    required super.name,
  });

  factory UserParamModel2.fromEntity(UserParam2 data) => UserParamModel2(
    email: data.email,
    password: data.password,
    phone: data.phone,
    name: data.name,
  );

  Map<String, String> toJson() => {"email": email, "password": password,"phone":phone,"name":name};
}
