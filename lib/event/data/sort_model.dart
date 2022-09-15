import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sort_model.g.dart';

@JsonSerializable(includeIfNull: false)
class SortModel extends BaseModel {
  final String sortBy;
  final String isMoreOrLess;

  const SortModel({
    required this.sortBy,
    required this.isMoreOrLess,
  });

  factory SortModel.fromJson(Map<String, dynamic> json) =>
      _$SortModelFromJson(json);

  Map<String, dynamic> toJson() => _$SortModelToJson(this);

  @override
  List<Object> get props => [sortBy, isMoreOrLess];
}
