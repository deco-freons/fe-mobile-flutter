import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/example/bloc/example_state.dart';
import 'package:flutter_boilerplate/example/data/example_model.dart';
import 'package:flutter_boilerplate/example/data/example_repository.dart';

class ExampleCubit extends BaseCubit<ExampleState> {
  final ExampleRepository _playerRepository;

  ExampleCubit(this._playerRepository) : super(const ExampleInitialState());

  Future<void> getPlayer() async {
    emit(const ExampleLoadingState());
    final response = await _playerRepository.healthcheck();
    emit(ExampleFetchState(model: ExampleModel(message: response["message"])));
  }
}