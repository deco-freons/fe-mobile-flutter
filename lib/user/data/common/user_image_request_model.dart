import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:http_parser/http_parser.dart';

class UserImageRequestModel extends BaseModel {
  final File userImage;

  const UserImageRequestModel({required this.userImage});

  Future<Map<String, dynamic>> toJson(MediaType mediaType) async => {
        'userImage': await MultipartFile.fromFile(userImage.path,
            filename: userImage.path.split('/').last, contentType: mediaType),
      };

  @override
  List<Object> get props => [userImage];
}
