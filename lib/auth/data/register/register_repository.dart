import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/auth/data/register/register_data_provider.dart';
import 'package:flutter_boilerplate/auth/data/register/register_model.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';

@immutable
abstract class RegisterRepository implements BaseRepository {
  Future<dynamic> register(RegisterModel data);
}

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterDataProvider _registerDataProvider = RegisterDataProvider();

  @override
  Future<dynamic> register(RegisterModel data) async {
    final response = await _registerDataProvider.register(data);
    return response;
  }
}
