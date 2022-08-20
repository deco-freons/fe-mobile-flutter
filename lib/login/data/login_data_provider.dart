import 'package:flutter_boilerplate/common/data/base_data_provider.dart';
import 'package:flutter_boilerplate/login/data/login_model.dart';

class LoginDataProvider extends BaseDataProvider {
  Future<dynamic> login(LoginModel data) async {
    return super.networkClient.get(path: "/healthcheck", body: {});
  }
}
