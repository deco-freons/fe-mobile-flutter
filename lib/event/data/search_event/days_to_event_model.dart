import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'days_to_event_model.g.dart';

@JsonSerializable()
class DaysToEventModel extends BaseModel {
  final int days;
  final String isMoreOrLess;

  const DaysToEventModel({
    required this.days,
    required this.isMoreOrLess,
  });

  factory DaysToEventModel.fromJson(Map<String, dynamic> json) =>
      _$DaysToEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$DaysToEventModelToJson(this);

  @override
  List<Object> get props => [days];
}
