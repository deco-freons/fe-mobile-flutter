import 'package:dio/dio.dart';
import '../../common/bloc/base_cubit.dart';
import '../../common/data/error_model.dart';
import '../data/preference_model.dart';
import '../data/preference_repository.dart';
import 'preference_state.dart';

class PreferenceCubit extends BaseCubit<PreferenceState> {
  final PreferenceRepository _preferenceRepository;

  PreferenceCubit(this._preferenceRepository)
      : super(const PreferenceInitialState());

  Future<void> preference(PreferenceModel data) async {
    try {
      emit(const PreferenceLoadingState());
      await _preferenceRepository.preference(data);
      emit(const PreferenceSuccessState());
    } catch (e) {
      ErrorModel error;
      if (e is DioError) {
        error = ErrorModel.fromJson(e.response?.data);
      } else {
        error = ErrorModel(
            statusCode: 500, message: "Something went wrong", requestTime: 0);
      }
      emit(PreferenceErrorState(error: error));
    }
  }
}
