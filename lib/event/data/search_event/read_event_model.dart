import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'read_event_model.g.dart';

@JsonSerializable()
class ReadEventModel extends BaseModel {
  final double longitude;
  final double latitude;
  final String todaysDate;
  final Map<String, dynamic>? filter;
  final Map<String, dynamic>? sort;

  const ReadEventModel({
    required this.longitude,
    required this.latitude,
    required this.todaysDate,
    required this.filter,
    required this.sort,
  });

  const ReadEventModel.noFilter({
    required this.longitude,
    required this.latitude,
    required this.todaysDate,
    this.filter = const {},
    required this.sort,
  });

  const ReadEventModel.noSort({
    required this.longitude,
    required this.latitude,
    required this.todaysDate,
    required this.filter,
    this.sort = const {},
  });

  const ReadEventModel.noFilterAndSort({
    required this.longitude,
    required this.latitude,
    required this.todaysDate,
    this.filter = const {},
    this.sort = const {},
  });

  factory ReadEventModel.fromJson(Map<String, dynamic> json) =>
      _$ReadEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadEventModelToJson(this);

  @override
  List<Object> get props => [longitude];
}
