import 'package:flutter/material.dart';
import '../../../common/bloc/base_state.dart';
import '../../../common/data/error_model.dart';

@immutable
abstract class ForgetState implements BaseState {
  const ForgetState();
}

class ForgetInitialState extends ForgetState {
  const ForgetInitialState();
}

class ForgetLoadingState extends ForgetState {
  const ForgetLoadingState();
}

class ForgetSuccessState extends ForgetState {
  const ForgetSuccessState();
}

class ForgetErrorState extends ForgetState {
  final ErrorModel error;
  const ForgetErrorState({required this.error});
}
