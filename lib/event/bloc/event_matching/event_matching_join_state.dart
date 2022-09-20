import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';

@immutable
abstract class EventMatchingJoinState implements BaseState {
  const EventMatchingJoinState();
}

class EventMatchingJoinInitialState extends EventMatchingJoinState {
  const EventMatchingJoinInitialState();
}

class EventMatchingJoinLoadingState extends EventMatchingJoinState {
  const EventMatchingJoinLoadingState();
}

class EventMatchingJoinSuccessState extends EventMatchingJoinState {
  const EventMatchingJoinSuccessState();
}

class EventMatchingJoinErrorState extends EventMatchingJoinState {
  final String errorMessage;
  const EventMatchingJoinErrorState({required this.errorMessage});
}
