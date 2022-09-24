import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_user_model.g.dart';

@JsonSerializable()
class EditUserModel extends BaseModel {
  final String firstName;
  final String lastName;
  final String birthDate;
  final int location;
  final bool isShareLocation;
  final List<String> preferences;

  const EditUserModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.location,
    required this.isShareLocation,
    required this.preferences,
  });

  factory EditUserModel.fromJson(Map<String, dynamic> json) =>
      _$EditUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserModelToJson(this);
}
