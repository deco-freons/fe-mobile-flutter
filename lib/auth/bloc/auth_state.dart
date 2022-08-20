import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

import '../data/user_model.dart';

@immutable
abstract class AuthState implements BaseState {
  const AuthState({
    status = AuthStatus.unknown,
    user = const UserModel('-', '-', '-'),
  });
}

class AuthUnknownState extends AuthState {
  const AuthUnknownState();
}

class AuthAuthenticatedState extends AuthState {
  final UserModel user;
  const AuthAuthenticatedState({
    required this.user,
    status = AuthStatus.authenticated,
  });
}

class AuthUnauthenticatedState extends AuthState {
  const AuthUnauthenticatedState({
    status = AuthStatus.unauthenticated,
  });
}
