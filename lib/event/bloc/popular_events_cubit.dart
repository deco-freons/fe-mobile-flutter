import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/event/data/empty_nearby_model.dart';
import 'package:flutter_boilerplate/event/data/nearby_model.dart';
import 'package:flutter_boilerplate/event/data/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/popular_events_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart' as geocode;

class PopularEventsCubit extends BaseCubit<PopularEventsState> {
  final PopularEventsRepository _popularEventsRepository;

  PopularEventsCubit(this._popularEventsRepository)
      : super(const PopularEventsInitialState());

  Future<void> getPopularEvents(List<String> data, double radius) async {
    try {
      emit(const PopularEventsLoadingState());
      Position position = await Geolocator.getCurrentPosition();

      NearbyModel nearby = NearbyModel(
          categories: data,
          longitude: position.longitude,
          latitude: position.latitude,
          radius: radius);
      EmptyNearbyModel emptyNearby = EmptyNearbyModel(
          longitude: position.longitude,
          latitude: position.latitude,
          radius: radius);
      Map res = {};
      List<List<String>> locationNames = [];
      if (data.isEmpty) {
        res = await _popularEventsRepository.getPopularEventsByAll(emptyNearby);
      } else {
        res = await _popularEventsRepository.getPopularEventsByCategory(nearby);
      }
      List<PopularEventModel> events = [];
      for (var resEvent in res['events']) {
        resEvent['location'] = [];
        PopularEventModel event = PopularEventModel.fromJson(resEvent);
        events.add(event);
      }
      emit(PopularEventsSuccessState(
          events: events, locationNames: locationNames, pageCount: 0));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PopularEventsErrorState(errorMessage: message));
    }
  }

  Future<void> getAllPopularEvents(List<String> data) async {
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
      String? googleApiKey = dotenv.env['googleApiKey'];
      geocode.GoogleGeocoding googleGeocoding =
          geocode.GoogleGeocoding(googleApiKey!);
      List<List<String>> locationNames = [];

      if (data.isEmpty) {
        res = await _popularEventsRepository
            .getAllPopularEventsByAll(emptyNearby);
      } else {
        res = await _popularEventsRepository
            .getAllPopularEventsByCategory(nearby);
      }

      List<PopularEventModel> events = [];
      for (var resEvent in res['events']) {
        geocode.GeocodingResponse? response = await googleGeocoding.geocoding
            .getReverse(
                geocode.LatLon(resEvent['latitude'], resEvent['longitude']));
        if (response != null) {
          String locationName =
              response.results?[0].addressComponents?[0].longName ?? "";
          String locationArea =
              '${response.results?[0].addressComponents?[1].longName ?? ""}, ${response.results?[0].addressComponents?[2].shortName}';
          resEvent['location'] = [locationName, locationArea];
        }
        PopularEventModel event = PopularEventModel.fromJson(resEvent);
        events.add(event);
      }
      emit(PopularEventsSuccessState(
          events: events, locationNames: locationNames, pageCount: 0));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PopularEventsErrorState(errorMessage: message));
    }
  }

  Future<void> getMoreEvents(List<String> data, int pageCount) async {
    try {
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

      String? googleApiKey = dotenv.env['googleApiKey'];
      geocode.GoogleGeocoding googleGeocoding =
          geocode.GoogleGeocoding(googleApiKey!);

      List<List<String>> locationNames = [];
      pageCount = pageCount + 1;
      String getMorePath = '/event/read?skip=$pageCount&take=10';

      if (data.isEmpty) {
        res = await _popularEventsRepository.getMorePopularEventsByAll(
            emptyNearby, getMorePath);
      } else {
        res = await _popularEventsRepository.getMorePopularEventsMoreByCategory(
            nearby, getMorePath);
      }

      List<PopularEventModel> events = [];
      for (var resEvent in res['events']) {
        geocode.GeocodingResponse? response = await googleGeocoding.geocoding
            .getReverse(
                geocode.LatLon(resEvent['latitude'], resEvent['longitude']));
        if (response != null) {
          String locationName =
              response.results?[0].addressComponents?[0].longName ?? "";
          String locationArea =
              '${response.results?[0].addressComponents?[1].longName ?? ""}, ${response.results?[0].addressComponents?[2].shortName}';
          resEvent['location'] = [locationName, locationArea];
        }
        PopularEventModel event = PopularEventModel.fromJson(resEvent);
        events.add(event);
      }
      emit(PopularEventsSuccessState(
          events: events, locationNames: locationNames, pageCount: pageCount));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PopularEventsErrorState(errorMessage: message));
    }
  }
}
