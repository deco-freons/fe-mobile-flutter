part of 'auth_bloc.dart';

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
