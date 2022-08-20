import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/common/bloc/base_event.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AuthStatusChanged extends AuthEvent {
  final AuthStatus status;

  const AuthStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class AuthLogoutRequested extends AuthEvent {}
