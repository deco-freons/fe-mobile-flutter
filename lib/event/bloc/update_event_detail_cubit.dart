import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/update_event_detail_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';

class UpdateEventDetailCubit extends BaseCubit<UpdateEventDetailState> {
  final EventDetailRepository _eventDetailRepository;

  UpdateEventDetailCubit(this._eventDetailRepository)
      : super(const UpdateEventDetailInitialState());

  Future<void> joinEvent(int eventID) async {
    try {
      emit(const UpdateEventDetailLoadingState());
      await _eventDetailRepository.joinEvent(eventID);
      emit(const UpdateEventDetailSuccessState());
    } catch (e) {
      emit(UpdateEventDetailErrorState(errorMessage: ErrorHandler.handle(e)));
    }
  }

  Future<void> leaveEvent(int eventID) async {
    try {
      emit(const UpdateEventDetailLoadingState());
      await _eventDetailRepository.leaveEvent(eventID);

      emit(const UpdateEventDetailSuccessState());
    } catch (e) {
      emit(UpdateEventDetailErrorState(errorMessage: ErrorHandler.handle(e)));
    }
  }

  Future<void> deleteEvent(int eventID) async {
    try {
      await _eventDetailRepository.deleteEvent(eventID);
      emit(UpdateEventDetailDeletedState(eventID: eventID));
    } catch (e) {
      emit(UpdateEventDetailErrorState(errorMessage: ErrorHandler.handle(e)));
    }
  }
}