import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/auth/login/bloc/login_state.dart';
import 'package:flutter_boilerplate/auth/login/data/login_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginInitialState());

  Future<void> login(LoginModel data) async {
    try {
      emit(const LoginLoadingState());
      await _authRepository.logIn(data);
      emit(const LoginSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(LoginErrorState(errorMessage: message));
    }
  }
}
