import 'package:flutter_boilerplate/common/data/base/base_data_provider.dart';
import 'package:flutter_boilerplate/user/data/update_user/edit_user_model.dart';
import 'package:flutter_boilerplate/user/data/common/user_image_request_model.dart';
import 'package:http_parser/http_parser.dart';

class EditUserDataProvider extends BaseDataProvider {
  Future<dynamic> editUser(EditUserModel data) async {
    return await super
        .networkClient
        .post(path: "/user/update", body: data.toJson(), authorized: true);
  }

  Future<dynamic> updateUserImage(
      UserImageRequestModel data, MediaType mediaType) async {
    return super.networkClient.post(
        path: "/user/image",
        body: await data.toJson(mediaType),
        formData: true,
        authorized: true);
  }
}
