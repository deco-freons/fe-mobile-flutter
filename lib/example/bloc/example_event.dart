import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/bloc/base_event.dart';

@immutable
abstract class ExampleEvent implements BaseEvent {
  const ExampleEvent();
}

class Healthcheck extends ExampleEvent {
  const Healthcheck();
}
