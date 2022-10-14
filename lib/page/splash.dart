import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/logo.dart';

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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: const [
                Logo(width: 160),
                SizedBox(height: 20),
                Logo.text(width: 300)
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
