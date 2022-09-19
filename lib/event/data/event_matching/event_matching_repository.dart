import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_data_provider.dart';

@immutable
abstract class EventMatchingRepository implements BaseRepository {
  Future<List<PopularEventModel>> getEvents(
      RequestGetEventModel data, int pageCount);
  Future<void> joinEvent(int eventID);
}

class EventMatchingRepositoryImpl extends EventMatchingRepository {
  final EventMatchingDataProvider _eventMatchingDataProvider =
      EventMatchingDataProvider();

  @override
  Future<List<PopularEventModel>> getEvents(
      RequestGetEventModel data, int pageCount) async {
    final response =
        await _eventMatchingDataProvider.getEvents(data.toJson(), pageCount);
    List<PopularEventModel> events = List<PopularEventModel>.from(
        response["events"].map((model) => PopularEventModel.fromJson(model)));
    return events;
  }

  @override
  Future<void> joinEvent(int eventID) async {
    await _eventMatchingDataProvider.joinEvent(eventID);
  }
}
