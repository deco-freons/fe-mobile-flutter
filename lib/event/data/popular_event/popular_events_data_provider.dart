import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class PopularEventsDataProvider extends BaseDataProvider {
  Future<dynamic> getPopularEvents(Map<String, dynamic> data) async {
    return await super
        .networkClient
        .post(path: "/event/read?skip=0&take=5", body: data, authorized: true);
  }
}
