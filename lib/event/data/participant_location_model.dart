import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participant_location_model.g.dart';

@JsonSerializable()
class ParticipantLocationModel extends BaseModel {
  final String suburb;
  const ParticipantLocationModel({required this.suburb});

  factory ParticipantLocationModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantLocationModelToJson(this);

  @override
  List<Object> get props => [suburb];
}
