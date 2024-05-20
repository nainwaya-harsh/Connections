import 'dart:convert';

import 'package:connections/models/userModel.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '', fname: '', lname: '', password: '', mobilenumber: '', email: '',token:'', eventname: [], followers: [], following: []);
  User get user => _user;
  // void setUser(String user) {
  //   _user = User.fromJson(user);
  // }

  void setUser(dynamic user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
