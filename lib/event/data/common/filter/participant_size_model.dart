import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participant_size_model.g.dart';

@JsonSerializable(includeIfNull: false)
class ParticipantSizeModel extends BaseModel {
  final int participants;
  final String isMoreOrLess;

  const ParticipantSizeModel({
    required this.participants,
    required this.isMoreOrLess,
  });

  factory ParticipantSizeModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantSizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantSizeModelToJson(this);

  @override
  List<Object> get props => [participants];
}
