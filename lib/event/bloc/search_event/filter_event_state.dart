import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';

@immutable
abstract class FilterEventState implements BaseState {
  const FilterEventState();
}

class FilterEventInitialState extends FilterEventState {
  const FilterEventInitialState();
}

class FilterEventClearState extends FilterEventState {
  const FilterEventClearState();
}

class FilterEventErrorState extends FilterEventState {
  final String errorMessage;
  const FilterEventErrorState({required this.errorMessage});
}
