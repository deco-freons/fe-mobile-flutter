import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';

abstract class EventsScheduleState implements BaseState {
  const EventsScheduleState();
}

class EventsScheduleInitialState extends EventsScheduleState {
  const EventsScheduleInitialState();
}

class EventsScheduleLoadingState extends EventsScheduleState {
  const EventsScheduleLoadingState();
}

class EventsScheduleSuccessState extends EventsScheduleState {
  final bool hasMore;
  final List<EventJoinedModel> events;
  const EventsScheduleSuccessState(
      {required this.events, required this.hasMore});
}

class EventsScheduleFetchMoreLoadingState extends EventsScheduleState {
  final List<EventJoinedModel> events;

  const EventsScheduleFetchMoreLoadingState({required this.events});
}

class EventScheduleLeaveLoadingState extends EventsScheduleState {
  const EventScheduleLeaveLoadingState();
}

class EventScheduleLeaveSuccessState extends EventsScheduleState {
  final String message;
  final List<EventJoinedModel> events;
  const EventScheduleLeaveSuccessState(
      {required this.message, required this.events});
}

class EventsScheduleFetchMoreErrorState extends EventsScheduleState {
  final List<EventJoinedModel> events;
  final String errorMessage;
  const EventsScheduleFetchMoreErrorState(
      {required this.events, required this.errorMessage});
}

class EventsScheduleErrorState extends EventsScheduleState {
  final String errorMessage;
  const EventsScheduleErrorState({required this.errorMessage});
}
