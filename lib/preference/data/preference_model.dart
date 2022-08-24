import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preference_model.g.dart';

@JsonSerializable()
class PreferenceModel extends BaseModel {
  final String preferenceID;
  final String preferenceName;

  const PreferenceModel(
      {required this.preferenceID, required this.preferenceName});

  factory PreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$PreferenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceModelToJson(this);
  @override
  List<Object> get props => [preferenceID];
}
