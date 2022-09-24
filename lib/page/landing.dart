import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/page/auth/register.dart';
import 'package:flutter_boilerplate/page/auth/login.dart';

import '../common/components/buttons/custom_button.dart';
import '../common/components/buttons/custom_text_button.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);
  static const routeName = '/landing';

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
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
        child: SafeArea(child: buildLanding()),
      ),
    );
  }

  Widget buildLanding() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 72.0),
          child: Hero(
            tag: "Logo",
            child: Center(
                child: Image.asset(
                    'lib/common/assets/images/GlobeIconMedium.png')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: CustomPadding.body, right: CustomPadding.body, top: 55),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: CustomPadding.base, right: CustomPadding.base),
                child: Text(
                  'Create, Find, and Join event around you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: CustomFontSize.xxl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: CustomPadding.xl,
                  left: CustomPadding.base,
                  right: CustomPadding.base,
                ),
                child: Text(
                  'Lorem ipsum dolor sit amet. Qui voluptatibus officiis et quibusdam',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 56.0),
                child: CustomButton(
                  label: 'Create Account',
                  type: ButtonType.inverse,
                  cornerRadius: CustomRadius.button,
                  onPressedHandler: () {
                    Navigator.pushNamed(context, Register.routeName);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: CustomPadding.xxl),
                child: CustomTextButton(
                  text: 'Sign in',
                  type: TextButtonType.secondary,
                  fontSize: CustomFontSize.lg,
                  textWeight: FontWeight.normal,
                  onPressedHandler: () {
                    Navigator.pushNamed(context, Login.routeName);
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
