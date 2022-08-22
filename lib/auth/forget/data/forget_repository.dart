import 'package:flutter/material.dart';
import '../../../common/data/base_repository.dart';
import 'forget_data_provider.dart';
import 'forget_model.dart';

@immutable
abstract class ForgetRepository implements BaseRepository {
  Future<dynamic> forget(ForgetModel data);
}

class ForgetRepositoryImpl extends ForgetRepository {
  final ForgetDataProvider _forgetDataProvider = ForgetDataProvider();

  @override
  Future<dynamic> forget(ForgetModel data) async {
    final response = await _forgetDataProvider.forget(data);
    return response;
  }
}
