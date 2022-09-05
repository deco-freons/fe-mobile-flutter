import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/profile/bloc/profile_state.dart';
import 'package:flutter_boilerplate/profile/data/models/profile_model.dart';
import 'package:flutter_boilerplate/profile/data/models/profile_request_model.dart';
import 'package:flutter_boilerplate/profile/data/profile_repository.dart';
import 'package:geolocator/geolocator.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(const ProfileInitialState());

  Future<void> getUserProfile(int userID) async {
    try {
      emit(const ProfileLoadingState());
      Position position = await Geolocator.getCurrentPosition();
      final ProfileRequestModel model = ProfileRequestModel(
          userID: userID,
          longitude: position.longitude,
          latitude: position.latitude);
      final ProfileModel data = await _profileRepository.getUserProfile(model);
      emit(ProfileSuccessState(data));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(ProfileErrorState(errorMessage: message));
    }
  }
}
