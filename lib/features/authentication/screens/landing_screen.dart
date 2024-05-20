import 'package:connections/common/widgets/common_button.dart';
import 'package:connections/features/authentication/screens/login.dart';
import 'package:connections/features/authentication/screens/signup.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = '/landing-screen';
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
              child: Image.asset(
                'assets/images/onboardImg.png',
                height: 300,
              ),
                        ),
                      const  Text(
              'Missed Connection?',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800),
                        ),
                      const  Text(
              'Not Anymore.',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800),
                        ),
                      const  SizedBox(
              height: 25,
                        ),
                      const  Text(
              "It's easy to find those awesome people you met!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      const  SizedBox(
              height: 25,
                        ),
                        customButton(
              title: 'SignUp',
              ontap: () {
                Navigator.pushNamed(context, SignUpNumber.routeName);
              },
              color: Color(0xfffBD57EA),
              fontcolor: Colors.white,
                        ),
                      const  SizedBox(
              height: 15,
                        ),
                        customButton(
              title: 'Login',
              ontap: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              fontcolor: Colors.black,
                        )
                      ],
                    ),
                  ),
            )));
  }
}

