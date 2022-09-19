import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_home_data_provider.dart';

@immutable
abstract class EventMatchingHomeRepository implements BaseRepository {
  Future<List<PopularEventModel>> getEventMatchingHome(
      RequestGetEventModel data);
}

class EventMatchingHomeRepositoryImpl extends EventMatchingHomeRepository {
  final EventMatchingHomeDataProvider _eventDataProvider =
      EventMatchingHomeDataProvider();

  @override
  Future<List<PopularEventModel>> getEventMatchingHome(
      RequestGetEventModel data) async {
    final response =
        await _eventDataProvider.getEventMatchingHome(data.toJson());
    List<PopularEventModel> events = List<PopularEventModel>.from(
        response["events"].map((model) => PopularEventModel.fromJson(model)));
    return events;
  }
}
