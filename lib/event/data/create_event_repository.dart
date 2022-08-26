import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/event/data/create_event_data_provider.dart';
import 'package:flutter_boilerplate/event/data/create_event_model.dart';
import '../../common/data/base_repository.dart';

@immutable
abstract class CreateEventRepository implements BaseRepository {
  Future<dynamic> createEvent(CreateEventModel data);
}

class CreateEventRepositoryImpl extends CreateEventRepository {
  final CreateEventDataProvider _createEventDataProvider =
      CreateEventDataProvider();

  @override
  Future<dynamic> createEvent(CreateEventModel data) async {
    final response = await _createEventDataProvider.createEvent(data);
    return response;
  }
}
