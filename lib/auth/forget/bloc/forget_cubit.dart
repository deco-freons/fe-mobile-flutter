import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import '../../../common/bloc/base_cubit.dart';
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
      String message = ErrorHandler.handle(e);
      emit(ForgetErrorState(errorMessage: message));
    }
  }
}
