import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/popular_event/popular_event_model.dart';

abstract class SearchEventsState implements BaseState {
  const SearchEventsState();
}

class SearchEventsInitialState extends SearchEventsState {
  const SearchEventsInitialState();
}

class SearchEventsLoadingState extends SearchEventsState {
  const SearchEventsLoadingState();
}

class SearchEventsSuccessState extends SearchEventsState {
  final List<PopularEventModel> events;
  final int pageCount;
  const SearchEventsSuccessState(
      {required this.events, required this.pageCount});
}

class SearchEventsErrorState extends SearchEventsState {
  final String errorMessage;
  const SearchEventsErrorState({required this.errorMessage});
}
