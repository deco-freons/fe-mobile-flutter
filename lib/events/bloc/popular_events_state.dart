import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/events/data/event_model.dart';
import '../../common/bloc/base_state.dart';

@immutable
abstract class PopularEventsState implements BaseState {
  const PopularEventsState();
}

class PopularEventsInitialState extends PopularEventsState {
  const PopularEventsInitialState();
}

class PopularEventsLoadingState extends PopularEventsState {
  const PopularEventsLoadingState();
}

class PopularEventsSuccessState extends PopularEventsState {
  final List<EventModel> events;
  const PopularEventsSuccessState({required this.events});
}

class PopularEventsErrorState extends PopularEventsState {
  final String errorMessage;
  const PopularEventsErrorState({required this.errorMessage});
}
