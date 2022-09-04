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
      weekChoice: $enumDecodeNullable(_$WeekFilterEnumMap, json['weekChoice']),
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
      'weekChoice': _$WeekFilterEnumMap[instance.weekChoice],
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

const _$WeekFilterEnumMap = {
  WeekFilter.today: 'today',
  WeekFilter.thisWeek: 'thisWeek',
  WeekFilter.twoWeeks: 'twoWeeks',
  WeekFilter.fourWeeks: 'fourWeeks',
  WeekFilter.moreThanFourWeeks: 'moreThanFourWeeks',
};

const _$DistanceFilterEnumMap = {
  DistanceFilter.belowFive: 'belowFive',
  DistanceFilter.fiveToTen: 'fiveToTen',
  DistanceFilter.aboveTen: 'aboveTen',
};
