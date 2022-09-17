import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class EventMatchingDataProvider extends BaseDataProvider {
  Future<dynamic> getEvents(Map<String, dynamic> data) async {
    return await super
        .networkClient
        .post(path: "/event/read?skip=0&take=5", body: data, authorized: true);
  }
  
  Future<dynamic> joinEvent(int eventID) async {
    return super.networkClient.post(
        path: "/event/join", body: {"eventID": eventID}, authorized: true);
  }
}
