import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState implements BaseState {
  const LocationState();
}

class LocationInitialState extends LocationState {
  const LocationInitialState();
}

class LocationAllowedState extends LocationState {
  final Position position;
  const LocationAllowedState({required this.position});
}

class LocationDeniedState extends LocationState {
  const LocationDeniedState();
}

class LocationDisabledState extends LocationState {
  const LocationDisabledState();
}

class LocationErrorState extends LocationState {
  final String errorMessage;
  const LocationErrorState({required this.errorMessage});
}
