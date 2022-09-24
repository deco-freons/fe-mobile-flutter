import '../../../common/data/base/base_data_provider.dart';
import 'forget_model.dart';

class ForgetDataProvider extends BaseDataProvider {
  Future<dynamic> forget(ForgetModel data) async {
    return await super
        .networkClient
        .post(path: "/auth/forget-password/request", body: data.toJson());
  }
}
