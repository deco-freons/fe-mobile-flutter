import 'package:flutter/material.dart';

@immutable
abstract class BaseState {
  const BaseState();
}

class BaseInitialState extends BaseState {
  const BaseInitialState();
}

class BaseLoadingState extends BaseState {
  const BaseLoadingState();
}

class BaseSuccessState extends BaseState {
  const BaseSuccessState();
}

class BaseErrorState extends BaseState {
  const BaseErrorState();
}
