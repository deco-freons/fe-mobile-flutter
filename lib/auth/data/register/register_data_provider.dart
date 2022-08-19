import 'package:flutter_boilerplate/auth/data/register/register_model.dart';
import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class RegisterDataProvider extends BaseDataProvider {
  Future<dynamic> register(RegisterModel data) async {
    return super.networkClient.get(path: "/todos/1", body: {});
  }
}
