import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/user/bloc/other_user/other_user_state.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_model.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_request_model.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_repository.dart';
import 'package:geolocator/geolocator.dart';

class OtherUserCubit extends BaseCubit<OtherUserState> {
  final OtherUserRepository _profileRepository;

  OtherUserCubit(this._profileRepository)
      : super(const OtherUserInitialState());

  Future<void> getUserProfile(int userID) async {
    try {
      emit(const OtherUserLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      final OtherUserRequestModel model = OtherUserRequestModel(
          userID: userID,
          longitude: position.longitude,
          latitude: position.latitude);
      final OtherUserModel data =
          await _profileRepository.getUserProfile(model);
      emit(OtherUserSuccessState(data));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(OtherUserErrorState(errorMessage: message));
    }
  }
}
