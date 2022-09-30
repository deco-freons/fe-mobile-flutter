// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPriceModel _$EventPriceModelFromJson(Map<String, dynamic> json) =>
    EventPriceModel(
      fee: (json['fee'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$EventPriceModelToJson(EventPriceModel instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'currency': instance.currency,
    };
