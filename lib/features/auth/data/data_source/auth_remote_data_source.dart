import 'dart:convert';
import 'dart:developer';

import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/error/exception.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/auth/data/model/user_entity_model.dart';
import 'package:event_user/features/auth/data/model/user_param_model.dart';
import 'package:http/http.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserEntityModel> login({required UserParamModel param});
  Future<String> register({required UserParamModel2 param});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Client client;

  AuthRemoteDataSourceImpl({required this.client});
  @override
  Future<UserEntityModel> login({required UserParamModel param}) async {
    try {
      var res = await client.post(
        Uri.parse(Config.loginUrl),
        body: param.toJson(),
      );

      // var res = await client.get(Uri.parse(Config.DUMMY));
      // log(res.body);
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return UserEntityModel.fromJson(body);
      } else {
        throw CredentialFailure(error: body['message'] + "\n" + body['error']);
      }
    } on Exception catch (e) {
      log(e.toString());
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<String> register({required UserParamModel2 param}) async {
    try {
      var res = await client.post(
        Uri.parse(Config.registerUrl),
        body: param.toJson(),
      );

      
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return "ok";
      } else {
        throw CredentialFailure(error: body['message'] + "\n" + body['error']);
      }
    } on Exception catch (e) {
      log(e.toString());
      throw ServerException(error: e.toString());
    }
  }
}
