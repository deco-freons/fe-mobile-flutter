import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_price_model.g.dart';

@JsonSerializable()
class EventPriceModel extends BaseModel {
  final double fee;
  final String currency;
  const EventPriceModel({required this.fee, required this.currency});

  factory EventPriceModel.fromJson(Map<String, dynamic> json) =>
      _$EventPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventPriceModelToJson(this);

  @override
  List<Object> get props => [];
}
