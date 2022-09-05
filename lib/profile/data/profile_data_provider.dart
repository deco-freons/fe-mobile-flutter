import 'package:flutter_boilerplate/common/data/base_data_provider.dart';
import 'package:flutter_boilerplate/profile/data/models/profile_request_model.dart';

class ProfileDataProvider extends BaseDataProvider {
  Future<dynamic> getUserProfile(ProfileRequestModel data) async {
    final response = await super
        .networkClient
        .post(path: "/user/read/other", body: data.toJson(), authorized: true);
    return response;
  }
}
