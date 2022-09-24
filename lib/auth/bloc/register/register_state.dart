import 'package:flutter_boilerplate/common/bloc/base_state.dart';

abstract class RegisterState implements BaseState {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();
}

class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState();
}

class RegisterErrorState extends RegisterState {
  final String errorMessage;
  const RegisterErrorState({required this.errorMessage});
}
