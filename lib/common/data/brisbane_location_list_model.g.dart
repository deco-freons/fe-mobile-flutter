// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brisbane_location_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrisbaneLocationListModel _$BrisbaneLocationListModelFromJson(
        Map<String, dynamic> json) =>
    BrisbaneLocationListModel(
      brisbaneLocations: (json['brisbaneLocations'] as List<dynamic>)
          .map((e) => BrisbaneLocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrisbaneLocationListModelToJson(
        BrisbaneLocationListModel instance) =>
    <String, dynamic>{
      'brisbaneLocations': instance.brisbaneLocations,
    };
