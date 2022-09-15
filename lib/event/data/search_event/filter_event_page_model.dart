import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/event/data/search_event/item_filter_model.dart';

class FilterEventPageModel extends BaseModel {
  final bool allCheck;
  final String searchTerm;
  final List<ItemFilterModel<PrefType>> prefCheck;
  final List<ItemFilterModel<TimeFilter>> timeCheck;
  final List<ItemFilterModel<DistanceFilter>> distanceCheck;
  final List<ItemFilterModel<EventSort>> sortCheck;

  FilterEventPageModel({
    this.searchTerm = "",
    List<ItemFilterModel<PrefType>>? prefCheck,
    List<ItemFilterModel<TimeFilter>>? timeCheck,
    List<ItemFilterModel<DistanceFilter>>? distanceCheck,
    List<ItemFilterModel<EventSort>>? sortCheck,
    bool? allCheck,
  })  : prefCheck = prefCheck ??
            PrefType.values
                .map((pref) => ItemFilterModel(data: pref, isPicked: true))
                .toList(),
        timeCheck = timeCheck ??
            TimeFilter.values.map((day) => ItemFilterModel(data: day)).toList(),
        distanceCheck = distanceCheck ??
            DistanceFilter.values
                .map((distance) => ItemFilterModel(data: distance))
                .toList(),
        sortCheck = sortCheck ??
            EventSort.values
                .map((sort) => ItemFilterModel(data: sort))
                .toList(),
        allCheck = allCheck ?? true;

  @override
  List<Object> get props => [];

  FilterEventPageModel copyWith({
    List<ItemFilterModel<PrefType>>? prefCheck,
    List<ItemFilterModel<TimeFilter>>? timeCheck,
    List<ItemFilterModel<DistanceFilter>>? distanceCheck,
    List<ItemFilterModel<EventSort>>? sortCheck,
    bool? allCheck,
    String? searchTerm,
  }) {
    return FilterEventPageModel(
        prefCheck: prefCheck ?? this.prefCheck,
        timeCheck: timeCheck ?? this.timeCheck,
        distanceCheck: distanceCheck ?? this.distanceCheck,
        sortCheck: sortCheck ?? this.sortCheck,
        allCheck: allCheck ?? this.allCheck,
        searchTerm: searchTerm ?? this.searchTerm);
  }

  bool isOnePreferencePicked(PrefType choosenCategory) {
    List<ItemFilterModel<PrefType>> pickedCategories =
        prefCheck.where((pref) => pref.isPicked).toList();
    if (pickedCategories.length != 1) {
      return false;
    }

    return pickedCategories[0].data == choosenCategory;
  }

  bool isFilterPicked<T>(T key) {
    switch (T) {
      case PrefType:
        return prefCheck.firstWhere((pref) => pref.data == key).isPicked;
      case TimeFilter:
        return timeCheck.firstWhere((time) => time.data == key).isPicked;
      case DistanceFilter:
        return distanceCheck
            .firstWhere((distance) => distance.data == key)
            .isPicked;
      case EventSort:
        return sortCheck.firstWhere((sort) => sort.data == key).isPicked;
      default:
        return false;
    }
  }
}
