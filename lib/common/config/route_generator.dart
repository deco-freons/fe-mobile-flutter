import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/page/create_event.dart';
import 'package:flutter_boilerplate/page/forget.dart';
import 'package:flutter_boilerplate/page/get_started.dart';
import 'package:flutter_boilerplate/page/landing.dart';
import 'package:flutter_boilerplate/page/login.dart';
import 'package:flutter_boilerplate/page/email_confirmation.dart';
import 'package:flutter_boilerplate/page/edit_profile.dart';
import 'package:flutter_boilerplate/page/homepage.dart';
import 'package:flutter_boilerplate/page/preference.dart';
import 'package:flutter_boilerplate/page/profile.dart';
import 'package:flutter_boilerplate/page/register.dart';
import 'package:flutter_boilerplate/page/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case Dashboard.routeName:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      case Splash.routeName:
        return MaterialPageRoute(builder: (context) => const Splash());
      case Register.routeName:
        return MaterialPageRoute(builder: (context) => const Register());
      case EmailConfirmation.routeName:
        return MaterialPageRoute(
            builder: (context) => const EmailConfirmation());
      case Landing.routeName:
        return MaterialPageRoute(builder: (context) => const Landing());
      case Login.routeName:
        return MaterialPageRoute(builder: (context) => const Login());
      case Forget.routeName:
        return MaterialPageRoute(builder: (context) => const Forget());
      case Profile.routeName:
        return MaterialPageRoute(builder: (context) => const Profile());
      case EditProfile.routeName:
        return MaterialPageRoute(builder: (context) => const EditProfile());
      case Homepage.routeName:
        return MaterialPageRoute(builder: (context) => const Homepage());
      case Preference.routeName:
        return MaterialPageRoute(builder: (context) => const Preference());
      case GetStarted.routeName:
        return MaterialPageRoute(builder: (context) => const GetStarted());
      case CreateEvent.routeName:
        return MaterialPageRoute(builder: (context) => const CreateEvent());
      case SearchLocation.routeName:
        return MaterialPageRoute(builder: (context) => const SearchLocation());
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
