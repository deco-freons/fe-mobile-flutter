import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_filter_model.dart';
import 'package:flutter_boilerplate/event/data/common/search_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_sort_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_get_event_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class RequestGetEventModel extends BaseModel {
  final double longitude;
  final double latitude;
  final String? todaysDate;
  final EventFilterModel? filter;
  final EventSortModel? sort;
  final SearchModel? search;

  const RequestGetEventModel({
    required this.latitude,
    required this.longitude,
    this.todaysDate,
    this.filter,
    this.sort,
    this.search,
  });

  factory RequestGetEventModel.fromJson(Map<String, dynamic> json) =>
      _$RequestGetEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestGetEventModelToJson(this);

  @override
  List<Object> get props => [];
}
