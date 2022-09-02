import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/event/data/popular_event_model.dart';
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

class PopularEventsFilterState extends PopularEventsState {
  const PopularEventsFilterState();
}

class PopularEventsSuccessState extends PopularEventsState {
  final List<List<String>> locationNames;
  final List<PopularEventModel> events;
  final int pageCount;
  const PopularEventsSuccessState(
      {required this.events,
      required this.locationNames,
      required this.pageCount});
}

class PopularEventsErrorState extends PopularEventsState {
  final String errorMessage;
  const PopularEventsErrorState({required this.errorMessage});
}
