import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/popular_event/popular_events_state.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_filter_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/popular_event/popular_events_repository.dart';
import 'package:flutter_boilerplate/event/data/common/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_categories_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_radius_model.dart';
import 'package:flutter_boilerplate/event/data/common/search/search_model.dart';
import 'package:geolocator/geolocator.dart';

class PopularEventsCubit extends BaseCubit<PopularEventsState> {
  final PopularEventsRepository _popularEventsRepository;

  PopularEventsCubit(this._popularEventsRepository)
      : super(const PopularEventsInitialState());

  Future<void> getPopularEvents(
      List<String> data, DistanceFilter radius) async {
    try {
      emit(const PopularEventsLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      String todaysDate = DateTime.now().toIso8601String();

      RequestGetEventModel request = RequestGetEventModel(
        latitude: position.latitude,
        longitude: position.longitude,
        todaysDate: todaysDate,
        filter: EventFilterModel(
            eventCategories:
                data.isNotEmpty ? EventCategoriesModel(category: data) : null,
            eventRadius: EventRadiusModel(
                radius: radius.value, isMoreOrLess: radius.isMoreOrLess)),
        search: const SearchModel(
          keyword: "",
        ),
      );

      List<EventModel> res =
          await _popularEventsRepository.getPopularEvents(request);

      emit(PopularEventsSuccessState(events: res));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PopularEventsErrorState(errorMessage: message));
    }
  }
}
