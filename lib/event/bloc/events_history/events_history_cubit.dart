import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/events_history/events_history_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_request_model.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_repository.dart';
import 'package:geolocator/geolocator.dart';

class EventsHistoryCubit extends BaseCubit<EventsHistoryState> {
  final EventsJoinedRepository _eventsHistoryRepository;
  List<EventJoinedModel> _eventsHistory;

  EventsHistoryCubit(this._eventsHistoryRepository)
      : _eventsHistory = [],
        super(const EventsHistoryInitialState());

  Future<void> getEventsHistory(int page) async {
    try {
      emit(page > 0
          ? EventsHistoryFetchMoreLoadingState(events: _eventsHistory)
          : const EventsHistoryLoadingState());
      Position position = await Geolocator.getCurrentPosition();

      EventJoinedRequestModel data = EventJoinedRequestModel.history(
          latitude: position.latitude, longitude: position.longitude);

      List<EventJoinedModel> events =
          await _eventsHistoryRepository.getJoinedEvents(data, page);
      _eventsHistory = page > 0 ? [..._eventsHistory, ...events] : events;
      emit(EventsHistorySuccessState(
          events: _eventsHistory, hasMore: events.isNotEmpty));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      page > 0
          ? emit(EventsHistoryFetchMoreErrorState(
              events: _eventsHistory, errorMessage: message))
          : emit(EventsHistoryErrorState(errorMessage: message));
    }
  }
}
