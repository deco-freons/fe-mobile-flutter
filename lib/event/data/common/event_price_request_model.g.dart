// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_price_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPriceRequestModel _$EventPriceRequestModelFromJson(
        Map<String, dynamic> json) =>
    EventPriceRequestModel(
      fee: json['fee'] as int,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$EventPriceRequestModelToJson(
        EventPriceRequestModel instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'currency': instance.currency,
    };
