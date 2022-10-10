// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPriceModel _$EventPriceModelFromJson(Map<String, dynamic> json) =>
    EventPriceModel(
      price: json['price'] as int,
      isMoreOrLess: json['isMoreOrLess'] as String,
    );

Map<String, dynamic> _$EventPriceModelToJson(EventPriceModel instance) =>
    <String, dynamic>{
      'price': instance.price,
      'isMoreOrLess': instance.isMoreOrLess,
    };
