import '../../common/data/base_data_provider.dart';

class PopularEventsDataProvider extends BaseDataProvider {
  Future<dynamic> getPopularEvents(Map<String, dynamic> data) async {
    return await super
        .networkClient
        .post(path: "/event/read?skip=0&take=5", body: data, authorized: true);
  }

  Future<dynamic> searchEvents(Map<String, dynamic> data) async {
    return await super
        .networkClient
        .post(path: "/event/read?skip=0&take=10", body: data, authorized: true);
  }

  Future<dynamic> getMorePopularEvents(
      Map<String, dynamic> data, String path) async {
    return await super
        .networkClient
        .post(path: path, body: data, authorized: true);
  }
}
