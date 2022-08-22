import 'package:flutter_boilerplate/common/bloc/base_state.dart';

abstract class LoginState implements BaseState {
  const LoginState();
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}

class LoginErrorState extends LoginState {
  const LoginErrorState();
}
