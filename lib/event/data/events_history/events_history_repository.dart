import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_request_model.dart';

import 'package:flutter_boilerplate/event/data/events_history/events_history_data_provider.dart';

abstract class EventsHistoryRepository implements BaseRepository {
  Future<List<EventJoinedModel>> getEventsHistory(
      EventJoinedRequestModel data, int page);
}

class EventsHistoryRepositoryImpl extends EventsHistoryRepository {
  final EventsHistoryDataProvider _eventsHistoryDataProvider =
      EventsHistoryDataProvider();

  @override
  Future<List<EventJoinedModel>> getEventsHistory(
      EventJoinedRequestModel data, int page) async {
    dynamic response =
        await _eventsHistoryDataProvider.getEventsHistory(data, page);
    List<EventJoinedModel> events = List<EventJoinedModel>.from(
        response["events"].map((model) => EventJoinedModel.fromJson(model)));
    return events;
  }
}
