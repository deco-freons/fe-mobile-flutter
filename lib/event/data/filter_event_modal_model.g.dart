// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_event_modal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterEventModalModel _$FilterEventModalModelFromJson(
        Map<String, dynamic> json) =>
    FilterEventModalModel(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => $enumDecode(_$PrefTypeEnumMap, e))
          .toList(),
      daysChoice: $enumDecodeNullable(_$DaysFilterEnumMap, json['daysChoice']),
      distanceChoice:
          $enumDecodeNullable(_$DistanceFilterEnumMap, json['distanceChoice']),
      allCheck: json['allCheck'] as bool,
      prefCheck:
          (json['prefCheck'] as List<dynamic>).map((e) => e as bool).toList(),
      weekCheck:
          (json['weekCheck'] as List<dynamic>).map((e) => e as bool).toList(),
      distanceCheck: (json['distanceCheck'] as List<dynamic>)
          .map((e) => e as bool)
          .toList(),
    );

Map<String, dynamic> _$FilterEventModalModelToJson(
        FilterEventModalModel instance) =>
    <String, dynamic>{
      'categories':
          instance.categories.map((e) => _$PrefTypeEnumMap[e]!).toList(),
      'daysChoice': _$DaysFilterEnumMap[instance.daysChoice],
      'distanceChoice': _$DistanceFilterEnumMap[instance.distanceChoice],
      'allCheck': instance.allCheck,
      'prefCheck': instance.prefCheck,
      'weekCheck': instance.weekCheck,
      'distanceCheck': instance.distanceCheck,
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
