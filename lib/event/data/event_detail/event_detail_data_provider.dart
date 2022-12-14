import 'package:flutter_boilerplate/common/data/base/base_data_provider.dart';
import 'package:flutter_boilerplate/event/data/common/event_image_request_model.dart';
import 'package:flutter_boilerplate/event/data/update_event/edit_event_model.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<dynamic> updateEventImage(
      EventImageRequestModel data, MediaType mediaType) async {
    return super.networkClient.post(
        path: "/event/image",
        body: await data.toJson(mediaType),
        formData: true,
        authorized: true);
  }
}
