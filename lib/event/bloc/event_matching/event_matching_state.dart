import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_response_model.dart';

@immutable
abstract class EventMatchingState implements BaseState {
  const EventMatchingState();
}

class EventMatchingInitialState extends EventMatchingState {
  const EventMatchingInitialState();
}

class EventMatchingLoadingState extends EventMatchingState {
  const EventMatchingLoadingState();
}

class EventMatchingSuccessState extends EventMatchingState {
  final List<EventMatchingResponseModel> events;
  final bool hasMore;
  final int pageCount;
  const EventMatchingSuccessState(
      {required this.events, required this.pageCount, required this.hasMore});
}

class EventMatchingErrorState extends EventMatchingState {
  final String errorMessage;
  const EventMatchingErrorState({required this.errorMessage});
}
