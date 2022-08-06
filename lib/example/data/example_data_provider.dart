import 'package:flutter_boilerplate/common/data/base_data_provider.dart';

class ExampleDataProvider extends BaseDataProvider {
  Future<dynamic> readData() async {
    return super.networkClient.get(path: "/healthcheck", body: {});
  }
}