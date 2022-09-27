import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/events_history/events_history_state.dart';
import 'package:flutter_boilerplate/event/data/events_history/events_history_repository.dart';

class EventsHistoryCubit extends BaseCubit<EventsHistoryState> {
  final EventsHistoryRepository _eventsHistoryRepository;

  EventsHistoryCubit(this._eventsHistoryRepository)
      : super(const EventsHistoryInitialState());

  Future<void> getEventsHistory() async {
    try {
      await _eventsHistoryRepository.getEventsHistory();
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(EventsHistoryErrorState(errorMessage: message));
    }
  }
}
