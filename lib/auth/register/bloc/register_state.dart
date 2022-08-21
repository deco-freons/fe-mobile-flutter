import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/common/data/error_model.dart';

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
  const RegisterSuccessState();
}

class RegisterErrorState extends RegisterState {
  final ErrorModel error;
  const RegisterErrorState({required this.error});
}
