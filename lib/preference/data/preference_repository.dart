import 'package:flutter/material.dart';
import '../../common/data/base/base_repository.dart';
import 'preference_data_provider.dart';

@immutable
abstract class PreferenceRepository implements BaseRepository {
  Future<dynamic> setFirstPreference(List<String> data);
}

class PreferenceRepositoryImpl extends PreferenceRepository {
  final PreferenceDataProvider _preferenceDataProvider =
      PreferenceDataProvider();

  @override
  Future<dynamic> setFirstPreference(List<String> data) async {
    final response = await _preferenceDataProvider.firstPreference(data);
    return response;
  }
}
