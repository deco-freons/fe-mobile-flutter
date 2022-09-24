import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/search_events_data_provider.dart';

abstract class SearchEventsRepository implements BaseRepository {
  Future<List<PopularEventModel>> searchEvents(RequestGetEventModel data);
  Future<List<PopularEventModel>> getMoreSearchEvents(
      RequestGetEventModel data, int pageCount);
}

class SearchEventsRepositoryImpl extends SearchEventsRepository {
  final SearchEventsDataProvider _eventDataProvider =
      SearchEventsDataProvider();

  @override
  Future<List<PopularEventModel>> searchEvents(
      RequestGetEventModel data) async {
    final response = await _eventDataProvider.searchEvents(data.toJson());

    List<PopularEventModel> events = List<PopularEventModel>.from(
        response["events"].map((model) => PopularEventModel.fromJson(model)));

    return events;
  }

  @override
  Future<List<PopularEventModel>> getMoreSearchEvents(
      RequestGetEventModel data, int pageCount) async {
    final response =
        await _eventDataProvider.getMoreSearchEvents(data.toJson(), pageCount);

    List<PopularEventModel> events = List<PopularEventModel>.from(
        response["events"].map((model) => PopularEventModel.fromJson(model)));
    return events;
  }
}
