import 'package:flutter_boilerplate/user/data/edit_user_model.dart';
import '../../common/data/base_data_provider.dart';

class EditUserDataProvider extends BaseDataProvider {
  Future<dynamic> editUser(EditUserModel data) async {
    return await super
        .networkClient
        .post(path: "/user/update", body: data.toJson(), authorized: true);
  }
}
