import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_filter_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_radius_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_sort_model.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_repository.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:geolocator/geolocator.dart';

class EventMatchingCubit extends BaseCubit<EventMatchingState> {
  final EventMatchingRepository _eventMatchingRepository;
  bool hasMore = true;
  int pageCount = 0;

  EventMatchingCubit(this._eventMatchingRepository)
      : super(const EventMatchingInitialState());

  Future<void> getEvents(DistanceFilter radius, bool resetPageCount) async {
    try {
      emit(const EventMatchingLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      EventSort sort = EventSort.mostPopular;

      if (resetPageCount) {
        pageCount = 0;
      }

      RequestGetEventModel request = RequestGetEventModel(
        latitude: position.latitude,
        longitude: position.longitude,
        filter: EventFilterModel(
          eventRadius: EventRadiusModel(
            radius: radius.value,
            isMoreOrLess: radius.isMoreOrLess,
          ),
        ),
        sort: EventSortModel(sortBy: sort.value, isMoreOrLess: sort.order),
      );

      List<PopularEventModel> res =
          await _eventMatchingRepository.getEvents(request, pageCount);

      if (res.isEmpty) {
        hasMore = false;
      }

      emit(EventMatchingSuccessState(
          events: res, pageCount: pageCount, hasMore: hasMore));
      pageCount++;
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(EventMatchingErrorState(errorMessage: message));
    }
  }
}
