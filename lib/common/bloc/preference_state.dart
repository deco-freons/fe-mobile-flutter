import 'package:flutter/material.dart';
import '../../common/bloc/base_state.dart';
import '../../common/data/error_model.dart';

@immutable
abstract class PreferenceState implements BaseState {
  const PreferenceState();
}

class PreferenceInitialState extends PreferenceState {
  const PreferenceInitialState();
}

class PreferenceLoadingState extends PreferenceState {
  const PreferenceLoadingState();
}

class PreferenceSuccessState extends PreferenceState {
  const PreferenceSuccessState();
}

class PreferenceErrorState extends PreferenceState {
  final ErrorModel error;
  const PreferenceErrorState({required this.error});
}
