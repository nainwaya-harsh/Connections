import 'dart:convert';
import 'dart:developer';

import 'package:connections/common/widgets/bottom_navigation.dart';
import 'package:connections/constants/global_variables.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/features/authentication/screens/landing_screen.dart';
import 'package:connections/models/userModel.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signupUser(BuildContext context, String fname, String lname,
      String email, String mobilenumber, String password) async {
    try {
      print('innnn');
      User user = User(
          id: '',
          fname: fname,
          lname: lname,
          password: password,
          mobilenumber: mobilenumber,
          email: email,
          token: '', eventname: [], followers: [], following: []);
      print('15454');
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account Created Successfully, Kindly Login');
            Navigator.popAndPushNamed(context, LandingScreen.routeName);
          });
      log(res.body);
    } catch (e) {
      print('The error is $e');
      showSnackBar(context, e.toString());
    }
  }

  void signinUser(BuildContext context, String email, String password) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(json.decode(res.body));
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            showSnackBar(context, 'Succesfully Logged In');
            Navigator.pushNamedAndRemoveUntil(
                context, BottomNavigation.routeName, (route) => false);
          });
    } catch (e) {
      print('The error is $e');
      showSnackBar(context, e.toString());
      log(e.toString());
    }
  }

  // void getUserData(BuildContext context) async {
  //   try {
  //     SharedPreferences _prefs = await SharedPreferences.getInstance();
  //     String? token = _prefs.getString('x-auth-token');
  //     if (token == null) {
  //       _prefs.setString('x-auth-token', '');
  //     }

  //     var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': token!
  //         });
  //     var response = jsonDecode(tokenRes.body);
  //     if (response == true) {
  //       http.Response userRes = await http.get(Uri.parse('$uri/'),
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //             'x-auth-token': token
  //           });
  //       var userProvider = Provider.of<UserProvider>(context, listen: false);
  //       userProvider.setUser(userRes.body);
  //     }
  //   } catch (e) {
  //     print('The error is $e');
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        // getUserData
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(json.decode(userRes.body));
        log(userProvider.user.fname);
        log(userProvider.user.token);
      }
    } catch (e) {
      print('The error is $e');
      showSnackBar(context, e.toString());
      log(e.toString());
    }
  }
}
