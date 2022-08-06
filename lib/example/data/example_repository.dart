import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/example/data/example_data_provider.dart';

@immutable
abstract class ExampleRepository implements BaseRepository {
  Future<dynamic> healthcheck();
}

class ExampleRepositoryImpl extends ExampleRepository {
  final ExampleDataProvider _exampleDataProvider = ExampleDataProvider();

  @override
  Future<dynamic> healthcheck() async {
    final response = await _exampleDataProvider.readData();
    return response;
  }
}