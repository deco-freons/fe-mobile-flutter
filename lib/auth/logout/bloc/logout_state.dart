import 'package:flutter_boilerplate/common/bloc/base_state.dart';

abstract class LogoutState implements BaseState {
  const LogoutState();
}

class LogoutInitialState extends LogoutState {
  const LogoutInitialState();
}

class LogoutLoadingState extends LogoutState {
  const LogoutLoadingState();
}

class LogoutSuccessState extends LogoutState {
  const LogoutSuccessState();
}

class LogoutErrorState extends LogoutState {
  final String errorMessage;
  const LogoutErrorState({required this.errorMessage});
}
