import 'package:flutter_boilerplate/auth/login/data/login_model.dart';
import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class AuthDataProvider extends BaseDataProvider {
  Future<dynamic> login(LoginModel data) async {
    return await super
        .networkClient
        .post(path: "/auth/login", body: data.toJson());
  }

  Future<dynamic> checkAuth() async {
    return await super
        .networkClient
        .post(path: "/auth/access-token", body: {}, authorized: true);
  }

  Future<dynamic> logout(String refreshToken) async {
    return await super.networkClient.delete(
        path: "/auth/logout",
        body: {"refreshToken": refreshToken},
        authorized: true);
  }
}
