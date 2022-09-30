import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';

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
  final List<EventModel> events;
  final bool hasMore;
  const SearchEventsSuccessState({required this.events, required this.hasMore});
}

class SearchEventsFetchMoreErrorState extends SearchEventsState {
  final List<EventModel> events;
  final String errorMsg;
  const SearchEventsFetchMoreErrorState(
      {required this.events, required this.errorMsg});
}

class SearchEventsErrorState extends SearchEventsState {
  final String errorMessage;
  const SearchEventsErrorState({required this.errorMessage});
}
