import 'dart:convert';
import 'dart:developer';
import 'package:connections/constants/global_variables.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class GuestService{
  void SendFollowing(BuildContext context,String guest_id) async{
    try {
      final userProvider=Provider.of<UserProvider>(context,listen: false);

      http.Response res=await http.post(Uri.parse('$uri/api/addFollowers'),headers:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8','x-auth-token':userProvider.user.token
          },body: jsonEncode({'user_id':userProvider.user.id,'guest_id':guest_id}));

        httpErrorHandle(response: res, context: context, onSuccess: () async {
          showSnackBar(context,'Added Successfully');

          
         http.Response res2=await http.post(Uri.parse('$uri/api/sendNotification'),headers:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8','x-auth-token':userProvider.user.token
          },body: jsonEncode({'notification':"${userProvider.user.fname} Added to Your Followers",'guest_id':guest_id}));
        });
    } catch (e) {
      showSnackBar(context, e.toString());
          log(e.toString());
    }
  }
}