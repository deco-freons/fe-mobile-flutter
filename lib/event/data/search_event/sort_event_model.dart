import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sort_event_model.g.dart';

@JsonSerializable()
class SortEventModel extends BaseModel {
  final String sortBy;
  final String isMoreOrLess;

  const SortEventModel({required this.sortBy, required this.isMoreOrLess});

  factory SortEventModel.fromJson(Map<String, dynamic> json) =>
      _$SortEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$SortEventModelToJson(this);

  @override
  List<Object> get props => [sortBy];
}
