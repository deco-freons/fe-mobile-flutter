import 'dart:convert';
import 'dart:io';

import 'package:flutter_boilerplate/common/data/user_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/common/utils/file_parser.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/bloc/update_user/edit_user_state.dart';
import 'package:flutter_boilerplate/user/data/update_user/edit_user_repository.dart';
import 'package:flutter_boilerplate/user/data/update_user/edit_user_model.dart';
import 'package:flutter_boilerplate/user/data/update_user/edit_user_model_response.dart';
import 'package:flutter_boilerplate/user/data/common/user_image_request_model.dart';
import 'package:flutter_boilerplate/user/data/common/user_location_model.dart';
import 'package:http_parser/http_parser.dart';

class EditUserCubit extends BaseCubit<EditUserState> {
  final EditUserRepository _editUserRepository;

  EditUserCubit(this._editUserRepository) : super(const EditUserInitialState());
  final SecureStorage _secureStorage = getIt.get<SecureStorage>();
  Future<void> editUser(
      EditUserModel data,
      List<PreferenceModel> preferenceModels,
      UserLocationModel location,
      File? image,
      ImageInputAction action) async {
    try {
      emit(const EditUserLoadingState());

      String? user = await _secureStorage.get(key: 'user');
      if (user == null) {
        return emit(const EditUserErrorState(errorMessage: "User Not Found"));
      }

      Map<String, dynamic> userMap = json.decode(user);
      UserModel currentUser = UserModel.fromJson(userMap);

      EditUserModelResponse userResponse =
          await _editUserRepository.editUser(data, preferenceModels, location);

      UserModel updatedUser = currentUser.copyWith(
        firstName: userResponse.firstName,
        lastName: userResponse.lastName,
        birthDate: userResponse.birthDate,
        isShareLocation: userResponse.isShareLocation,
        location: userResponse.location,
        preferences: userResponse.preferences,
      );

      ImageModel? updatedImage;
      if (action == ImageInputAction.UPLOAD && image != null) {
        updatedImage = await _uploadUserImage(image);
        updatedUser = updatedUser.copyWith(
            userImage: updatedImage ?? updatedUser.userImage);
      } else if (action == ImageInputAction.REMOVE) {
        // REMOVE IMAGE HERE
      }

      await _secureStorage.set(
          key: 'user', value: json.encode(updatedUser.toJson()));

      updatedImage != null || action == ImageInputAction.DO_NOTHING
          ? emit(EditUserSuccessState(user: updatedUser))
          : emit(EditUserImageErrorState(
              errorMessage: "Image upload failed", user: updatedUser));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(EditUserErrorState(errorMessage: message));
    }
  }

  Future<ImageModel?> _uploadUserImage(File image) async {
    try {
      UserImageRequestModel imageData = UserImageRequestModel(userImage: image);
      List<String>? mimeType = FileParser.getFileMime(imageData.userImage.path);
      if (mimeType == null) return null;
      return await _editUserRepository.uploadImage(
          imageData, MediaType(mimeType[0], mimeType[1]));
    } catch (e) {
      return null;
    }
  }
}
