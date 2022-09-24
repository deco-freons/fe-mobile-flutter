part of 'auth_bloc.dart';

@immutable
abstract class AuthState implements BaseState {
  const AuthState();
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

class AuthFirstLoginState extends AuthState {
  const AuthFirstLoginState({
    status = AuthStatus.authenticated,
  });
}
