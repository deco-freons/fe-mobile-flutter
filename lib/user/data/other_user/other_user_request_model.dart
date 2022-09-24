import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'other_user_request_model.g.dart';

@JsonSerializable()
class OtherUserRequestModel extends BaseModel {
  final int userID;
  final double longitude;
  final double latitude;

  const OtherUserRequestModel(
      {required this.userID, required this.longitude, required this.latitude});

  factory OtherUserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OtherUserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserRequestModelToJson(this);

  @override
  List<Object> get props => [userID];
}
