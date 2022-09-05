import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_request_model.g.dart';

@JsonSerializable()
class ProfileRequestModel extends BaseModel {
  final int userID;
  final double longitude;
  final double latitude;

  const ProfileRequestModel(
      {required this.userID, required this.longitude, required this.latitude});

  factory ProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileRequestModelToJson(this);

  @override
  List<Object> get props => [userID];
}
