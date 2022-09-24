import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:http_parser/http_parser.dart';

class EventImageRequestModel extends BaseModel {
  final int eventID;
  final File eventImage;

  const EventImageRequestModel(
      {required this.eventID, required this.eventImage});

  Future<Map<String, dynamic>> toJson(MediaType mediaType) async => {
        'eventID': eventID,
        'eventImage': await MultipartFile.fromFile(eventImage.path,
            filename: eventImage.path.split('/').last, contentType: mediaType),
      };

  @override
  List<Object> get props => [eventID];
}
