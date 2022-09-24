import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_data_provider.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_response_model.dart';

@immutable
abstract class EventMatchingRepository implements BaseRepository {
  Future<List<EventMatchingResponseModel>> getEvents(
      RequestGetEventModel data, int pageCount);
  Future<void> joinEvent(int eventID);
}

class EventMatchingRepositoryImpl extends EventMatchingRepository {
  final EventMatchingDataProvider _eventMatchingDataProvider =
      EventMatchingDataProvider();

  @override
  Future<List<EventMatchingResponseModel>> getEvents(
      RequestGetEventModel data, int pageCount) async {
    final response =
        await _eventMatchingDataProvider.getEvents(data.toJson(), pageCount);
    List<EventMatchingResponseModel> events =
        List<EventMatchingResponseModel>.from(response["events"]
            .map((model) => EventMatchingResponseModel.fromJson(model)));
    return events;
  }

  @override
  Future<void> joinEvent(int eventID) async {
    await _eventMatchingDataProvider.joinEvent(eventID);
  }
}
