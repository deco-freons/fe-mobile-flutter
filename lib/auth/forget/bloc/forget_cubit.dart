import 'package:dio/dio.dart';
import '../../../common/bloc/base_cubit.dart';
import '../../../common/data/error_model.dart';
import '../data/forget_model.dart';
import 'forget_state.dart';

import '../data/forget_repository.dart';

class ForgetCubit extends BaseCubit<ForgetState> {
  final ForgetRepository _forgetRepository;

  ForgetCubit(this._forgetRepository) : super(const ForgetInitialState());

  Future<void> forget(ForgetModel data) async {
    try {
      emit(const ForgetLoadingState());
      await _forgetRepository.forget(data);
      emit(const ForgetSuccessState());
    } catch (e) {
      ErrorModel error;
      if (e is DioError) {
        error = ErrorModel.fromJson(e.response?.data);
      } else {
        error = ErrorModel(
            statusCode: 500, message: "Something went wrong", requestTime: 0);
      }
      emit(ForgetErrorState(error: error));
    }
  }
}
