import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/event/data/event_filter_model.dart';
import 'package:flutter_boilerplate/event/data/search_model.dart';
import 'package:flutter_boilerplate/event/data/sort_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_get_event_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class RequestGetEventModel extends BaseModel {
  final double longitude;
  final double latitude;
  final String todaysDate;
  final EventFilterModel? filter;
  final SortModel? sort;
  final SearchModel search;

  const RequestGetEventModel({
    required this.latitude,
    required this.longitude,
    required this.todaysDate,
    this.filter,
    this.sort,
    required this.search,
  });

  factory RequestGetEventModel.fromJson(Map<String, dynamic> json) =>
      _$RequestGetEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestGetEventModelToJson(this);

  @override
  List<Object> get props => [];
}
