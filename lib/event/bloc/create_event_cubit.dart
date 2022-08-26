import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/create_event_state.dart';
import 'package:flutter_boilerplate/event/data/create_event_model.dart';
import 'package:flutter_boilerplate/event/data/create_event_repository.dart';

class CreateEventCubit extends BaseCubit<CreateEventState> {
  final CreateEventRepository _createEventRepository;

  CreateEventCubit(this._createEventRepository)
      : super(const CreateEventInitialState());

  Future<void> createEvent(CreateEventModel data) async {
    try {
      emit(const CreateEventLoadingState());
      await _createEventRepository.createEvent(data);
      emit(const CreateEventSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(CreateEventErrorState(errorMessage: message));
    }
  }
}
