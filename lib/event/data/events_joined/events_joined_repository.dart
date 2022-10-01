import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_request_model.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_data_provider.dart';

abstract class EventsJoinedRepository implements BaseRepository {
  Future<List<EventJoinedModel>> getJoinedEvents(
      EventJoinedRequestModel data, int page);

  Future<String> leaveEvent(int eventID);
}

class EventsJoinedRepositoryImpl extends EventsJoinedRepository {
  final EventsJoinedDataProvider _eventsHistoryDataProvider =
      EventsJoinedDataProvider();

  @override
  Future<List<EventJoinedModel>> getJoinedEvents(
      EventJoinedRequestModel data, int page) async {
    dynamic response =
        await _eventsHistoryDataProvider.getJoinedEvents(data, page);
    List<EventJoinedModel> events = List<EventJoinedModel>.from(
        response["events"].map((model) => EventJoinedModel.fromJson(model)));
    return events;
  }

  @override
  Future<String> leaveEvent(int eventID) async {
    dynamic response = await _eventsHistoryDataProvider.leaveEvent(eventID);

    return response["message"];
  }
}
