import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/page/email_confirmation.dart';

import '../../page/register.dart';
import '../../page/landing.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case Register.routeName:
        return MaterialPageRoute(builder: (context) => const Register());
      case EmailConfirmation.routeName:
        return MaterialPageRoute(
            builder: (context) => const EmailConfirmation());
      case Landing.routeName:
        return MaterialPageRoute(builder: (context) => const Landing());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(child: Text("Page not found")),
      );
    });
  }
}
