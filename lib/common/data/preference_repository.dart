import 'package:flutter/material.dart';
import '../../common/data/base_repository.dart';
import '../../common/data/preference_data_provider.dart';
import '../../common/data/preference_model.dart';

@immutable
abstract class PreferenceRepository implements BaseRepository {
  Future<dynamic> preference(PreferenceModel data);
}

class PreferenceRepositoryImpl extends PreferenceRepository {
  final PreferenceDataProvider _preferenceDataProvider =
      PreferenceDataProvider();

  @override
  Future<dynamic> preference(PreferenceModel data) async {
    final response = await _preferenceDataProvider.preference(data);
    return response;
  }
}
