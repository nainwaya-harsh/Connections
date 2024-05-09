import 'package:connections/common/widgets/bottom_navigation.dart';
import 'package:connections/common/widgets/textform.dart';
import 'package:connections/constants/colors.dart';
import 'package:connections/features/authentication/screens/landing_screen.dart';
import 'package:connections/features/authentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthService _authService = AuthService();
  final _form = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signIn() {
    _authService.signinUser(
        context, _emailController.text, _passwordController.text);
  }

  @override
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
              'Login',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Welcome Back! 👋',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextFormField(controller: _emailController, title: 'Email'),
            SizedBox(
              height: 30,
            ),
            CustomTextFormField(
                controller: _passwordController, title: 'Password'),
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
                  signIn();
                },
                child: Text(
                  'Login',
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
                  "Don't Have an account?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Sign Up",
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
