import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/common/data/brisbane_location_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brisbane_location_list_model.g.dart';

@JsonSerializable()
class BrisbaneLocationListModel extends BaseModel {
  final List<BrisbaneLocationModel> brisbaneLocations;

  const BrisbaneLocationListModel({
    required this.brisbaneLocations,
  });

  factory BrisbaneLocationListModel.fromJson(Map<String, dynamic> json) =>
      _$BrisbaneLocationListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrisbaneLocationListModelToJson(this);

  int getIdFromSuburb(String longName, String shortName) {
    BrisbaneLocationModel result = brisbaneLocations.singleWhere((location) =>
        location.suburb == longName || location.suburb == shortName);
    return result.location_id;
  }
}
