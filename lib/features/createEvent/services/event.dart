import 'dart:convert';
import 'dart:developer';

import 'package:connections/common/widgets/bottom_navigation.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/features/notification/services/notification_service.dart';
import 'package:connections/models/eventModel.dart';
import 'package:connections/models/userModel.dart';
import 'package:connections/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../provider/user_provider.dart';
import 'package:http/http.dart' as http;

class EventService {
  void createEvent(BuildContext context, String ename, String edate,
      String etime, String ecity, String eaddress, enumber) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      EventModel event = EventModel(
          id: '',
          ename: ename,
          edate: edate,
          etime: etime,
          ecity: ecity,
          eaddress: eaddress,
          enumber: enumber,
          eguests: []);

      http.Response response = await http.post(Uri.parse('$uri/api/event'),
          body: event.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            final eventid = jsonDecode(response.body)['_id'];
            log(eventid);
            try {
              http.Response response2 = await http.post(
              Uri.parse('$uri/api/user/eventCreated'),
              body: jsonEncode(
                  {'event_id': eventid, 'user_id': userProvider.user.id}),
              
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
            );
            httpErrorHandle(response: response2, context: context, onSuccess: (){
              NotificationService _notification=NotificationService();
              _notification.sendNotificationEventCreated(context, ename);
              
              
            });
            } catch (e) {
              log(e.toString());
            }
            
            showSnackBar(context, 'Event Created Successfully');
            Navigator.popAndPushNamed(context, BottomNavigation.routeName);
          });
    } catch (e) {
      print('The error is $e');
      showSnackBar(context, e.toString());
    }
  }

  Future<List<EventModel>> getEvents(BuildContext context) async {
    List<EventModel> events = [];

    try {
      final response = await http.get(Uri.parse('$uri/api/getEvents'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      log(response.body);
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            final decodedData = jsonDecode(response.body);

            // Check if decodedData is a list
            if (decodedData is List) {
              for (final eventData in decodedData) {
                final event = EventModel.fromJson(eventData);
                events.add(event);
                // Print event name in console
                print('Event name: ${event.ename}');
              }
            } else {
              // Handle if decodedData is not a list (e.g., single object)
              final event = EventModel.fromJson(decodedData);
              events.add(event);
              // Print event name in console
              print('Event name: ${event.ename}');
            }
          });
    } catch (e) {
      // Handle errors properly
      showSnackBar(context, e.toString());
      log(e.toString());
    }
    Provider.of<EventProvider>(context, listen: false).setEvents(events);
    return events;
  }

  void addUserEvent(
      {required BuildContext context, required EventModel eventModel}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // log(userProvider.user.following.first);
    // log(eventModel.id);
    // log(userProvider.user.id);
    print("func check");
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/addUserToEvent'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode(
              {'event_id': eventModel.id, 'user_id': userProvider.user.id}));

      http.Response userEvent = await http.post(
          Uri.parse('$uri/api/adduserevent'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode(
              {'user_id': userProvider.user.id, 'event_id': eventModel.id}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Event User added Successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      log(e.toString());
    }
  }

  void removeUserFromEvent(
      {required BuildContext context, required EventModel eventModel}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    log(eventModel.id);
    log(userProvider.user.id);
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/api/removeUserFromEvent'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode(
              {'event_id': eventModel.id, 'user_id': userProvider.user.id}));

      http.Response res2 = await http.post(
          Uri.parse('$uri/api/removeuserevent'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode(
              {'user_id': userProvider.user.id, 'event_id': eventModel.id}));
      print(userProvider.user.id);
      print(eventModel.id);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'User Removed Successfully');
          });



       httpErrorHandle(
          response: res2,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'User Event Removed Successfully');
          });



    } catch (e) {
      showSnackBar(context, e.toString());
      log(e.toString());
    }
  }

    List<User> eventGuests=[];
  Future<void> eventAllGuest(String event_id,List<String>eventGuestIds,BuildContext context) async{
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res=await http.post(Uri.parse('$uri/api/event/eventallguest'),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
      },body: jsonEncode({'eventguest':eventGuestIds,}));

      if(res.statusCode==200){
        List<dynamic> responseBody=jsonDecode(res.body);
        eventGuests=responseBody.map((user)=>User.fromJson(user)).toList();
      }
    } catch (e) {
      print("The error is ${e.toString()}");
      showSnackBar(context, e.toString());
      
    }
    
  }
}
