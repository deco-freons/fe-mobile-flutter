part of 'auth_bloc.dart';

abstract class AuthEvent implements BaseEvent {
  const AuthEvent();
}

class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged(this.model);

  final AuthModel model;
}
