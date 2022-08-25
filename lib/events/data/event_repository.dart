import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/events/data/empty_nearby_model.dart';
import 'package:flutter_boilerplate/events/data/nearby_model.dart';
import '../../common/data/base_repository.dart';
import 'event_data_provider.dart';

@immutable
abstract class EventRepository implements BaseRepository {
  Future<dynamic> getPopularEvents(NearbyModel data);
  Future<dynamic> getAllPopularEvents(EmptyNearbyModel data);
}

class EventRepositoryImpl extends EventRepository {
  final EventDataProvider _eventDataProvider = EventDataProvider();

  @override
  Future<dynamic> getPopularEvents(NearbyModel data) async {
    final response = await _eventDataProvider.getPopularEvents(data);
    return response;
  }

  @override
  Future<dynamic> getAllPopularEvents(EmptyNearbyModel data) async {
    final response = await _eventDataProvider.getAllPopularEvents(data);
    return response;
  }
}
