// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_event_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterEventPageModel _$FilterEventPageModelFromJson(
        Map<String, dynamic> json) =>
    FilterEventPageModel(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => $enumDecode(_$PrefTypeEnumMap, e))
          .toList(),
      daysChoice: $enumDecodeNullable(_$DaysFilterEnumMap, json['daysChoice']),
      distanceChoice:
          $enumDecodeNullable(_$DistanceFilterEnumMap, json['distanceChoice']),
      sortChoice: $enumDecodeNullable(_$EventSortEnumMap, json['sortChoice']),
      allCheck: json['allCheck'] as bool,
      prefCheck:
          (json['prefCheck'] as List<dynamic>).map((e) => e as bool).toList(),
      weekCheck:
          (json['weekCheck'] as List<dynamic>).map((e) => e as bool).toList(),
      distanceCheck: (json['distanceCheck'] as List<dynamic>)
          .map((e) => e as bool)
          .toList(),
      sortCheck:
          (json['sortCheck'] as List<dynamic>).map((e) => e as bool).toList(),
    );

Map<String, dynamic> _$FilterEventPageModelToJson(
        FilterEventPageModel instance) =>
    <String, dynamic>{
      'categories':
          instance.categories.map((e) => _$PrefTypeEnumMap[e]!).toList(),
      'daysChoice': _$DaysFilterEnumMap[instance.daysChoice],
      'distanceChoice': _$DistanceFilterEnumMap[instance.distanceChoice],
      'sortChoice': _$EventSortEnumMap[instance.sortChoice],
      'allCheck': instance.allCheck,
      'prefCheck': instance.prefCheck,
      'weekCheck': instance.weekCheck,
      'distanceCheck': instance.distanceCheck,
      'sortCheck': instance.sortCheck,
    };

const _$PrefTypeEnumMap = {
  PrefType.GM: 'GM',
  PrefType.MV: 'MV',
  PrefType.DC: 'DC',
  PrefType.CL: 'CL',
  PrefType.BB: 'BB',
  PrefType.NT: 'NT',
  PrefType.FB: 'FB',
};

const _$DaysFilterEnumMap = {
  DaysFilter.oneDay: 'oneDay',
  DaysFilter.oneWeek: 'oneWeek',
  DaysFilter.twoWeeks: 'twoWeeks',
  DaysFilter.fourWeeks: 'fourWeeks',
};

const _$DistanceFilterEnumMap = {
  DistanceFilter.five: 'five',
  DistanceFilter.ten: 'ten',
  DistanceFilter.twenty: 'twenty',
  DistanceFilter.aboveTwenty: 'aboveTwenty',
};

const _$EventSortEnumMap = {
  EventSort.daysNearToFar: 'daysNearToFar',
  EventSort.daysFarToNear: 'daysFarToNear',
  EventSort.mostPopular: 'mostPopular',
  EventSort.distanceNearToFar: 'distanceNearToFar',
  EventSort.distanceFarToNear: 'distanceFarToNear',
};
