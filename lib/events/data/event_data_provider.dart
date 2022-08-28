import 'package:flutter_boilerplate/events/data/empty_nearby_model.dart';
import 'package:flutter_boilerplate/events/data/nearby_model.dart';

import '../../common/data/base_data_provider.dart';

class EventDataProvider extends BaseDataProvider {
  Future<dynamic> getPopularEvents(NearbyModel data) async {
    return await super.networkClient.post(
        path: "/event/read?skip=0&take=5",
        body: data.toJson(),
        authorized: true);
  }

  Future<dynamic> getAllPopularEvents(EmptyNearbyModel data) async {
    return await super.networkClient.post(
        path: "/event/read?skip=0&take=10",
        body: data.toJson(),
        authorized: true);
  }
}
