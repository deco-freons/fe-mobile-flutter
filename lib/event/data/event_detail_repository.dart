import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/event/data/event_detail_data_provider.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';

abstract class EventDetailRepository implements BaseRepository {
  Future<EventDetailResponseModel> getEventDetail(int eventID);
  Future<dynamic> joinEvent(int eventID);
  Future<dynamic> leaveEvent(int eventID);
}

class EventDetailRepositoryImpl extends EventDetailRepository {
  final EventDetailDataProvider _eventDetailDataProvider =
      EventDetailDataProvider();

  @override
  Future<EventDetailResponseModel> getEventDetail(int eventID) async {
    final data = await _eventDetailDataProvider.getEventDetail(eventID);
    EventDetailResponseModel eventDetailResponseModel =
        EventDetailResponseModel.fromJson(data);

    return eventDetailResponseModel;
  }

  @override
  Future<dynamic> joinEvent(int eventID) async {
    return await _eventDetailDataProvider.joinEvent(eventID);
  }

  @override
  Future leaveEvent(int eventID) async {
    return await _eventDetailDataProvider.leaveEvent(eventID);
  }
}
