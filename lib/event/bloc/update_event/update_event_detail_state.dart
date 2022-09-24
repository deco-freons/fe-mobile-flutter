import 'package:flutter_boilerplate/common/bloc/base_state.dart';

abstract class UpdateEventDetailState implements BaseState {
  const UpdateEventDetailState();
}

class UpdateEventDetailInitialState extends UpdateEventDetailState {
  const UpdateEventDetailInitialState();
}

class UpdateEventDetailLoadingState extends UpdateEventDetailState {
  const UpdateEventDetailLoadingState();
}

class UpdateEventDetailSuccessState extends UpdateEventDetailState {
  const UpdateEventDetailSuccessState();
}

class UpdateEventDetailDeletedState extends UpdateEventDetailState {
  final int eventID;
  const UpdateEventDetailDeletedState({required this.eventID});
}

class UpdateEventDetailEditedState extends UpdateEventDetailState {
  const UpdateEventDetailEditedState();
}

class UpdateEventDetailImageErrorState extends UpdateEventDetailState {
  final String errorMessage;
  const UpdateEventDetailImageErrorState({required this.errorMessage});
}

class UpdateEventDetailErrorState extends UpdateEventDetailState {
  final String errorMessage;
  const UpdateEventDetailErrorState({required this.errorMessage});
}
