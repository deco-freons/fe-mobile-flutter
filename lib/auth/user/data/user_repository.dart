import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';

abstract class UserRepository implements BaseRepository {
  Future<dynamic> getUser();
}

class UserRepositoryImpl extends UserRepository {
  // final UserDataProvider _userDataProvider = UserDataProvider();
  final secureStorage = SecureStorage.getInstance;

  @override
  Future<dynamic> getUser() async {
    final response = await secureStorage.get(key: "user");
    return response;
  }
}
