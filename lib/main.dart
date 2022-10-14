import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app.dart';
import 'package:flutter_boilerplate/auth/data/auth/auth_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/notification/notification_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await setUp();
  await getIt.get<NotificationService>().setup();

  runApp(App(
    authRepository: getIt.get<AuthRepository>(),
  ));
}
