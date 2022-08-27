import 'dart:convert';

import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/common/exception/not_found_exception.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/data/edit_user_data_provider.dart';
import 'package:flutter_boilerplate/user/data/edit_user_model.dart';

abstract class EditUserRepository implements BaseRepository {
  Future<dynamic> editUser(
      EditUserModel data, List<PreferenceModel> preferenceModels);
}

class EditUserRepositoryImpl extends EditUserRepository {
  final EditUserDataProvider _editUserDataProvider = EditUserDataProvider();
  final SecureStorage secureStorage = getIt.get<SecureStorage>();

  @override
  Future<dynamic> editUser(
      EditUserModel data, List<PreferenceModel> preferenceModels) async {
    String? user = await secureStorage.get(key: 'user');
    if (user == null) {
      throw NotFoundException();
    }

    Map<String, dynamic> userMap = json.decode(user);

    userMap['firstName'] = data.firstName;
    userMap['lastName'] = data.lastName;
    userMap['birthDate'] = data.birthDate;
    List<Map<String, dynamic>> preferencejsons =
        preferenceModels.map((pref) => pref.toJson()).toList();
    userMap['preferences'] = preferencejsons;

    await secureStorage.set(key: 'user', value: json.encode(userMap));
    await _editUserDataProvider.editUser(data);

    UserModel updatedUser = UserModel.fromJson(userMap);
    return updatedUser;
  }
}
