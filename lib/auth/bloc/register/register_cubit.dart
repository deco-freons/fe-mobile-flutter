import 'package:flutter_boilerplate/auth/bloc/register/register_state.dart';
import 'package:flutter_boilerplate/auth/data/register/register_model.dart';
import 'package:flutter_boilerplate/auth/data/register/register_repository.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterCubit(this._registerRepository) : super(const RegisterInitialState());

  Future<void> register(RegisterModel data) async {
    try {
      emit(const RegisterLoadingState());
      // final response = await _registerRepository.register(data);
      await _registerRepository.register(data);
      // print(response);
      // throw Error();
      emit(const RegisterSuccessState());
    } catch (e) {
      emit(const RegisterErrorState());
    }
  }
}
