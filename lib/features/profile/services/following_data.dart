import 'dart:convert';
import 'dart:developer';

import 'package:connections/constants/global_variables.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/models/userModel.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class FollowingData{
 List<User> followingUsers = [];

  Future<void> getFollowingData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final response = await http.post(
        Uri.parse('$uri/api/getFollowingDetails'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({'followingIds': userProvider.user.following}),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseBody = jsonDecode(response.body);
        followingUsers = responseBody.map((user) => User.fromJson(user)).toList();

        // Log the details of the following users
        followingUsers.forEach((user) {
          log('Following: ${user.fname} ${user.lname}, Email: ${user.email} , id:${user.id}');
          
        });

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