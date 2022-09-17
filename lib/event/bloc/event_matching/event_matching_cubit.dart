import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/item_filter_model.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_filter_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_radius_model.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/search_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_repository.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/filter_event_page_model.dart';
import 'package:geolocator/geolocator.dart';

class EventMatchingCubit extends BaseCubit<EventMatchingState> {
  final EventMatchingRepository _eventMatchingRepository;

  EventMatchingCubit(this._eventMatchingRepository)
      : super(const EventMatchingInitialState());

  Future<void> getEvents(DistanceFilter radius) async {
    try {
      emit(const EventMatchingLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      String todaysDate = DateTime.now().toIso8601String();

      RequestGetEventModel request = RequestGetEventModel(
        latitude: position.latitude,
        longitude: position.longitude,
        todaysDate: todaysDate,
        filter: EventFilterModel(
            eventRadius: EventRadiusModel(
                radius: radius.value, isMoreOrLess: radius.isMoreOrLess)),
        search: const SearchModel(keyword: ""),
      );
      
      List<PopularEventModel> res =
          await _eventMatchingRepository.getEvents(request);

      emit(EventMatchingSuccessState(events: res));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(EventMatchingErrorState(errorMessage: message));
    }
  }
}
