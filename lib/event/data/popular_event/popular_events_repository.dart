import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'popular_events_data_provider.dart';

@immutable
abstract class PopularEventsRepository implements BaseRepository {
  Future<List<PopularEventModel>> getPopularEvents(RequestGetEventModel data);
}

class PopularEventsRepositoryImpl extends PopularEventsRepository {
  final PopularEventsDataProvider _eventDataProvider =
      PopularEventsDataProvider();

  @override
  Future<List<PopularEventModel>> getPopularEvents(
      RequestGetEventModel data) async {
    final response = await _eventDataProvider.getPopularEvents(data.toJson());
    List<PopularEventModel> events = List<PopularEventModel>.from(
        response["events"].map((model) => PopularEventModel.fromJson(model)));
    return events;
  }
}
