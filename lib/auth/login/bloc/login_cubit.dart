import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/auth/login/bloc/login_state.dart';
import 'package:flutter_boilerplate/auth/login/data/login_model.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginInitialState());

  Future<void> login(LoginModel data) async {
    try {
      emit(const LoginLoadingState());
      await _authRepository.logIn(
          username: data.username, password: data.password);
      emit(const LoginSuccessState());
    } catch (_) {
      emit(const LoginErrorState());
    }
  }
}
