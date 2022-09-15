import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/popular_events_state.dart';
import 'package:flutter_boilerplate/event/data/search_event/event_categories_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/event_radius_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/filter_event_page_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/filter_event_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/popular_event_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/popular_events_repository.dart';
import 'package:flutter_boilerplate/event/data/search_event/read_event_model.dart';
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

      Map res = {};
      List<List<String>> locationNames = [];

      FilterEventModel filter = FilterEventModel(
          eventCategories: data.isNotEmpty
              ? EventCategoriesModel(category: data).toJson()
              : null,
          eventRadius: EventRadiusModel(
                  radius: radius.value, isMoreOrLess: radius.isMoreOrLess)
              .toJson(),
          daysToEvent: null);

      Map<String, dynamic> jsonFilter = filter.toJson();
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

      res = await _popularEventsRepository.getPopularEvents(jsonData);

      List<PopularEventModel> events = [];
      for (var resEvent in res['events']) {
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

  Future<void> searchEvents(FilterEventPageModel data) async {
    try {
      emit(const PopularEventsLoadingState());
      // Position position = await Geolocator.getCurrentPosition();
      // String todaysDate = DateTime.now().toIso8601String();

      // Map res = {};
      // List<List<String>> locationNames = [];
      // List<String> categories = [];

      // for (var pref in data.categories) {
      //   categories.add(pref.name);
      // }

      // FilterEventModel filter = FilterEventModel(
      //     eventCategories: categories.isNotEmpty
      //         ? EventCategoriesModel(category: categories).toJson()
      //         : null,
      //     eventRadius: data.distanceChoice != null
      //         ? EventRadiusModel(
      //                 radius: data.distanceChoice!.value,
      //                 isMoreOrLess: data.distanceChoice!.isMoreOrLess)
      //             .toJson()
      //         : null,
      //     daysToEvent: data.daysChoice != null
      //         ? DaysToEventModel(
      //                 days: data.daysChoice!.value,
      //                 isMoreOrLess: data.daysChoice!.isMoreOrLess)
      //             .toJson()
      //         : null);

      // Map<String, dynamic> jsonFilter = filter.toJson();
      // if (categories.isEmpty) {
      //   jsonFilter.removeWhere((key, value) => key == "eventCategories");
      // }
      // if (data.distanceChoice == null) {
      //   jsonFilter.removeWhere((key, value) => key == "eventRadius");
      // }
      // if (data.daysChoice == null) {
      //   jsonFilter.removeWhere((key, value) => key == "daysToEvent");
      // }

      // ReadEventModel readEvent = ReadEventModel(
      //     longitude: position.longitude,
      //     latitude: position.latitude,
      //     todaysDate: todaysDate,
      //     filter: jsonFilter,
      //     sort: data.sortChoice != null
      //         ? SortEventModel(
      //                 sortBy: data.sortChoice!.value,
      //                 isMoreOrLess: data.sortChoice!.order)
      //             .toJson()
      //         : null);
      // Map<String, dynamic> jsonData = readEvent.toJson();
      // if (categories.isEmpty &&
      //     data.daysChoice == null &&
      //     data.distanceChoice == null) {
      //   jsonData.removeWhere((key, value) => key == "filter");
      // }
      // if (data.sortChoice == null) {
      //   jsonData.removeWhere((key, value) => key == "sort");
      // }
      // res = await _popularEventsRepository.searchEvents(jsonData);
      // List<PopularEventModel> events = [];
      // for (var resEvent in res['events']) {
      //   PopularEventModel event = PopularEventModel.fromJson(resEvent);
      //   events.add(event);
      // }
      emit(const PopularEventsSuccessState(
          events: [], locationNames: [], pageCount: 0));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PopularEventsErrorState(errorMessage: message));
    }
  }

  Future<void> getMoreEvents(FilterEventPageModel data, int pageCount) async {
    try {
      // Position position = await Geolocator.getCurrentPosition();
      // String todaysDate = DateTime.now().toIso8601String();

      // Map res = {};

      // List<List<String>> locationNames = [];
      // List<String> categories = [];
      // pageCount = pageCount + 1;
      // String getMorePath = '/event/read?skip=$pageCount&take=10';

      // for (var pref in data.categories) {
      //   categories.add(pref.name);
      // }

      // FilterEventModel filter = FilterEventModel(
      //     eventCategories: categories.isNotEmpty
      //         ? EventCategoriesModel(category: categories).toJson()
      //         : null,
      //     eventRadius: data.distanceChoice != null
      //         ? EventRadiusModel(
      //                 radius: data.distanceChoice!.value,
      //                 isMoreOrLess: data.distanceChoice!.isMoreOrLess)
      //             .toJson()
      //         : null,
      //     daysToEvent: data.daysChoice != null
      //         ? DaysToEventModel(
      //                 days: data.daysChoice!.value,
      //                 isMoreOrLess: data.daysChoice!.isMoreOrLess)
      //             .toJson()
      //         : null);

      // Map<String, dynamic> jsonFilter = filter.toJson();
      // if (categories.isEmpty) {
      //   jsonFilter.removeWhere((key, value) => key == "eventCategories");
      // }
      // if (data.distanceChoice == null) {
      //   jsonFilter.removeWhere((key, value) => key == "eventRadius");
      // }
      // if (data.daysChoice == null) {
      //   jsonFilter.removeWhere((key, value) => key == "daysToEvent");
      // }

      // ReadEventModel readEvent = ReadEventModel(
      //     longitude: position.longitude,
      //     latitude: position.latitude,
      //     todaysDate: todaysDate,
      //     filter: jsonFilter,
      //     sort: data.sortChoice != null
      //         ? SortEventModel(
      //                 sortBy: data.sortChoice!.value,
      //                 isMoreOrLess: data.sortChoice!.order)
      //             .toJson()
      //         : null);
      // Map<String, dynamic> jsonData = readEvent.toJson();
      // if (categories.isEmpty &&
      //     data.daysChoice == null &&
      //     data.distanceChoice == null) {
      //   jsonData.removeWhere((key, value) => key == "filter");
      // }
      // if (data.sortChoice == null) {
      //   jsonData.removeWhere((key, value) => key == "sort");
      // }
      // res = await _popularEventsRepository.getMorePopularEvents(
      //     jsonData, getMorePath);

      // List<PopularEventModel> events = [];
      // for (var resEvent in res['events']) {
      //   PopularEventModel event = PopularEventModel.fromJson(resEvent);
      //   events.add(event);
      // }
      emit(PopularEventsSuccessState(
          events: const [], locationNames: const [], pageCount: pageCount));
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
