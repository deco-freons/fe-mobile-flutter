import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'popular_events_data_provider.dart';

@immutable
abstract class PopularEventsRepository implements BaseRepository {
  Future<List<EventModel>> getPopularEvents(RequestGetEventModel data);
}

class PopularEventsRepositoryImpl extends PopularEventsRepository {
  final PopularEventsDataProvider _eventDataProvider =
      PopularEventsDataProvider();

  @override
  Future<List<EventModel>> getPopularEvents(RequestGetEventModel data) async {
    final response = await _eventDataProvider.getPopularEvents(data.toJson());

    List<EventModel> events = List<EventModel>.from(
        response["events"].map((model) => EventModel.fromJson(model)));
    return events;
  }
}
