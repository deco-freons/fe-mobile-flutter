import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_event_page_model.g.dart';

@JsonSerializable()
class FilterEventPageModel extends BaseModel {
  final List<PrefType> categories;
  final DaysFilter? daysChoice;
  final DistanceFilter? distanceChoice;
  final EventSort? sortChoice;
  final bool allCheck;
  final List<bool> prefCheck;
  final List<bool> weekCheck;
  final List<bool> distanceCheck;
  final List<bool> sortCheck;

  const FilterEventPageModel(
      {required this.categories,
      required this.daysChoice,
      required this.distanceChoice,
      required this.sortChoice,
      required this.allCheck,
      required this.prefCheck,
      required this.weekCheck,
      required this.distanceCheck,
      required this.sortCheck});

  factory FilterEventPageModel.fromJson(Map<String, dynamic> json) =>
      _$FilterEventPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterEventPageModelToJson(this);

  @override
  List<Object> get props => [categories];
}
