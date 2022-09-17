import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';

@immutable
abstract class EventMatchingHomeState implements BaseState {
  const EventMatchingHomeState();
}

class EventMatchingHomeInitialState extends EventMatchingHomeState {
  const EventMatchingHomeInitialState();
}

class EventMatchingHomeLoadingState extends EventMatchingHomeState {
  const EventMatchingHomeLoadingState();
}

class EventMatchingHomeSuccessState extends EventMatchingHomeState {
  final List<PopularEventModel> events;

  const EventMatchingHomeSuccessState({
    required this.events,
  });
}

class EventMatchingHomeErrorState extends EventMatchingHomeState {
  final String errorMessage;
  const EventMatchingHomeErrorState({required this.errorMessage});
}
