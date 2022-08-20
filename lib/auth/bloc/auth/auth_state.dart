import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/auth/data/user/user_model.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class AuthState extends Equatable {
  const AuthState._(
      {this.status = AuthStatus.unknown, this.user = UserModel.empty});

  const AuthState.unknown() : this._();

  const AuthState.authenticated(UserModel user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];
}
