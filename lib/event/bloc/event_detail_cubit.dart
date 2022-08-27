import 'dart:convert';

import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/exception/not_found_exception.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/event/bloc/event_detail_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';
import 'package:flutter_boilerplate/event/data/event_participant_model.dart';
import 'package:flutter_boilerplate/get_it.dart';

class EventDetailCubit extends BaseCubit<EventDetailState> {
  final EventDetailRepository _eventDetailRepository;
  late EventDetailResponseModel _eventDetailResponseModel;
  final SecureStorage _secureStorage = getIt.get<SecureStorage>();

  EventDetailCubit(this._eventDetailRepository)
      : super(const EventDetailInitialState());

  Future<void> getEventDetail(int eventID) async {
    try {
      emit(const EventDetailLoadingState());
      _eventDetailResponseModel =
          await _eventDetailRepository.getEventDetail(eventID);
      emit(EventDetailSuccessState(
          eventDetailResponseModel: _eventDetailResponseModel));
    } catch (e) {
      String errorMessage = ErrorHandler.handle(e);
      emit(EventDetailErrorState(errorMessage: errorMessage));
    }
  }

  Future<void> joinEvent(int eventID) async {
    try {
      String? userString = await _secureStorage.get(key: "user");
      if (userString == null) {
        throw NotFoundException();
      }
      Map<String, dynamic> userMap = jsonDecode(userString);
      EventParticipantModel user = EventParticipantModel.fromJson(userMap);
      await _eventDetailRepository.joinEvent(eventID);
      _eventDetailResponseModel = _eventDetailResponseModel.copyWith(
          event: _eventDetailResponseModel.event.copyWith(
              participated: true,
              participants: _eventDetailResponseModel.event.participants + 1,
              participantList: [
            ..._eventDetailResponseModel.event.participantsList,
            user
          ]));
      emit(EventDetailSuccessState(
          eventDetailResponseModel: _eventDetailResponseModel));
    } catch (e) {
      String errorMessage = ErrorHandler.handle(e);
      emit(EventDetailErrorState(errorMessage: errorMessage));
    }
  }
}
