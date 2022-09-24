import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/page/location_denied.dart';
import 'package:flutter_boilerplate/user/bloc/location_permission/location_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/location_permission/location_state.dart';
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
            color: neutral.shade100,
          ),
          child: SafeArea(
              child: BlocConsumer<LocationCubit, LocationState>(
            listener: (context, state) {
              if (state is LocationAllowedState) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Dashboard.routeName, (route) => false);
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
                    color: neutral.shade100,
                  ),
                );
              }
            },
          )),
        ),
      ),
    );
  }
}
