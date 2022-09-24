import 'package:flutter_boilerplate/auth/bloc/register/register_state.dart';
import 'package:flutter_boilerplate/auth/data/register/register_model.dart';
import 'package:flutter_boilerplate/auth/data/register/register_repository.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterCubit(this._registerRepository) : super(const RegisterInitialState());

  Future<void> register(RegisterModel data) async {
    try {
      emit(const RegisterLoadingState());
      await _registerRepository.register(data);
      emit(const RegisterSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(RegisterErrorState(errorMessage: message));
    }
  }
}
