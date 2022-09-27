import 'package:flutter_boilerplate/common/bloc/base_state.dart';

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
  const EventsHistorySuccessState();
}

class EventsHistoryErrorState extends EventsHistoryState {
  final String errorMessage;
  const EventsHistoryErrorState({required this.errorMessage});
}
