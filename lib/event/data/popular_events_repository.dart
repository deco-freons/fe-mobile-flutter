import 'package:flutter/material.dart';
import '../../common/data/base_repository.dart';
import 'popular_events_data_provider.dart';

@immutable
abstract class PopularEventsRepository implements BaseRepository {
  Future<dynamic> getPopularEvents(Map<String, dynamic> data);
  Future<dynamic> searchEvents(Map<String, dynamic> data);
  Future<dynamic> getMorePopularEvents(Map<String, dynamic> data, String path);
}

class PopularEventsRepositoryImpl extends PopularEventsRepository {
  final PopularEventsDataProvider _eventDataProvider =
      PopularEventsDataProvider();

  @override
  // ignore: unused_element
  Future<dynamic> getPopularEvents(Map<String, dynamic> data) async {
    final response = await _eventDataProvider.getPopularEvents(data);
    return response;
  }

  @override
  Future<dynamic> searchEvents(Map<String, dynamic> data) async {
    final response = await _eventDataProvider.searchEvents(data);
    return response;
  }

  @override
  Future<dynamic> getMorePopularEvents(
      Map<String, dynamic> data, String path) async {
    final response = await _eventDataProvider.getMorePopularEvents(data, path);
    return response;
  }
}
