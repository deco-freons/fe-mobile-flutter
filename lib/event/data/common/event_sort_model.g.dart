// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_sort_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventSortModel _$EventSortModelFromJson(Map<String, dynamic> json) =>
    EventSortModel(
      sortBy: json['sortBy'] as String,
      isMoreOrLess: json['isMoreOrLess'] as String,
    );

Map<String, dynamic> _$EventSortModelToJson(EventSortModel instance) =>
    <String, dynamic>{
      'sortBy': instance.sortBy,
      'isMoreOrLess': instance.isMoreOrLess,
    };
