import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class EventDetailDataProvider extends BaseDataProvider {
  Future<dynamic> getEventDetail(int eventID) async {
    return super
        .networkClient
        .post(path: "/event/read/detail", body: {"eventID": eventID});
  }
}
