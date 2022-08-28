import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/events/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/events/data/empty_nearby_model.dart';
import 'package:flutter_boilerplate/events/data/event_model.dart';
import 'package:flutter_boilerplate/events/data/event_repository.dart';
import 'package:flutter_boilerplate/events/data/nearby_model.dart';
import 'package:geolocator/geolocator.dart';

class EventCubit extends BaseCubit<PopularEventsState> {
  final EventRepository _eventRepository;

  EventCubit(this._eventRepository) : super(const PopularEventsInitialState());

  Future<void> getPopularEvents(List<String> data) async {
    try {
      emit(const PopularEventsLoadingState());
      Position position = await Geolocator.getCurrentPosition();

      NearbyModel nearby = NearbyModel(
          categories: data,
          longitude: position.longitude,
          latitude: position.latitude,
          radius: 10.0);
      EmptyNearbyModel emptyNearby = EmptyNearbyModel(
          longitude: position.longitude,
          latitude: position.latitude,
          radius: 10.0);
      Map res = {};

      if (data.isEmpty) {
        res = await _eventRepository.getAllPopularEvents(emptyNearby);
      } else {
        res = await _eventRepository.getPopularEvents(nearby);
      }

      List<EventModel> events = [];
      for (var resEvent in res['events']) {
        EventModel event = EventModel.fromJson(resEvent);
        events.add(event);
      }
      emit(PopularEventsSuccessState(events: events));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PopularEventsErrorState(errorMessage: message));
    }
  }
}
