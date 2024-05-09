import 'package:connections/common/widgets/bottom_navigation.dart';
import 'package:connections/features/authentication/screens/landing_screen.dart';
import 'package:connections/features/authentication/services/auth_service.dart';
import 'package:connections/features/home/screens/home_screen.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // AuthService _auth = AuthService();
  void initState() {
    super.initState();
    // _auth.getUserData(context);
    // Simulate some initialization or loading process
    Future.delayed(Duration(seconds: 2), () {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user != null && userProvider.user.token.isNotEmpty) {
        Navigator.pushNamedAndRemoveUntil(
            context, BottomNavigation.routeName, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, LandingScreen.routeName, (route) => false);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logos/logo.png',
          height: 260,
        ),
      ),
    );
  }
}
