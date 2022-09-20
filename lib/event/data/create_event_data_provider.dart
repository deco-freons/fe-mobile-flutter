import 'package:flutter_boilerplate/event/data/create_event_model.dart';

import '../../common/data/base_data_provider.dart';

class CreateEventDataProvider extends BaseDataProvider {
  Future<dynamic> createEvent(CreateEventModel data) async {
    return await super
        .networkClient
        .post(path: "/event/create", body: data.toJson(), authorized: true);
  }

  Future<dynamic> uploadImage(Map<String, dynamic> data) async {
    return await super.networkClient.post(
        path: "/event/image", body: data, authorized: true, formData: true);
  }
}
