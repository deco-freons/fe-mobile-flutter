import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_currency_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventCurrencyModel extends BaseModel {
  final String currencyShortName;
  const EventCurrencyModel({required this.currencyShortName});

  factory EventCurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$EventCurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventCurrencyModelToJson(this);

  @override
  List<Object> get props => [];
}
