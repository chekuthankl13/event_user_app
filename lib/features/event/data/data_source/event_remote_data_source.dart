import 'dart:convert';

import 'package:event_user/core/config/config.dart';
import 'package:event_user/core/db/db_service.dart';
import 'package:event_user/core/error/exception.dart';
import 'package:event_user/core/error/failure.dart';
import 'package:event_user/features/event/data/model/event_entity_model.dart';
import 'package:http/http.dart';

abstract interface class EventRemoteDataSource {
  Future<List<EventEntityModel>> load();
  


}

class EventRemoteDataSourceImpl extends EventRemoteDataSource {
  final Client client;
  final DbService dbService;

  EventRemoteDataSourceImpl({required this.client, required this.dbService});

  Map<String, String> getheaders(token) => {'Authorization': "Bearer $token"};

  @override
  Future<List<EventEntityModel>> load() async {
    try {
      List<EventEntityModel> history = [];

      var res = await client.get(
        Uri.parse(Config.eventUrl),
        headers: getheaders(dbService.getToken()),
      );

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        if ((body['data'] as List).isNotEmpty) {
          var i = (body['data'] as List<dynamic>)
              .map((e) => EventEntityModel.fromJson(e))
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
