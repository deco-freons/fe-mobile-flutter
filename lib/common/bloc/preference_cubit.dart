import '../../common/bloc/base_cubit.dart';
import '../data/preference_model.dart';
import '../data/preference_repository.dart';
import '../utils/error_handler.dart';
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
      String message = ErrorHandler.handle(e);
      emit(PreferenceErrorState(errorMessage: message));
    }
  }
}
