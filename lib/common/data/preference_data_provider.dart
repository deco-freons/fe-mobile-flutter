import '../../common/data/preference_model.dart';
import '../../common/data/base_data_provider.dart';

class PreferenceDataProvider extends BaseDataProvider {
  Future<dynamic> preference(PreferenceModel data) async {
    return await super
        .networkClient
        .post(path: "/auth/preference", body: data.toJson());
  }
}
