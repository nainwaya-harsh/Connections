import 'dart:convert';

import 'package:connections/constants/global_variables.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NotificationService{
  
  void sendNotificationFollowing(BuildContext context,String guest_id) async{
    final userProvider=Provider.of<UserProvider>(context,listen:false);
    List<String> notificaion=[];
    try {
       http.Response res2=await http.post(Uri.parse('$uri/api/sendNotification'),headers:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8','x-auth-token':userProvider.user.token
          },body: jsonEncode({'notification':"${userProvider.user.fname} Added to Your Followers",'guest_id':guest_id}));
    } catch (e) {
      showSnackBar(context, 'Failed To load');
    }
  }

  void sendNotificationEventCreated(BuildContext context, String eventName) async{
    final userProvider=Provider.of<UserProvider>(context,listen:false);
    List<String> notificaion=[];
    try {
       http.Response res2=await http.post(Uri.parse('$uri/api/sendNotification'),headers:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8','x-auth-token':userProvider.user.token
          },body: jsonEncode({'notification':"Congrats🍾!! You Created an Event named ${eventName}",'guest_id':userProvider.user.id}));

          httpErrorHandle(response: res2, context: context, onSuccess: (){
              userProvider.user.notification.add("Congrats🍾!! You Created an Event named ${eventName}");
          });
    } catch (e) {
      showSnackBar(context, 'Failed To load');
    }
    
  }

  void clearNotification(BuildContext context) async{
    final userProvider=Provider.of<UserProvider>(context,listen:false);
    try {
      http.Response res=await http.post(Uri.parse('$uri/api/clearNotification'),headers:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8','x-auth-token':userProvider.user.token
          },body: jsonEncode({'user_id':userProvider.user.id}));

          httpErrorHandle(response: res, context: context, onSuccess: (){
          });
    } catch (e) {
      showSnackBar(context, 'Failed To Clear Notification');
    }
  }


}