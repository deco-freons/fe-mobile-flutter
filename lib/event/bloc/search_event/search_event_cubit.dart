import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/search_event_state.dart';
import 'package:flutter_boilerplate/event/data/popular_event/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/request_get_event_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/models/filter_event_page_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/search_event_repository.dart';
import 'package:geolocator/geolocator.dart';

class SearchEventsCubit extends BaseCubit<SearchEventsState> {
  final SearchEventsRepository _searchEventsRepository;
  List<PopularEventModel> eventList;

  SearchEventsCubit(this._searchEventsRepository)
      : eventList = [],
        super(const SearchEventsInitialState());

  Future<void> searchEvents(FilterEventPageModel data) async {
    try {
      emit(const SearchEventsLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      String todaysDate = DateTime.now().toIso8601String();

      RequestGetEventModel request =
          data.toRequestGetEventModel(position, todaysDate);

      List<PopularEventModel> events =
          await _searchEventsRepository.searchEvents(request);

      eventList = [...events];
      emit(SearchEventsSuccessState(events: eventList, pageCount: 0));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(SearchEventsErrorState(errorMessage: message));
    }
  }

  Future<void> getMoreEvents(FilterEventPageModel data, int pageCount) async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      String todaysDate = DateTime.now().toIso8601String();
      int nextPage = pageCount + 1;

      RequestGetEventModel request =
          data.toRequestGetEventModel(position, todaysDate);

      List<PopularEventModel> events =
          await _searchEventsRepository.getMoreSearchEvents(request, nextPage);

      eventList = [...eventList, ...events];
      emit(SearchEventsSuccessState(events: eventList, pageCount: nextPage));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(SearchEventsErrorState(errorMessage: message));
    }
  }
}
