import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';

abstract class EditUserState implements BaseState {
  const EditUserState();
}

class EditUserInitialState extends EditUserState {
  const EditUserInitialState();
}

class EditUserLoadingState extends EditUserState {
  const EditUserLoadingState();
}

class EditUserSuccessState extends EditUserState {
  final UserModel user;
  const EditUserSuccessState({required this.user});
}

class EditUserErrorState extends EditUserState {
  final String errorMessage;
  const EditUserErrorState({required this.errorMessage});
}
