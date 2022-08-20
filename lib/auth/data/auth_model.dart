import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';

class AuthModel {
  final UserModel? user;
  final AuthStatus status;

  const AuthModel(
    this.user,
    this.status,
  );
}
