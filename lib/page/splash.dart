import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Center(
            child: Hero(
                tag: "Logo",
                child: Image.asset(
                    'lib/common/assets/images/GlobeIconMedium.png'))),
      ),
    );
  }
}
