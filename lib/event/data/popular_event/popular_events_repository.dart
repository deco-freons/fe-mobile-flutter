import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'popular_events_data_provider.dart';

@immutable
abstract class PopularEventsRepository implements BaseRepository {
  Future<dynamic> getPopularEvents(Map<String, dynamic> data);
}

class PopularEventsRepositoryImpl extends PopularEventsRepository {
  final PopularEventsDataProvider _eventDataProvider =
      PopularEventsDataProvider();

  @override
  Future<dynamic> getPopularEvents(Map<String, dynamic> data) async {
    final response = await _eventDataProvider.getPopularEvents(data);
    return response;
  }
}
