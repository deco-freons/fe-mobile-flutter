import 'dart:convert';
import 'package:flutter_boilerplate/common/exception/not_found_exception.dart';

import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/preference/data/preference_repository.dart';
import 'preference_state.dart';

class PreferenceCubit extends BaseCubit<PreferenceState> {
  final PreferenceRepository _preferenceRepository;
  final SecureStorage secureStorage = getIt.get<SecureStorage>();

  PreferenceCubit(this._preferenceRepository)
      : super(const PreferenceInitialState());

  Future<void> setFirstPreference(List<String> data) async {
    try {
      emit(const PreferenceLoadingState());

      String? user = await secureStorage.get(key: 'user');
      if (user == null) {
        throw NotFoundException();
      }
      Map<String, dynamic> userMap = json.decode(user);
      List<String> preferenceList = data;

      userMap['preferences'] = preferenceList;
      userMap['isFirstLogin'] = false;
      await secureStorage.set(key: 'user', value: json.encode(userMap));
      await _preferenceRepository.setFirstPreference(data);
      emit(const PreferenceSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PreferenceErrorState(errorMessage: message));
    }
  }

  Future<void> skipFirstPreference() async {
    try {
      emit(const PreferenceLoadingState());

      String? user = await secureStorage.get(key: 'user');
      if (user == null) {
        throw NotFoundException();
      }
      Map<String, dynamic> userMap = json.decode(user);

      userMap['isFirstLogin'] = false;
      await secureStorage.set(key: 'user', value: json.encode(userMap));
      emit(const PreferenceSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PreferenceErrorState(errorMessage: message));
    }
  }
}
