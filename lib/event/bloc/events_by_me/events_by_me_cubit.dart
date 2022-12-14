import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/events_by_me/events_by_me_state.dart';
import 'package:flutter_boilerplate/event/data/events_by_me/events_by_me_repository.dart';
import 'package:flutter_boilerplate/event/data/events_by_user/events_by_user_model.dart';
import 'package:flutter_boilerplate/event/data/events_by_me/coordinate_model.dart';
import 'package:geolocator/geolocator.dart';

class EventsByMeCubit extends BaseCubit<EventsByMeState> {
  final EventsByMeRepository _eventsByMeRepository;

  EventsByMeCubit(this._eventsByMeRepository)
      : super(const EventsByMeInitialState());

  Future<void> getEventsByMe() async {
    try {
      emit(const EventsByMeLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      CoordinateModel model = CoordinateModel(
          latitude: position.latitude, longitude: position.longitude);
      EventsByUserModel data = await _eventsByMeRepository.getEventsByMe(model);
      emit(EventsByMeSuccessState(events: data));
    } catch (e) {
      String errorMessage = ErrorHandler.handle(e);
      emit(EventsByMeErrorState(errorMessage: errorMessage));
    }
  }
}
