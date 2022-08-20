import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/auth/data/auth_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_event.dart';

@immutable
abstract class AuthEvent implements BaseEvent {
  const AuthEvent();
}

class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged(this.model);

  final AuthModel model;
}
