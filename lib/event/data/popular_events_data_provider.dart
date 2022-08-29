import 'package:flutter_boilerplate/event/data/empty_nearby_model.dart';
import 'package:flutter_boilerplate/event/data/nearby_model.dart';

import '../../common/data/base_data_provider.dart';

class EventDataProvider extends BaseDataProvider {
  Future<dynamic> getPopularEventsByCategory(NearbyModel data) async {
    return await super.networkClient.post(
        path: "/event/read?skip=0&take=5",
        body: data.toJson(),
        authorized: true);
  }

  Future<dynamic> getPopularEventsByAll(EmptyNearbyModel data) async {
    return await super.networkClient.post(
        path: "/event/read?skip=0&take=5",
        body: data.toJson(),
        authorized: true);
  }

  Future<dynamic> getAllPopularEventsByCategory(NearbyModel data) async {
    return await super.networkClient.post(
        path: "/event/read?skip=0&take=10",
        body: data.toJson(),
        authorized: true);
  }

  Future<dynamic> getAllPopularEventsByAll(EmptyNearbyModel data) async {
    return await super.networkClient.post(
        path: "/event/read?skip=0&take=10",
        body: data.toJson(),
        authorized: true);
  }

  Future<dynamic> getMorePopularEventsMoreByCategory(
      NearbyModel data, String path) async {
    return await super
        .networkClient
        .post(path: path, body: data.toJson(), authorized: true);
  }

  Future<dynamic> getMorePopularEventsByAll(
      EmptyNearbyModel data, String path) async {
    return await super
        .networkClient
        .post(path: path, body: data.toJson(), authorized: true);
  }
}
