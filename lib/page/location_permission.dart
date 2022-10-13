import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/page/location_denied.dart';
import 'package:flutter_boilerplate/page/walkthrough/dummy_homepage.dart';
import 'package:flutter_boilerplate/user/bloc/location_permission/location_cubit.dart';
import 'package:flutter_boilerplate/user/bloc/location_permission/location_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../common/config/theme.dart';

class LocationPermission extends StatelessWidget {
  final bool isFirstLogin;
  const LocationPermission({Key? key, required this.isFirstLogin})
      : super(key: key);
  static const routeName = '/location-permission';

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
                if (dotenv.env['releaseEnv'] == 'dev') {
                  Navigator.pushNamedAndRemoveUntil(
                      context, DummyHomepage.routeName, (route) => false);
                } else {
                  if (isFirstLogin) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, DummyHomepage.routeName, (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Dashboard.routeName, (route) => false);
                  }
                }
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
