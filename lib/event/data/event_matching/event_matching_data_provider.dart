import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class EventMatchingDataProvider extends BaseDataProvider {
  Future<dynamic> getEvents(Map<String, dynamic> data, int pageCount) async {
    return await super.networkClient.post(
        path: "/event/read/not?skip=$pageCount&take=10",
        body: data,
        authorized: true);
  }

  Future<dynamic> joinEvent(int eventID) async {
    return super.networkClient.post(
        path: "/event/join", body: {"eventID": eventID}, authorized: true);
  }
}
