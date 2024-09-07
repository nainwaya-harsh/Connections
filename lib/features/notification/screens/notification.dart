import 'package:connections/constants/colors.dart';
import 'package:connections/features/notification/services/notification_service.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
 static const String routeName='/notification-screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<String>notification=['Started Following you','You Created an Event'];
  NotificationService _notificationService=NotificationService();
  
  @override
  Widget build(BuildContext context) {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Your Notifications'),actions: [IconButton(onPressed: (){
        _notificationService.clearNotification(context);
        userProvider.user.notification.clear();
        setState(() {
          
        });
      }, icon: Icon(Icons.clear_all_sharp,size: 40,))],),

      body: ListView.builder(reverse: true,shrinkWrap: true,itemCount: userProvider.user.notification.length,itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Container(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
                              userProvider.user.notification[index],
                              style: GoogleFonts.nunito(
                                  fontSize: 17),
                            ),
          ),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: cardColor,border: Border.all(color: cardColor,width: 1)),),
        );
      }),
    );
  }
}