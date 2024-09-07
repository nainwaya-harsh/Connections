import 'dart:convert';
import 'dart:developer';

import 'package:connections/constants/global_variables.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/models/userModel.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class FollowersData{
 List<User> followersUsers = [];

  Future<void> getFollowersData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      print('Working 1');
      final response = await http.post(
        Uri.parse('$uri/api/getFollowersDetails'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({'followersIds': userProvider.user.followers}),
      );
      print('Working 2');
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> responseBody = jsonDecode(response.body);
        followersUsers = responseBody.map((user) => User.fromJson(user)).toList();

        // Log the details of the following users
       followersUsers.forEach((user) {
          log('Following: ${user.fname} ${user.lname}, Email: ${user.email} , id:${user.id}');
          
        });
        print('Working 3');

        // You can now use the followingUsers list in your UI
      } else {
        showSnackBar(context, 'Failed to load following data');
      }
    } catch (e) {
      print("The error is ${e.toString()}");
      showSnackBar(context, e.toString());
    }
  }
}