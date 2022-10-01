import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_currency_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_price_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventPriceResponseModel extends BaseModel {
  final int priceID;
  final int fee;
  final EventCurrencyModel currency;
  const EventPriceResponseModel(
      {required this.priceID, required this.fee, required this.currency});

  EventPriceResponseModel copyWith(
      {int? priceID, int? fee, EventCurrencyModel? currency}) {
    return EventPriceResponseModel(
      priceID: priceID ?? this.priceID,
      fee: fee ?? this.fee,
      currency: currency ?? this.currency,
    );
  }

  factory EventPriceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EventPriceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventPriceResponseModelToJson(this);

  @override
  List<Object> get props => [];
}
