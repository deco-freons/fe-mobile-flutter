import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_sort_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventSortModel extends BaseModel {
  final String sortBy;
  final String isMoreOrLess;

  const EventSortModel({
    required this.sortBy,
    required this.isMoreOrLess,
  });

  factory EventSortModel.fromJson(Map<String, dynamic> json) =>
      _$EventSortModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventSortModelToJson(this);

  @override
  List<Object> get props => [sortBy, isMoreOrLess];
}
