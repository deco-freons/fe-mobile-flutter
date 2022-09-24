import 'dart:async';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail/event_detail_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_repository.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_response_model.dart';

class EventDetailCubit extends BaseCubit<EventDetailState> {
  final EventDetailRepository _eventDetailRepository;
  late StreamSubscription<EventDetailResponseModel> _streamSubscription;

  EventDetailCubit(this._eventDetailRepository)
      : super(const EventDetailState()) {
    _streamSubscription =
        _eventDetailRepository.data.listen((data) => onDataChanged(data));
  }

  Future<void> onSubscriptionRequested(int eventID) async {
    try {
      emit(state.copyWith(status: LoadingType.LOADING));
      await _eventDetailRepository.getEventDetail(eventID);
      emit(state.copyWith(status: LoadingType.SUCCESS, message: ""));
    } catch (e) {
      String errorMessage = ErrorHandler.handle(e);
      emit(state.copyWith(status: LoadingType.ERROR, message: errorMessage));
    }
  }

  Future<void> onDataChanged(EventDetailResponseModel model) async {
    emit(state.copyWith(model: model));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
