import 'package:flutter_boilerplate/common/data/base/base_data_provider.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_request_model.dart';

class OtherUserDataProvider extends BaseDataProvider {
  Future<dynamic> getUserProfile(OtherUserRequestModel data) async {
    final response = await super
        .networkClient
        .post(path: "/user/read/other", body: data.toJson(), authorized: true);
    return response;
  }
}
