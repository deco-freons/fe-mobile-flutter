// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCategoriesModel _$EventCategoriesModelFromJson(
        Map<String, dynamic> json) =>
    EventCategoriesModel(
      category:
          (json['category'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$EventCategoriesModelToJson(
        EventCategoriesModel instance) =>
    <String, dynamic>{
      'category': instance.category,
    };
