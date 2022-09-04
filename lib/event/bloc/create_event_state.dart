import '../../common/bloc/base_state.dart';

abstract class CreateEventState implements BaseState {
  const CreateEventState();
}

class CreateEventInitialState extends CreateEventState {
  const CreateEventInitialState();
}

class CreateEventLoadingState extends CreateEventState {
  const CreateEventLoadingState();
}

class CreateEventSuccessState extends CreateEventState {
  const CreateEventSuccessState();
}

class CreateEventErrorState extends CreateEventState {
  final String errorMessage;
  const CreateEventErrorState({required this.errorMessage});
}
