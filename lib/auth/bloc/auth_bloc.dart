import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/bloc/auth_event.dart';
import 'package:flutter_boilerplate/auth/bloc/auth_state.dart';
import 'package:flutter_boilerplate/auth/data/auth_model.dart';
import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/common/bloc/base_bloc.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late StreamSubscription<AuthModel> _authStatusSubscription;

  AuthBloc(this._authRepository) : super(const AuthUnknownState()) {
    on<AuthStatusChanged>((event, emit) async {
      _onAuthStatusChanged(event, emit);
      _authStatusSubscription = _authRepository.status
          .listen((model) => add(AuthStatusChanged(model)));
    });
  }

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
    switch (event.model.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthUnauthenticatedState());
      case AuthStatus.authenticated:
        UserModel? user = event.model.user;
        AuthStatus status = event.model.status;
        if (user == null) {
          return emit(AuthUnauthenticatedState(status: status));
        }
        return emit(AuthAuthenticatedState(user: user, status: status));
      case AuthStatus.unknown:
        return emit(const AuthUnknownState());
    }
  }
}
