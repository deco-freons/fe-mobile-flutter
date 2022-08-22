import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app.dart';

import 'package:flutter_boilerplate/auth/data/auth_repository.dart';

void main() {
  runApp(App(
    authRepository: AuthRepositoryImpl(),
  ));
}
