import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/auth/logout/bloc/logout_state.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';

class LogoutCubit extends BaseCubit<LogoutState> {
  final AuthRepository _authRepository;

  LogoutCubit(this._authRepository) : super(const LogoutInitialState());

  Future<void> logout() async {
    try {
      emit(const LogoutLoadingState());
      await _authRepository.logOut();
      emit(const LogoutSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(LogoutErrorState(errorMessage: message));
    }
  }
}
