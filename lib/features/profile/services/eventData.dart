import 'dart:convert';

import 'package:connections/constants/global_variables.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/models/eventModel.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EventData{

  Future<List<EventModel>> eventsList(BuildContext context,List<String> eventsIds) async{
    List<EventModel>eventList=[];
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try {
        http.Response res=await http.post(Uri.parse('$uri/api/event/eventList'),headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({'eventIds':eventsIds}) );

        httpErrorHandle(response: res, context: context, onSuccess: (){
          List<dynamic> responseBody=jsonDecode(res.body);

          eventList=responseBody.map((event)=>EventModel.fromJson(event)).toList();
        });
        
    } catch (e) {
      showSnackBar(context, 'Fetching eventAttended Failed');
    }
    return eventList;
  }
}