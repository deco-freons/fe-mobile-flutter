import 'package:flutter_boilerplate/auth/login/data/login_model.dart';
import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class LoginDataProvider extends BaseDataProvider {
  Future<dynamic> login(LoginModel data) async {
    return super.networkClient.get(path: "/healthcheck");
  }
}
