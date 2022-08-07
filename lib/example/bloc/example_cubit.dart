import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/example/bloc/example_state.dart';
import 'package:flutter_boilerplate/example/data/example_model.dart';
import 'package:flutter_boilerplate/example/data/example_repository.dart';

class ExampleCubit extends BaseCubit<ExampleState> {
  final ExampleRepository _exampleRepository;

  ExampleCubit(this._exampleRepository) : super(const ExampleInitialState());

  Future<void> healthcheck() async {
    emit(const ExampleLoadingState());
    final response = await _exampleRepository.healthcheck();
    emit(ExampleSuccessState(model: ExampleModel(message: response["message"])));
  }
}