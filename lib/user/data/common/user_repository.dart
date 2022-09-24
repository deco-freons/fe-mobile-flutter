import 'package:flutter_boilerplate/common/data/base/base_repository.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/get_it.dart';

abstract class UserRepository implements BaseRepository {
  Future<dynamic> getUser();
}

class UserRepositoryImpl extends UserRepository {
  final SecureStorage secureStorage = getIt.get<SecureStorage>();

  @override
  Future<dynamic> getUser() async {
    final response = await secureStorage.get(key: "user");
    return response;
  }
}
