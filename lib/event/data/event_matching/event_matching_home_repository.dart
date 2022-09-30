import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_home_data_provider.dart';

@immutable
abstract class EventMatchingHomeRepository implements BaseRepository {
  Future<List<EventModel>> getEventMatchingHome(RequestGetEventModel data);
}

class EventMatchingHomeRepositoryImpl extends EventMatchingHomeRepository {
  final EventMatchingHomeDataProvider _eventDataProvider =
      EventMatchingHomeDataProvider();

  @override
  Future<List<EventModel>> getEventMatchingHome(
      RequestGetEventModel data) async {
    final response =
        await _eventDataProvider.getEventMatchingHome(data.toJson());
    List<EventModel> events = List<EventModel>.from(
        response["events"].map((model) => EventModel.fromJson(model)));
    return events;
  }
}
