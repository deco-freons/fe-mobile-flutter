import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app.dart';
import 'package:flutter_boilerplate/auth/data/auth/auth_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await setUp();
  await dotenv.load(fileName: ".env");

  runApp(App(
    authRepository: getIt.get<AuthRepository>(),
  ));
}
