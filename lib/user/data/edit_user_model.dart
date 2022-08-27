import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_user_model.g.dart';

@JsonSerializable()
class EditUserModel extends BaseModel {
  final String firstName;
  final String lastName;
  final String birthDate;
  final List<String> preferences;

  const EditUserModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.preferences,
  });

  factory EditUserModel.fromJson(Map<String, dynamic> json) =>
      _$EditUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserModelToJson(this);
}
