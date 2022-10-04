import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_price_request_model.g.dart';

@JsonSerializable()
class EventPriceRequestModel extends BaseModel {
  final double fee;
  final String currency;
  const EventPriceRequestModel({required this.fee, required this.currency});

  factory EventPriceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EventPriceRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventPriceRequestModelToJson(this);

  @override
  List<Object> get props => [];
}
