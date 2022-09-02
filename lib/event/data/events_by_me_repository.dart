import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/event/data/events_by_me_data_provider.dart';
import 'package:flutter_boilerplate/event/data/events_by_user_model.dart';
import 'package:flutter_boilerplate/event/data/location_model.dart';

abstract class EventsByMeRepository implements BaseRepository {
  Future<EventsByUserModel> getEventsByMe(LocationModel model);
}

class EventsByMeRepositoryImpl extends EventsByMeRepository {
  final EventsByMeDataProvider _eventsByMeDataProvider =
      EventsByMeDataProvider();

  @override
  Future<EventsByUserModel> getEventsByMe(LocationModel model) async {
    final response = await _eventsByMeDataProvider.getEventsByMe(model);
    EventsByUserModel data = EventsByUserModel.fromJson(response);
    return data;
  }
}
