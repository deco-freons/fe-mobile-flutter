import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/event/data/event_detail_data_provider.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';

abstract class EventDetailRepository implements BaseRepository {
  Future<EventDetailResponseModel> getEventDetail(int eventID);
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
}
