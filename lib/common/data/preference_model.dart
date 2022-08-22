import '../../common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preference_model.g.dart';

@JsonSerializable()
class PreferenceModel implements BaseModel {
  List<String> preferenceList;

  PreferenceModel({required this.preferenceList});

  factory PreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$PreferenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceModelToJson(this);
}
