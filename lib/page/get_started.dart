import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/page/preference.dart';

import '../common/components/buttons/custom_button.dart';
import '../common/config/theme.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);
  static const routeName = '/get-started';

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(child: buildGetStarted()),
      ),
    );
  }

  Widget buildGetStarted() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 156.0),
          child: Center(
              child:
                  Image.asset('lib/common/assets/images/GlobeIconLarge.png')),
        ),
        Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 60.0, right: 26.0, left: 26.0),
              child: CustomButton(
                label: 'Get started',
                type: ButtonType.inverse,
                cornerRadius: CustomRadius.button,
                onPressedHandler: () {
                  Navigator.pushNamed(context, Preference.routeName);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
