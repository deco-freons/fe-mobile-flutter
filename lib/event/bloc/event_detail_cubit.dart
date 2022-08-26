import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/event/bloc/event_detail_state.dart';
import 'package:flutter_boilerplate/event/data/event_detail_repository.dart';

class EventDetailCubit extends BaseCubit<EventDetailState> {
  final EventDetailRepository _eventDetailRepository;

  EventDetailCubit(this._eventDetailRepository)
      : super(const EventDetailInitialState());

  Future<void> getEventDetail(int eventID) async {
    emit(const EventDetailLoadingState());
    final data = await _eventDetailRepository.getEventDetail(eventID);
    emit(EventDetailSuccessState(eventDetailResponseModel: data));
  }
}
