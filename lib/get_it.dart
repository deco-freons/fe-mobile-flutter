import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}
