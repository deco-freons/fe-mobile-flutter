import 'package:flutter/material.dart';

import '../../page/register.dart';
import '../../page/landing.dart';
import '../../page/forget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case Register.routeName:
        return MaterialPageRoute(builder: (context) => const Register());
      case Landing.routeName:
        return MaterialPageRoute(builder: (context) => const Landing());
      case Forget.routeName:
        return MaterialPageRoute(builder: (context) => const Forget());
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
