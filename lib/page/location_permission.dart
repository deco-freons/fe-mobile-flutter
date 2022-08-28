import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/page/location_denied.dart';
import 'package:flutter_boilerplate/user/bloc/location_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/location_state.dart';
import '../common/config/theme.dart';

class LocationPermission extends StatefulWidget {
  const LocationPermission({Key? key}) : super(key: key);
  static const routeName = '/location-permission';

  @override
  State<LocationPermission> createState() => _LocationPermissionState();
}

class _LocationPermissionState extends State<LocationPermission> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..getLocation(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                0.55,
                1.0
              ],
                  colors: [
                primary.shade500,
                primary.shade600,
              ])),
          child: const SafeArea(child: ShowLocationPermission()),
        ),
      ),
    );
  }
}

class ShowLocationPermission extends StatefulWidget {
  final String errorMessage;

  const ShowLocationPermission({Key? key, this.errorMessage = ''})
      : super(key: key);

  @override
  State<ShowLocationPermission> createState() => _ShowLocationPermissionState();
}

class _ShowLocationPermissionState extends State<ShowLocationPermission> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationAllowedState) {
          Navigator.pushNamed(context, Dashboard.routeName);
        } else if (state is LocationDeniedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, LocationDenied.routeName, (route) => false);
        }
      },
      builder: (context, state) {
        if (state is LocationErrorState) {
          return Text(state.errorMessage);
        } else {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
                  0.55,
                  1.0
                ],
                    colors: [
                  primary.shade500,
                  primary.shade600,
                ])),
          );
        }
      },
    );
  }
}
