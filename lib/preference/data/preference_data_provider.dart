import '../../common/data/base/base_data_provider.dart';

class PreferenceDataProvider extends BaseDataProvider {
  Future<dynamic> firstPreference(List<String> data) async {
    return await super.networkClient.post(
        path: "/user/preference/upsert",
        body: {"preferences": data},
        authorized: true);
  }
}
