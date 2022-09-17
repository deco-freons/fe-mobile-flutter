import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_join_state.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_repository.dart';

class EventMatchingJoinCubit extends BaseCubit<EventMatchingJoinState> {
  final EventMatchingRepository _eventMatchingRepository;

  EventMatchingJoinCubit(this._eventMatchingRepository)
      : super(const EventMatchingJoinInitialState());

  Future<void> joinEvent(int eventId) async {
    try {
      await _eventMatchingRepository.joinEvent(eventId);
      emit(const EventMatchingJoinSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(EventMatchingJoinErrorState(errorMessage: message));
    }
  }
}
