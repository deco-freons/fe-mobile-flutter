import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/user/data/other_user/other_user_model.dart';

abstract class OtherUserState implements BaseState {
  const OtherUserState();
}

class OtherUserInitialState extends OtherUserState {
  const OtherUserInitialState();
}

class OtherUserLoadingState extends OtherUserState {
  const OtherUserLoadingState();
}

class OtherUserSuccessState extends OtherUserState {
  final OtherUserModel profile;
  const OtherUserSuccessState(this.profile);
}

class OtherUserErrorState extends OtherUserState {
  final String errorMessage;
  const OtherUserErrorState({required this.errorMessage});
}
