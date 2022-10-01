import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/search_events_data_provider.dart';

abstract class SearchEventsRepository implements BaseRepository {
  Future<List<EventModel>> searchEvents(RequestGetEventModel data);
  Future<List<EventModel>> getMoreSearchEvents(
      RequestGetEventModel data, int pageCount);
}

class SearchEventsRepositoryImpl extends SearchEventsRepository {
  final SearchEventsDataProvider _eventDataProvider =
      SearchEventsDataProvider();

  @override
  Future<List<EventModel>> searchEvents(RequestGetEventModel data) async {
    final response = await _eventDataProvider.searchEvents(data.toJson());
    List<EventModel> events = List<EventModel>.from(
        response["events"].map((model) => EventModel.fromJson(model)));

    return events;
  }

  @override
  Future<List<EventModel>> getMoreSearchEvents(
      RequestGetEventModel data, int pageCount) async {
    final response =
        await _eventDataProvider.getMoreSearchEvents(data.toJson(), pageCount);

    List<EventModel> events = List<EventModel>.from(
        response["events"].map((model) => EventModel.fromJson(model)));
    return events;
  }
}
