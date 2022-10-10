import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/event_reminder/event_reminder_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/days_to_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_filter_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_status_request_model.dart';
import 'package:flutter_boilerplate/event/data/event_reminder/event_reminder_request_model.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_repository.dart';
import 'package:geolocator/geolocator.dart';

class EventsReminderCubit extends BaseCubit<EventsReminderState> {
  final EventsJoinedRepository _eventsReminderRepository;
  List<EventJoinedModel> _eventsReminder;

  EventsReminderCubit(this._eventsReminderRepository)
      : _eventsReminder = [],
        super(const EventsReminderInitialState());

  Future<void> getEventsReminder(
      int page, List<EventJoinedModel> remainingEvents) async {
    try {
      emit(page > 0
          ? EventsReminderFetchMoreLoadingState(events: _eventsReminder)
          : const EventsReminderLoadingState());

      _eventsReminder = remainingEvents;

      Position position = await Geolocator.getCurrentPosition();
      String todaysDate = DateTime.now().toIso8601String();

      EventReminderRequestModel data = EventReminderRequestModel(
        latitude: position.latitude,
        longitude: position.longitude,
        todaysDate: todaysDate,
        filter: const EventFilterModel(
          daysToEvent: DaysToEventModel(days: 1, isMoreOrLess: 'LESS'),
          eventStatus:
              EventStatusRequestModel(status: [EventStatus.COMING_SOON]),
        ),
      );
      List<EventJoinedModel> events =
          await _eventsReminderRepository.getJoinedEventsTomorrow(data, page);
      _eventsReminder = page > 0 ? [..._eventsReminder, ...events] : events;
      emit(EventsReminderSuccessState(
          events: _eventsReminder, hasMore: events.isNotEmpty));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      page > 0
          ? emit(EventsReminderFetchMoreErrorState(
              events: _eventsReminder, errorMessage: message))
          : emit(EventsReminderErrorState(errorMessage: message));
    }
  }
}
