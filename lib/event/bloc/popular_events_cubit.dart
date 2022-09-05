import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/popular_events_state.dart';
import 'package:flutter_boilerplate/event/data/days_to_event_model.dart';
import 'package:flutter_boilerplate/event/data/event_categories_model.dart';
import 'package:flutter_boilerplate/event/data/event_radius_model.dart';
import 'package:flutter_boilerplate/event/data/filter_event_modal_model.dart';
import 'package:flutter_boilerplate/event/data/filter_event_model.dart';
import 'package:flutter_boilerplate/event/data/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/popular_events_repository.dart';
import 'package:flutter_boilerplate/event/data/read_event_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart' as geocode;

class PopularEventsCubit extends BaseCubit<PopularEventsState> {
  final PopularEventsRepository _popularEventsRepository;

  PopularEventsCubit(this._popularEventsRepository)
      : super(const PopularEventsInitialState());

  Future<void> getPopularEvents(List<String> data) async {
    try {
      emit(const PopularEventsLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      String todaysDate = DateTime.now().toIso8601String();

      Map res = {};
      List<List<String>> locationNames = [];

      FilterEventModel filter = FilterEventModel(
          eventCategories: data.isNotEmpty
              ? EventCategoriesModel(category: data).toJson()
              : null,
          eventRadius: null,
          daysToEvent: null);

      Map<String, dynamic> jsonFilter = filter.toJson();
      jsonFilter.removeWhere((key, value) => key == "eventRadius");
      jsonFilter.removeWhere((key, value) => key == "daysToEvent");
      if (data.isEmpty) {
        jsonFilter.removeWhere((key, value) => key == "eventCategories");
      }

      ReadEventModel readEvent = ReadEventModel.noSort(
          longitude: position.longitude,
          latitude: position.latitude,
          todaysDate: todaysDate,
          filter: jsonFilter);
      Map<String, dynamic> jsonData = readEvent.toJson();
      jsonData.removeWhere((key, value) => key == "sort");
      if (data.isEmpty) {
        jsonData.removeWhere((key, value) => key == "filter");
      }

      res = await _popularEventsRepository.getPopularEvents(jsonData);

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

  Future<void> searchEvents(FilterEventModalModel data) async {
    try {
      emit(const PopularEventsLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      String todaysDate = DateTime.now().toIso8601String();

      Map res = {};
      String? googleApiKey = dotenv.env['googleApiKey'];
      geocode.GoogleGeocoding googleGeocoding =
          geocode.GoogleGeocoding(googleApiKey!);
      List<List<String>> locationNames = [];
      List<String> categories = [];

      for (var pref in data.categories) {
        categories.add(pref.name);
      }

      FilterEventModel filter = FilterEventModel(
          eventCategories: categories.isNotEmpty
              ? EventCategoriesModel(category: categories).toJson()
              : null,
          eventRadius: data.distanceChoice != null
              ? EventRadiusModel(
                      radius: data.distanceChoice!.value,
                      isMoreOrLess: data.distanceChoice!.isMoreOrLess)
                  .toJson()
              : null,
          daysToEvent: data.daysChoice != null
              ? DaysToEventModel(
                      days: data.daysChoice!.value,
                      isMoreOrLess: data.daysChoice!.isMoreOrLess)
                  .toJson()
              : null);

      Map<String, dynamic> jsonFilter = filter.toJson();
      if (categories.isEmpty) {
        jsonFilter.removeWhere((key, value) => key == "eventCategories");
      }
      if (data.distanceChoice == null) {
        jsonFilter.removeWhere((key, value) => key == "eventRadius");
      }
      if (data.daysChoice == null) {
        jsonFilter.removeWhere((key, value) => key == "daysToEvent");
      }

      ReadEventModel readEvent = ReadEventModel.noSort(
          longitude: position.longitude,
          latitude: position.latitude,
          todaysDate: todaysDate,
          filter: jsonFilter);
      Map<String, dynamic> jsonData = readEvent.toJson();
      jsonData.removeWhere((key, value) => key == "sort");
      if (categories.isEmpty &&
          data.daysChoice == null &&
          data.distanceChoice == null) {
        jsonData.removeWhere((key, value) => key == "filter");
      }
      res = await _popularEventsRepository.searchEvents(jsonData);

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

  Future<void> getMoreEvents(FilterEventModalModel data, int pageCount) async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      String todaysDate = DateTime.now().toIso8601String();

      Map res = {};

      String? googleApiKey = dotenv.env['googleApiKey'];
      geocode.GoogleGeocoding googleGeocoding =
          geocode.GoogleGeocoding(googleApiKey!);

      List<List<String>> locationNames = [];
      List<String> categories = [];
      pageCount = pageCount + 1;
      String getMorePath = '/event/read?skip=$pageCount&take=10';

      for (var pref in data.categories) {
        categories.add(pref.name);
      }

      FilterEventModel filter = FilterEventModel(
          eventCategories: categories.isNotEmpty
              ? EventCategoriesModel(category: categories).toJson()
              : null,
          eventRadius: data.distanceChoice != null
              ? EventRadiusModel(
                      radius: data.distanceChoice!.value,
                      isMoreOrLess: data.distanceChoice!.isMoreOrLess)
                  .toJson()
              : null,
          daysToEvent: data.daysChoice != null
              ? DaysToEventModel(
                      days: data.daysChoice!.value,
                      isMoreOrLess: data.daysChoice!.isMoreOrLess)
                  .toJson()
              : null);

      Map<String, dynamic> jsonFilter = filter.toJson();
      if (categories.isEmpty) {
        jsonFilter.removeWhere((key, value) => key == "eventCategories");
      }
      if (data.distanceChoice == null) {
        jsonFilter.removeWhere((key, value) => key == "eventRadius");
      }
      if (data.daysChoice == null) {
        jsonFilter.removeWhere((key, value) => key == "daysToEvent");
      }

      ReadEventModel readEvent = ReadEventModel.noSort(
          longitude: position.longitude,
          latitude: position.latitude,
          todaysDate: todaysDate,
          filter: jsonFilter);
      Map<String, dynamic> jsonData = readEvent.toJson();
      jsonData.removeWhere((key, value) => key == "sort");
      if (categories.isEmpty &&
          data.daysChoice == null &&
          data.distanceChoice == null) {
        jsonData.removeWhere((key, value) => key == "filter");
      }

      res = await _popularEventsRepository.getMorePopularEvents(
          jsonData, getMorePath);

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

  Future<void> emitFilterState() async {
    try {
      emit(const PopularEventsFilterState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PopularEventsErrorState(errorMessage: message));
    }
  }
}
