import 'dart:convert';

import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/db/db_service.dart';
import 'package:event_user/core/error/exception.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/registration/data/model/registration_entity_model.dart';
import 'package:event_user/features/registration/data/model/registration_param_model.dart';
import 'package:http/http.dart';

abstract interface class RegistrationRemoteDataSource {
  Future<List<RegistrationEntityModel>> load();
  Future<String> add({required RegistrationParamModel param});
}

class RegistrationRemoteDataSourceImpl extends RegistrationRemoteDataSource {
  final Client client;
  final DbService dbService;

  RegistrationRemoteDataSourceImpl({
    required this.client,
    required this.dbService,
  });

  Map<String, String> getheaders(token) => {'Authorization': "Bearer $token"};

  @override
  Future<String> add({required RegistrationParamModel param}) async {
    try {
      var res = await client.post(
        Uri.parse(Config.regUrl),
        headers: getheaders(dbService.getToken()),
        body: param.toJson(),
      );

      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return "ok";
      } else {
        throw CredentialFailure(error: body['message'] + "\n" + body['error']);
      }
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<List<RegistrationEntityModel>> load() async {
    try {
      List<RegistrationEntityModel> history = [];

      var res = await client.get(
        Uri.parse(Config.regUrl),
        headers: getheaders(dbService.getToken()),
      );

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        if ((body['data'] as List).isNotEmpty) {
          var i = (body['data'] as List<dynamic>)
              .map((e) => RegistrationEntityModel.fromJson(e))
              .toList();
          return i;
        } else {
          return history;
        }
      } else {
        throw ServerFailure(error: res.body);
      }
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }
}
