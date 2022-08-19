import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';

@immutable
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
  // final RegisterModel model;
  const RegisterSuccessState();
}

class RegisterErrorState extends RegisterState {
  const RegisterErrorState();
}
