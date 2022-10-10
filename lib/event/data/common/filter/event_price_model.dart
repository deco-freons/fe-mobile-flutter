import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_price_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventPriceModel extends BaseModel {
  final int price;
  final String isMoreOrLess;

  const EventPriceModel({
    required this.price,
    required this.isMoreOrLess,
  });

  factory EventPriceModel.fromJson(Map<String, dynamic> json) =>
      _$EventPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventPriceModelToJson(this);

  @override
  List<Object> get props => [price];
}
