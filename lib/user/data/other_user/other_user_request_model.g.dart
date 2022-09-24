// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUserRequestModel _$OtherUserRequestModelFromJson(
        Map<String, dynamic> json) =>
    OtherUserRequestModel(
      userID: json['userID'] as int,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
    );

Map<String, dynamic> _$OtherUserRequestModelToJson(
        OtherUserRequestModel instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
