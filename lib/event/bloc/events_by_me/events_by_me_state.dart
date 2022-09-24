import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/events_by_user/events_by_user_model.dart';

abstract class EventsByMeState implements BaseState {
  const EventsByMeState();
}

class EventsByMeInitialState extends EventsByMeState {
  const EventsByMeInitialState();
}

class EventsByMeLoadingState extends EventsByMeState {
  const EventsByMeLoadingState();
}

class EventsByMeSuccessState extends EventsByMeState {
  final EventsByUserModel events;
  const EventsByMeSuccessState({required this.events});
}

class EventsByMeErrorState extends EventsByMeState {
  final String errorMessage;
  const EventsByMeErrorState({required this.errorMessage});
}
