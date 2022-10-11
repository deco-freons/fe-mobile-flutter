import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';

abstract class EventsReminderState implements BaseState {
  const EventsReminderState();
}

class EventsReminderInitialState extends EventsReminderState {
  const EventsReminderInitialState();
}

class EventsReminderLoadingState extends EventsReminderState {
  const EventsReminderLoadingState();
}

class EventsReminderSuccessState extends EventsReminderState {
  final bool hasMore;
  final List<EventJoinedModel> events;
  const EventsReminderSuccessState(
      {required this.events, required this.hasMore});
}

class EventsReminderFetchMoreLoadingState extends EventsReminderState {
  final List<EventJoinedModel> events;

  const EventsReminderFetchMoreLoadingState({required this.events});
}

class EventsReminderFetchMoreErrorState extends EventsReminderState {
  final List<EventJoinedModel> events;
  final String errorMessage;
  const EventsReminderFetchMoreErrorState(
      {required this.events, required this.errorMessage});
}

class EventsReminderErrorState extends EventsReminderState {
  final String errorMessage;
  const EventsReminderErrorState({required this.errorMessage});
}
