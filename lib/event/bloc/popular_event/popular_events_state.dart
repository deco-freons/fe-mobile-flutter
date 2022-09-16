import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';

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

class PopularEventsFilterState extends PopularEventsState {
  const PopularEventsFilterState();
}

class PopularEventsSuccessState extends PopularEventsState {
  final List<PopularEventModel> events;

  const PopularEventsSuccessState({
    required this.events,
  });
}

class PopularEventsErrorState extends PopularEventsState {
  final String errorMessage;
  const PopularEventsErrorState({required this.errorMessage});
}
