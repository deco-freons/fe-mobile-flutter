// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_price_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPriceResponseModel _$EventPriceResponseModelFromJson(
        Map<String, dynamic> json) =>
    EventPriceResponseModel(
      priceID: json['priceID'] as int?,
      fee: (json['fee'] as num).toDouble(),
      currency:
          EventCurrencyModel.fromJson(json['currency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventPriceResponseModelToJson(
        EventPriceResponseModel instance) =>
    <String, dynamic>{
      'priceID': instance.priceID,
      'fee': instance.fee,
      'currency': instance.currency.toJson(),
    };
