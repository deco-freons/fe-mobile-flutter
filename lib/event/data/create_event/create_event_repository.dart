import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/event/data/create_event/create_event_data_provider.dart';
import 'package:flutter_boilerplate/event/data/create_event/create_event_model.dart';
import '../../../common/data/base/base_repository.dart';

@immutable
abstract class CreateEventRepository implements BaseRepository {
  Future<dynamic> createEvent(CreateEventModel data);
  Future<dynamic> uploadImage(Map<String, dynamic> data);
}

class CreateEventRepositoryImpl extends CreateEventRepository {
  final CreateEventDataProvider _createEventDataProvider =
      CreateEventDataProvider();

  @override
  Future<dynamic> createEvent(CreateEventModel data) async {
    final response = await _createEventDataProvider.createEvent(data);
    return response;
  }

  @override
  Future<dynamic> uploadImage(Map<String, dynamic> data) async {
    final response = await _createEventDataProvider.uploadImage(data);
    return response;
  }
}
