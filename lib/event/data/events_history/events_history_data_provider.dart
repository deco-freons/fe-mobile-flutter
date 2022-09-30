import 'package:flutter_boilerplate/common/data/base/base_data_provider.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_request_model.dart';

class EventsHistoryDataProvider extends BaseDataProvider {
  Future<dynamic> getEventsHistory(
      EventJoinedRequestModel data, int page) async {
    return super.networkClient.post(
        path: "/event/read/join?skip=$page&take=10",
        body: data.toJson(),
        authorized: true);
  }
}
