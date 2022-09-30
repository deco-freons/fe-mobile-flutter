import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_home_state.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_filter_model.dart';
import 'package:flutter_boilerplate/event/data/common/sort/event_sort_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_home_repository.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_radius_model.dart';
import 'package:geolocator/geolocator.dart';

class EventMatchingHomeCubit extends BaseCubit<EventMatchingHomeState> {
  final EventMatchingHomeRepository _eventMatchingHomeRepository;

  EventMatchingHomeCubit(this._eventMatchingHomeRepository)
      : super(const EventMatchingHomeInitialState());

  Future<void> getEventMatchingHome(DistanceFilter radius) async {
    try {
      emit(const EventMatchingHomeLoadingState());
      Position position = await Geolocator.getCurrentPosition();

      RequestGetEventModel request = RequestGetEventModel(
        latitude: position.latitude,
        longitude: position.longitude,
        filter: EventFilterModel(
            eventRadius: EventRadiusModel(
                radius: radius.value, isMoreOrLess: radius.isMoreOrLess)),
        sort: EventSortModel(
            sortBy: EventSort.mostPopular.value,
            isMoreOrLess: EventSort.mostPopular.order),
      );

      List<EventModel> res =
          await _eventMatchingHomeRepository.getEventMatchingHome(request);

      emit(EventMatchingHomeSuccessState(events: res));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(EventMatchingHomeErrorState(errorMessage: message));
    }
  }
}
