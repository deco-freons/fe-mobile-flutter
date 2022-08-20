import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/auth/bloc/register/register_state.dart';
import 'package:flutter_boilerplate/auth/data/register/register_model.dart';
import 'package:flutter_boilerplate/auth/data/register/register_repository.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/data/error_model.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterCubit(this._registerRepository) : super(const RegisterInitialState());

  Future<void> register(RegisterModel data) async {
    try {
      emit(const RegisterLoadingState());
      await _registerRepository.register(data);
      emit(const RegisterSuccessState());
    } catch (e) {
      ErrorModel error;
      if (e is DioError) {
        error = ErrorModel.fromJson(e.response?.data);
      } else {
        error = ErrorModel(
            statusCode: 500, message: "Something went wrong", requestTime: 0);
      }
      emit(RegisterErrorState(error: error));
    }
  }
}
