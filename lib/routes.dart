import 'package:connections/common/widgets/bottom_navigation.dart';
import 'package:connections/features/GuestAccount/screens/guest_profile.dart';
import 'package:connections/features/authentication/screens/landing_screen.dart';
import 'package:connections/features/authentication/screens/login.dart';
import 'package:connections/features/authentication/screens/signup.dart';
import 'package:connections/features/authentication/screens/user_details.dart';
import 'package:connections/features/createEvent/screens/attend_event.dart';
import 'package:connections/features/home/screens/home_screen.dart';
import 'package:connections/features/notification/screens/notification.dart';
import 'package:connections/features/profile/screens/followers.dart';
import 'package:connections/features/profile/screens/following.dart';
import 'package:connections/features/search/screens/search_screen.dart';
import 'package:connections/models/eventModel.dart';
import 'package:flutter/material.dart';

import 'models/userModel.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LandingScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LandingScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case SignUpNumber.routeName:
      return MaterialPageRoute(builder: (_) =>SignUpNumber());
    case UserDetails.routeName:
      var number = routeSettings.arguments as String;
      return MaterialPageRoute(builder: (_) =>  UserDetails(mobileNumber: number));
    case BottomNavigation.routeName:
      return MaterialPageRoute(builder: (_) => const BottomNavigation());
    case EventAttendees.routeName:
      var event=routeSettings.arguments as EventModel;
      return MaterialPageRoute(builder: (_) =>  EventAttendees(event: event,));
    case GuestProfile.routeName:
    var guest=routeSettings.arguments as User;
      return MaterialPageRoute(builder: (_) =>  GuestProfile(guest: guest,));
    case Followers.routeName:
      return MaterialPageRoute(builder: (_) =>  Followers());
    case Following.routeName:
      return MaterialPageRoute(builder: (_) =>  Following());
    case SearchScreen.routeName:
      return MaterialPageRoute(builder: (_) =>  SearchScreen());
    case NotificationScreen.routeName:
      return MaterialPageRoute(builder: (_) =>  NotificationScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Error 404 Page Not Found'),
                ),
              ));
  }
}
