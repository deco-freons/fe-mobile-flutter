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

class BaseFetchState extends BaseState {
  const BaseFetchState();
}

class BaseErrorState extends BaseState {
  const BaseErrorState();
}
