import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';

abstract class EventsHistoryState implements BaseState {
  const EventsHistoryState();
}

class EventsHistoryInitialState extends EventsHistoryState {
  const EventsHistoryInitialState();
}

class EventsHistoryLoadingState extends EventsHistoryState {
  const EventsHistoryLoadingState();
}

class EventsHistorySuccessState extends EventsHistoryState {
  final bool hasMore;
  final List<EventJoinedModel> events;
  const EventsHistorySuccessState(
      {required this.events, required this.hasMore});
}

class EventsHistoryFetchMoreLoadingState extends EventsHistoryState {
  final List<EventJoinedModel> events;

  const EventsHistoryFetchMoreLoadingState({required this.events});
}

class EventsHistoryFetchMoreErrorState extends EventsHistoryState {
  final List<EventJoinedModel> events;
  final String errorMessage;
  const EventsHistoryFetchMoreErrorState(
      {required this.events, required this.errorMessage});
}

class EventsHistoryErrorState extends EventsHistoryState {
  final String errorMessage;
  const EventsHistoryErrorState({required this.errorMessage});
}
