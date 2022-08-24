import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/data/auth_model.dart';
import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/common/bloc/base_bloc.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_event.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import '../data/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late StreamSubscription<AuthModel> _authStatusSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthUnknownState()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    _authStatusSubscription =
        _authRepository.status.listen((model) => add(AuthStatusChanged(model)));
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
        if (user.isFirstLogin) {
          return emit(AuthFirstLoginState(status: status));
        }
        return emit(AuthAuthenticatedState(user: user, status: status));
      case AuthStatus.unknown:
        return emit(const AuthUnknownState());
    }
  }
}
