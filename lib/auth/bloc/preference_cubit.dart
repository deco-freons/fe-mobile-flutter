import 'dart:convert';
import 'package:flutter_boilerplate/common/exception/not_found_exception.dart';

import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import '../data/preference_repository.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'preference_state.dart';

class PreferenceCubit extends BaseCubit<PreferenceState> {
  final PreferenceRepository _preferenceRepository;
  final secureStorage = SecureStorage.getInstance;

  PreferenceCubit(this._preferenceRepository)
      : super(const PreferenceInitialState());

  Future<void> preference(List<String> data) async {
    try {
      emit(const PreferenceLoadingState());

      String? user = await secureStorage.get(key: 'user');
      if (user == null) {
        throw NotFoundException();
      }
      Map<String, dynamic> userMap = json.decode(user);
      List<String> preferenceList = data;
      await secureStorage.set(key: 'user', value: json.encode(userMap));

      userMap['preferences'] = preferenceList;
      userMap['isFirstLogin'] = false;
      await secureStorage.set(key: 'user', value: json.encode(userMap));
      await _preferenceRepository.preference(data);
      emit(const PreferenceSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(PreferenceErrorState(errorMessage: message));
    }
  }
}
