import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/page/location_permission.dart';
import 'package:flutter_boilerplate/user/bloc/location_cubit.dart';
import '../common/config/theme.dart';

class LocationDenied extends StatefulWidget {
  const LocationDenied({Key? key}) : super(key: key);
  static const routeName = '/location-denied';

  @override
  State<LocationDenied> createState() => _LocationDeniedState();
}

class _LocationDeniedState extends State<LocationDenied> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit(),
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
          child: SafeArea(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 156.0),
                child: Center(
                    child: Image.asset(
                        'lib/common/assets/images/GlobeIconLarge.png')),
              ),
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 60.0, right: 26.0, left: 26.0),
                      child: Text(
                        'Sorry, please allow location permission to use the app',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 26.0, left: 26.0),
                    child: CustomButton(
                      label: 'Change location permission',
                      type: ButtonType.inverse,
                      cornerRadius: 32.0,
                      onPressedHandler: () {
                        Navigator.pushNamed(
                            context, LocationPermission.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
