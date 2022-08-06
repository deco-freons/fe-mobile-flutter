import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';

import '../data/example_model.dart';

@immutable
abstract class ExampleState implements BaseState {
  const ExampleState();
}

class ExampleInitialState extends ExampleState{
  const ExampleInitialState();
}

class ExampleLoadingState extends ExampleState {
  const ExampleLoadingState();
}

class ExampleFetchState extends ExampleState {
  final ExampleModel model;
  const ExampleFetchState({
    required this.model
  });
}

class ExampleErrorState extends ExampleState {
  const ExampleErrorState();
}