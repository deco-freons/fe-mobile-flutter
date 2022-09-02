import 'package:flutter_boilerplate/common/data/base_data_provider.dart';
import 'package:flutter_boilerplate/event/data/location_model.dart';

class EventsByMeDataProvider extends BaseDataProvider {
  Future<dynamic> getEventsByMe(LocationModel model) async {
    return await super
        .networkClient
        .post(path: "/user/events", body: model.toJson(), authorized: true);
  }
}
