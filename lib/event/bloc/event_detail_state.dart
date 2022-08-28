import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';

class EventDetailState implements BaseState {
  final LoadingType status;
  final EventDetailResponseModel model;
  final String message;
  const EventDetailState(
      {this.status = LoadingType.INITIAL,
      this.model = const EventDetailResponseModel.empty(),
      this.message = ""});

  EventDetailState copyWith(
      {LoadingType? status, EventDetailResponseModel? model, String? message}) {
    return EventDetailState(
        model: model ?? this.model,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}
