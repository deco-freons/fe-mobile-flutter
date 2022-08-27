import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';

abstract class EventDetailState implements BaseState {
  const EventDetailState();
}

class EventDetailInitialState extends EventDetailState {
  const EventDetailInitialState();
}

class EventDetailLoadingState extends EventDetailState {
  const EventDetailLoadingState();
}

class EventDetailSuccessState extends EventDetailState {
  final EventDetailResponseModel eventDetailResponseModel;
  const EventDetailSuccessState({required this.eventDetailResponseModel});
}

class EventDetailErrorState extends EventDetailState {
  final String errorMessage;
  const EventDetailErrorState({required this.errorMessage});
}
