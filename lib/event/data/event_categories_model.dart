import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_categories_model.g.dart';

@JsonSerializable()
class EventCategoriesModel extends BaseModel {
  final List<String> category;

  const EventCategoriesModel({
    required this.category,
  });

  factory EventCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$EventCategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventCategoriesModelToJson(this);

  @override
  List<Object> get props => [category];
}
