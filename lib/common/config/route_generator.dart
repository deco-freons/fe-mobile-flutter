import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/utils/typedef.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_response_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_place_model.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/page/event/create_event.dart';
import 'package:flutter_boilerplate/page/event/edit_event.dart';
import 'package:flutter_boilerplate/page/event/event_detail.dart';
import 'package:flutter_boilerplate/page/event/event_matching.dart';
import 'package:flutter_boilerplate/page/event/event_participants.dart';
import 'package:flutter_boilerplate/page/auth/forget_password.dart';
import 'package:flutter_boilerplate/page/event/event_reminder.dart';
import 'package:flutter_boilerplate/page/user/friend_profile.dart';
import 'package:flutter_boilerplate/page/get_started.dart';
import 'package:flutter_boilerplate/page/landing.dart';
import 'package:flutter_boilerplate/page/location_denied.dart';
import 'package:flutter_boilerplate/page/location_permission.dart';
import 'package:flutter_boilerplate/page/auth/login.dart';
import 'package:flutter_boilerplate/page/auth/email_confirmation.dart';
import 'package:flutter_boilerplate/page/user/edit_profile.dart';
import 'package:flutter_boilerplate/page/homepage.dart';
import 'package:flutter_boilerplate/page/search/search_events.dart';
import 'package:flutter_boilerplate/page/user/preference.dart';
import 'package:flutter_boilerplate/page/user/profile.dart';
import 'package:flutter_boilerplate/page/auth/register.dart';
import 'package:flutter_boilerplate/page/search/search_location.dart';
import 'package:flutter_boilerplate/page/show_location.dart';
import 'package:flutter_boilerplate/page/splash.dart';
import 'package:flutter_boilerplate/page/walkthrough/dummy_event_matching.dart';
import 'package:flutter_boilerplate/page/walkthrough/dummy_homepage.dart';

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
      case ForgetPassword.routeName:
        return MaterialPageRoute(builder: (context) => const ForgetPassword());
      case Profile.routeName:
        return MaterialPageRoute(builder: (context) => const Profile());
      case EditProfile.routeName:
        return MaterialPageRoute(builder: (context) => const EditProfile());
      case Homepage.routeName:
        HandlePageCallBack handlePageCallBack = args as HandlePageCallBack;
        return MaterialPageRoute(
            builder: (context) =>
                Homepage(handlePageChanged: handlePageCallBack));
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
        String initialGoogleMapSuburb = args as String;
        return MaterialPageRoute(
            builder: (context) =>
                SearchLocation(initialSuburb: initialGoogleMapSuburb));
      case EventDetail.routeName:
        int eventID = args as int;
        return MaterialPageRoute(
            builder: (context) => EventDetail(eventID: eventID));
      case ShowLocation.routeName:
        EventPlaceModel placeModel = args as EventPlaceModel;
        return MaterialPageRoute(
            builder: (context) => ShowLocation(
                  lat: placeModel.lat,
                  long: placeModel.lng,
                  address: placeModel.name,
                ));
      case SearchEvents.routeName:
        return MaterialPageRoute(builder: (context) => const SearchEvents());
      case LocationPermission.routeName:
        bool isFirstLogin = args as bool;
        return MaterialPageRoute(
            builder: (context) =>
                LocationPermission(isFirstLogin: isFirstLogin));
      case LocationDenied.routeName:
        return MaterialPageRoute(builder: (context) => const LocationDenied());
      case EventParticipants.routeName:
        List<EventParticipantModel> participants =
            args as List<EventParticipantModel>;
        return MaterialPageRoute(
            builder: (context) =>
                EventParticipants(participants: participants));
      case FriendProfile.routeName:
        int userID = args as int;
        return MaterialPageRoute(
            builder: (context) => FriendProfile(
                  userID: userID,
                ));
      case EventMatching.routeName:
        return MaterialPageRoute(builder: (context) => const EventMatching());
      case DummyHomepage.routeName:
        return MaterialPageRoute(builder: (context) => const DummyHomepage());
      case DummyEventMatching.routeName:
        return MaterialPageRoute(
            builder: (context) => const DummyEventMatching());
      case EventReminder.routeName:
        return MaterialPageRoute(builder: (context) => const EventReminder());
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
