import 'package:flutter_boilerplate/auth/data/auth/auth_repository.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_repository.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_repository.dart';
import 'package:flutter_boilerplate/notification/notification_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerSingleton<SecureStorage>(
      SecureStorage(const FlutterSecureStorage()));
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<EventDetailRepository>(EventDetailRepositoryImpl());
  getIt.registerSingleton<EventsJoinedRepository>(EventsJoinedRepositoryImpl());
}
