import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';

abstract class UserState implements BaseState {
  const UserState();
}

class UserInitialState extends UserState {
  const UserInitialState();
}

class UserLoadingState extends UserState {
  const UserLoadingState();
}

class UserSuccessState extends UserState {
  final UserModel user;
  const UserSuccessState({required this.user});
}

class UserErrorState extends UserState {
  final String errorMessage;
  const UserErrorState({required this.errorMessage});
}
