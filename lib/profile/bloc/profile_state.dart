import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/profile/data/models/profile_model.dart';

abstract class ProfileState implements BaseState {
  const ProfileState();
}

class ProfileInitialState extends ProfileState {
  const ProfileInitialState();
}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

class ProfileSuccessState extends ProfileState {
  final ProfileModel profile;
  const ProfileSuccessState(this.profile);
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;
  const ProfileErrorState({required this.errorMessage});
}
