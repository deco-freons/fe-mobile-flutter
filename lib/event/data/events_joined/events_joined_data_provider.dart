import 'package:flutter_boilerplate/common/data/base/base_data_provider.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_request_model.dart';

class EventsJoinedDataProvider extends BaseDataProvider {
  Future<dynamic> getJoinedEvents(
      EventJoinedRequestModel data, int page) async {
    return super.networkClient.post(
        path: "/event/read/join?skip=$page&take=5",
        body: data.toJson(),
        authorized: true);
  }

  Future<dynamic> leaveEvent(int eventID) async {
    return super.networkClient.delete(
        path: "/event/cancel", body: {"eventID": eventID}, authorized: true);
  }
}
