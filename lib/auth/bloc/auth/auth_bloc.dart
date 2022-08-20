import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/data/user/user_model.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

import '../../data/auth/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription = _authRepository.status.listen(
      (status) => add(AuthStatusChanged(status)),
    );
  }

  final AuthRepository _authRepository;
  late StreamSubscription<AuthStatus> _authStatusSubscription;

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthState.authenticated(user)
              : const AuthState.unauthenticated(),
        );
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.logOut();
  }

  Future<UserModel?> _tryGetUser() async {
    try {
      const user = UserModel("id");
      return user;
    } catch (_) {
      return null;
    }
  }
}
