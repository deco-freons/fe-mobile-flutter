// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_get_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestGetEventModel _$RequestGetEventModelFromJson(
        Map<String, dynamic> json) =>
    RequestGetEventModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      todaysDate: json['todaysDate'] as String?,
      filter: json['filter'] == null
          ? null
          : EventFilterModel.fromJson(json['filter'] as Map<String, dynamic>),
      sort: json['sort'] == null
          ? null
          : EventSortModel.fromJson(json['sort'] as Map<String, dynamic>),
      search: json['search'] == null
          ? null
          : SearchModel.fromJson(json['search'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestGetEventModelToJson(
    RequestGetEventModel instance) {
  final val = <String, dynamic>{
    'longitude': instance.longitude,
    'latitude': instance.latitude,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('todaysDate', instance.todaysDate);
  writeNotNull('filter', instance.filter?.toJson());
  writeNotNull('sort', instance.sort?.toJson());
  writeNotNull('search', instance.search?.toJson());
  return val;
}
