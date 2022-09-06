import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/bloc/edit_user_state.dart';
import 'package:flutter_boilerplate/user/data/edit_user_repository.dart';
import 'package:flutter_boilerplate/user/data/models/edit_user_model.dart';
import 'package:flutter_boilerplate/user/data/models/user_location_model.dart';

class EditUserCubit extends BaseCubit<EditUserState> {
  final EditUserRepository _editUserRepository;

  EditUserCubit(this._editUserRepository) : super(const EditUserInitialState());

  Future<void> editUser(
      EditUserModel data,
      List<PreferenceModel> preferenceModels,
      UserLocationModel location) async {
    try {
      emit(const EditUserLoadingState());
      UserModel updatedUser =
          await _editUserRepository.editUser(data, preferenceModels, location);
      emit(EditUserSuccessState(user: updatedUser));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(EditUserErrorState(errorMessage: message));
    }
  }
}
