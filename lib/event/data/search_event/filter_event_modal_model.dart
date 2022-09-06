import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_event_modal_model.g.dart';

@JsonSerializable()
class FilterEventModalModel extends BaseModel {
  final List<PrefType> categories;
  final DaysFilter? daysChoice;
  final DistanceFilter? distanceChoice;
  final bool allCheck;
  final List<bool> prefCheck;
  final List<bool> weekCheck;
  final List<bool> distanceCheck;

  const FilterEventModalModel({
    required this.categories,
    required this.daysChoice,
    required this.distanceChoice,
    required this.allCheck,
    required this.prefCheck,
    required this.weekCheck,
    required this.distanceCheck,
  });

  factory FilterEventModalModel.fromJson(Map<String, dynamic> json) =>
      _$FilterEventModalModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterEventModalModelToJson(this);

  @override
  List<Object> get props => [categories];
}
