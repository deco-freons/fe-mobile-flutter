import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class EventMatchingHomeDataProvider extends BaseDataProvider {
  Future<dynamic> getEventMatchingHome(Map<String, dynamic> data) async {
    return await super
        .networkClient
        .post(path: "/event/read?skip=0&take=1", body: data, authorized: true);
  }
}
