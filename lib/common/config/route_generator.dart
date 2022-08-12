import 'package:flutter/material.dart';

import '../../page/page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Pages.routeName:
        return MaterialPageRoute(builder: (context) => Pages());
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
