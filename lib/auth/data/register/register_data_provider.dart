import 'package:flutter_boilerplate/auth/data/register/register_model.dart';
import 'package:flutter_boilerplate/common/data/base/base_data_provider.dart';

class RegisterDataProvider extends BaseDataProvider {
  Future<dynamic> register(RegisterModel data) async {
    return await super
        .networkClient
        .post(path: "/auth/register", body: data.toJson());
  }
}
