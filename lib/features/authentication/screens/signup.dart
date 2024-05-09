import 'package:connections/common/widgets/textform.dart';
import 'package:connections/constants/colors.dart';
import 'package:connections/features/authentication/screens/landing_screen.dart';
import 'package:connections/features/authentication/screens/user_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpNumber extends StatefulWidget {
  static const String routeName = '/signup-screen';
  SignUpNumber({super.key});

  final TextEditingController _number = TextEditingController();

  @override
  State<SignUpNumber> createState() => _SignUpNumberState();
}

class _SignUpNumberState extends State<SignUpNumber> {
  TextEditingController _phoneNumber = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumber.dispose();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, LandingScreen.routeName);
              },
              child: Image.asset(
                'assets/icons/back_arrow.png',
                scale: 3.5,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Sign up',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Get Started! 👋',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextFormField(
                controller: _phoneNumber, title: 'Mobile Number'),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    minimumSize: Size(358, 62),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  Navigator.pushNamed(context, UserDetails.routeName,
                      arguments: _phoneNumber.text.toString());
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have an Account?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.49,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Having Issues?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  " Contact Us",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
