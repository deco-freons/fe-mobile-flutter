import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  getIt.registerSingleton<SecureStorage>(
      SecureStorage(const FlutterSecureStorage()));
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}
