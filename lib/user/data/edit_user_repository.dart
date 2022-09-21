import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/data/edit_user_data_provider.dart';
import 'package:flutter_boilerplate/user/data/models/edit_user_model.dart';
import 'package:flutter_boilerplate/user/data/models/edit_user_model_response.dart';
import 'package:flutter_boilerplate/user/data/models/user_image_request_model.dart';
import 'package:flutter_boilerplate/user/data/models/user_location_model.dart';
import 'package:http_parser/http_parser.dart';

abstract class EditUserRepository implements BaseRepository {
  Future<EditUserModelResponse> editUser(
    EditUserModel data,
    List<PreferenceModel> preferenceModels,
    UserLocationModel location,
  );
  Future<ImageModel> uploadImage(
      UserImageRequestModel data, MediaType mediaType);
}

class EditUserRepositoryImpl extends EditUserRepository {
  final EditUserDataProvider _editUserDataProvider = EditUserDataProvider();
  final SecureStorage secureStorage = getIt.get<SecureStorage>();

  @override
  Future<EditUserModelResponse> editUser(
      EditUserModel data,
      List<PreferenceModel> preferenceModels,
      UserLocationModel location) async {
    dynamic response = await _editUserDataProvider.editUser(data);
    EditUserModelResponse updatedUser =
        EditUserModelResponse.fromJson(response["user"]);

    return updatedUser;
  }

  @override
  Future<ImageModel> uploadImage(
      UserImageRequestModel data, MediaType mediaType) async {
    dynamic response =
        await _editUserDataProvider.updateUserImage(data, mediaType);
    return ImageModel.fromJson(response["image"]);
  }
}
