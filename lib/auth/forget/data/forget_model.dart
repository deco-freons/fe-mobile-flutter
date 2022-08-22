import '../../../common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_model.g.dart';

@JsonSerializable()
class ForgetModel implements BaseModel {
  String email;

  ForgetModel({required this.email});

  factory ForgetModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetModelToJson(this);
}
