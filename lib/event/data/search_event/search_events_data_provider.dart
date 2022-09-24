import 'package:flutter_boilerplate/common/data/base/base_data_provider.dart';

class SearchEventsDataProvider extends BaseDataProvider {
  Future<dynamic> searchEvents(Map<String, dynamic> data) async {
    return await super
        .networkClient
        .post(path: "/event/read?skip=0&take=10", body: data, authorized: true);
  }

  Future<dynamic> getMoreSearchEvents(
      Map<String, dynamic> data, int pageCount) async {
    return await super.networkClient.post(
        path: '/event/read?skip=$pageCount&take=10',
        body: data,
        authorized: true);
  }
}
