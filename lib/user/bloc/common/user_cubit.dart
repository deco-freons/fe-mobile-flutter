import 'dart:convert';

import 'package:flutter_boilerplate/common/data/user_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/user/bloc/common/user_state.dart';
import 'package:flutter_boilerplate/user/data/common/user_repository.dart';

class UserCubit extends BaseCubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserInitialState());

  Future<void> getUser() async {
    try {
      emit(const UserLoadingState());
      String res = await _userRepository.getUser();
      UserModel user = UserModel.fromJson(jsonDecode(res));
      emit(UserSuccessState(user: user));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(UserErrorState(errorMessage: message));
    }
  }
}
