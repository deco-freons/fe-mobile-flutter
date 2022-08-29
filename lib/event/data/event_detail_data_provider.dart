import 'package:flutter_boilerplate/common/data/base_data_provider.dart';
import 'package:flutter_boilerplate/event/data/edit_event_model.dart';

class EventDetailDataProvider extends BaseDataProvider {
  Future<dynamic> getEventDetail(int eventID) async {
    return super.networkClient.post(
        path: "/event/read/detail",
        body: {"eventID": eventID},
        authorized: true);
  }

  Future<dynamic> joinEvent(int eventID) async {
    return super.networkClient.post(
        path: "/event/join", body: {"eventID": eventID}, authorized: true);
  }

  Future<dynamic> leaveEvent(int eventID) async {
    return super.networkClient.delete(
        path: "/event/cancel", body: {"eventID": eventID}, authorized: true);
  }

  Future<dynamic> deleteEvent(int eventID) async {
    return super.networkClient.delete(
        path: "/event/delete", body: {"eventID": eventID}, authorized: true);
  }

  Future<dynamic> editEvent(EditEventModel data) async {
    return super
        .networkClient
        .patch(path: "/event/update", body: data.toJson(), authorized: true);
  }
}
