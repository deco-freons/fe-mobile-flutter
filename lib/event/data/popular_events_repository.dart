import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/event/data/empty_nearby_model.dart';
import 'package:flutter_boilerplate/event/data/nearby_model.dart';
import '../../common/data/base_repository.dart';
import 'popular_events_data_provider.dart';

@immutable
abstract class PopularEventsRepository implements BaseRepository {
  Future<dynamic> getPopularEventsByCategory(NearbyModel data);
  Future<dynamic> getPopularEventsByAll(EmptyNearbyModel data);
  Future<dynamic> getAllPopularEventsByCategory(NearbyModel data);
  Future<dynamic> getAllPopularEventsByAll(EmptyNearbyModel data);
  Future<dynamic> getMorePopularEventsMoreByCategory(
      NearbyModel data, String path);
  Future<dynamic> getMorePopularEventsByAll(EmptyNearbyModel data, String path);
}

class PopularEventsRepositoryImpl extends PopularEventsRepository {
  final EventDataProvider _eventDataProvider = EventDataProvider();

  @override
  Future<dynamic> getPopularEventsByCategory(NearbyModel data) async {
    final response = await _eventDataProvider.getPopularEventsByCategory(data);
    return response;
  }

  @override
  Future<dynamic> getPopularEventsByAll(EmptyNearbyModel data) async {
    final response = await _eventDataProvider.getPopularEventsByAll(data);
    return response;
  }

  @override
  Future<dynamic> getAllPopularEventsByCategory(NearbyModel data) async {
    final response =
        await _eventDataProvider.getAllPopularEventsByCategory(data);
    return response;
  }

  @override
  Future<dynamic> getAllPopularEventsByAll(EmptyNearbyModel data) async {
    final response = await _eventDataProvider.getAllPopularEventsByAll(data);
    return response;
  }

  @override
  Future<dynamic> getMorePopularEventsMoreByCategory(
      NearbyModel data, String path) async {
    final response =
        await _eventDataProvider.getMorePopularEventsMoreByCategory(data, path);
    return response;
  }

  @override
  Future<dynamic> getMorePopularEventsByAll(
      EmptyNearbyModel data, String path) async {
    final response =
        await _eventDataProvider.getMorePopularEventsByAll(data, path);
    return response;
  }
}
