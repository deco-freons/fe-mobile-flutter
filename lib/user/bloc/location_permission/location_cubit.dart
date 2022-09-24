import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/user/bloc/location_permission/location_state.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends BaseCubit<LocationState> {
  LocationCubit() : super(const LocationInitialState());

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const LocationDeniedState());
        }
      }
      if (permission == LocationPermission.deniedForever) {
        emit(const LocationDeniedState());
      }

      Position position = await Geolocator.getCurrentPosition();
      emit(LocationAllowedState(position: position));
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(LocationErrorState(errorMessage: message));
    }
  }

  Future<void> openPermissionSettings() async {
    Geolocator.openAppSettings();
  }
}
