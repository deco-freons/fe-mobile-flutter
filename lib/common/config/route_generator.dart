import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';
import 'package:flutter_boilerplate/event/data/place_model.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/page/create_event.dart';
import 'package:flutter_boilerplate/page/edit_event.dart';
import 'package:flutter_boilerplate/page/event_detail.dart';
import 'package:flutter_boilerplate/page/forget.dart';
import 'package:flutter_boilerplate/page/get_started.dart';
import 'package:flutter_boilerplate/page/landing.dart';
import 'package:flutter_boilerplate/page/location_denied.dart';
import 'package:flutter_boilerplate/page/location_permission.dart';
import 'package:flutter_boilerplate/page/login.dart';
import 'package:flutter_boilerplate/page/email_confirmation.dart';
import 'package:flutter_boilerplate/page/edit_profile.dart';
import 'package:flutter_boilerplate/page/homepage.dart';
import 'package:flutter_boilerplate/page/search_events.dart';
import 'package:flutter_boilerplate/page/preference.dart';
import 'package:flutter_boilerplate/page/profile.dart';
import 'package:flutter_boilerplate/page/register.dart';
import 'package:flutter_boilerplate/page/search_location.dart';
import 'package:flutter_boilerplate/page/show_location.dart';
import 'package:flutter_boilerplate/page/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
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
      case EditEvent.routeName:
        EventDetailResponseModel eventDetail = args as EventDetailResponseModel;
        return MaterialPageRoute(
            builder: (context) => EditEvent(eventDetail: eventDetail));
      case SearchLocation.routeName:
        return MaterialPageRoute(builder: (context) => const SearchLocation());
      case EventDetail.routeName:
        int eventID = args as int;
        return MaterialPageRoute(
            builder: (context) => EventDetail(eventID: eventID));
      case ShowLocation.routeName:
        PlaceModel placeModel = args as PlaceModel;
        return MaterialPageRoute(
            builder: (context) => ShowLocation(
                  lat: placeModel.lat,
                  long: placeModel.lng,
                  address: placeModel.name,
                ));
      case SearchEvents.routeName:
        return MaterialPageRoute(builder: (context) => const SearchEvents());
      case LocationPermission.routeName:
        return MaterialPageRoute(
            builder: (context) => const LocationPermission());
      case LocationDenied.routeName:
        return MaterialPageRoute(builder: (context) => const LocationDenied());
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
