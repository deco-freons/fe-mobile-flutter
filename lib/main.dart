import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app.dart';
import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/get_it.dart';

void main() async {
  await setUp();

  runApp(App(
    authRepository: getIt.get<AuthRepository>(),
  ));
}
