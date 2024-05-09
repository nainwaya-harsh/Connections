import 'package:connections/common/widgets/bottom_navigation.dart';
import 'package:connections/features/authentication/screens/landing_screen.dart';
import 'package:connections/features/authentication/screens/login.dart';
import 'package:connections/features/authentication/screens/signup.dart';
import 'package:connections/features/authentication/screens/user_details.dart';
import 'package:connections/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Error 404 Page Not Found'),
                ),
              ));
  }
}
