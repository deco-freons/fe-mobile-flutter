import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/events_schedule/events_schedue_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_joined_request_model.dart';
import 'package:flutter_boilerplate/event/data/events_joined/events_joined_repository.dart';
import 'package:geolocator/geolocator.dart';

class EventsScheduleCubit extends BaseCubit<EventsScheduleState> {
  final EventsJoinedRepository _eventsJoinedRepository;
  List<EventJoinedModel> _eventsSchedule;

  EventsScheduleCubit(this._eventsJoinedRepository)
      : _eventsSchedule = [],
        super(const EventsScheduleInitialState());

  Future<void> getEventsSchedule(int page) async {
    try {
      emit(page > 0
          ? EventsScheduleFetchMoreLoadingState(events: _eventsSchedule)
          : const EventsScheduleLoadingState());
      Position position = await Geolocator.getCurrentPosition();

      EventJoinedRequestModel data = EventJoinedRequestModel.scheduled(
          latitude: position.latitude, longitude: position.longitude);

      List<EventJoinedModel> events =
          await _eventsJoinedRepository.getJoinedEvents(data, page);
      _eventsSchedule = page > 0 ? [..._eventsSchedule, ...events] : events;
      emit(EventsScheduleSuccessState(
          events: _eventsSchedule, hasMore: events.isNotEmpty));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      page > 0
          ? emit(EventsScheduleFetchMoreErrorState(
              events: _eventsSchedule, errorMessage: message))
          : emit(EventsScheduleErrorState(errorMessage: message));
    }
  }

  Future<void> leaveEvent(int eventID) async {
    try {
      emit(const EventScheduleLeaveLoadingState());
      String message = await _eventsJoinedRepository.leaveEvent(eventID);
      _eventsSchedule =
          _eventsSchedule.where((event) => event.eventID != eventID).toList();
      emit(EventScheduleLeaveSuccessState(
          message: message, events: _eventsSchedule));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(EventsScheduleFetchMoreErrorState(
          events: _eventsSchedule, errorMessage: message));
    }
  }
}
