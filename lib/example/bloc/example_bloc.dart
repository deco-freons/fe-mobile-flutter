import 'package:flutter_boilerplate/common/bloc/base_bloc.dart';
import 'package:flutter_boilerplate/example/bloc/example_event.dart';
import 'package:flutter_boilerplate/example/bloc/example_state.dart';

import '../data/example_model.dart';
import '../data/example_repository.dart';

class ExampleBloc extends BaseBloc<ExampleEvent, ExampleState> {
  final ExampleRepository _exampleRepository;

  ExampleBloc(this._exampleRepository) : super(const ExampleInitialState()) {
    on<Healthcheck>((event, emit) async {
      emit(const ExampleLoadingState());
      final response = await _exampleRepository.healthcheck();
      emit(ExampleSuccessState(model: ExampleModel(message: response["message"])));
    });
  }
}
