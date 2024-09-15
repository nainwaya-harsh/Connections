import 'package:connections/features/GuestAccount/services/following.dart';
import 'package:connections/features/GuestAccount/widgets/follower_stats.dart';
import 'package:connections/features/GuestAccount/widgets/friends_checkins.dart';
import 'package:connections/features/GuestAccount/widgets/shared_moments.dart';
import 'package:connections/features/profile/services/eventData.dart';
import 'package:connections/models/eventModel.dart';
import 'package:connections/models/userModel.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';
import '../../../provider/user_provider.dart';

class GuestProfile extends StatefulWidget {
  static const routeName='/guest-profile';
  final User guest;
  const GuestProfile({super.key,required this.guest});

  @override
  State<GuestProfile> createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {
  EventData _eventData=EventData();
  String selectedItem = 'Connect';
  List<String> selectedItems = ['Connect', 'Shared Moments'];
  bool isLocked=true;
  List<EventModel> sharedEvent=[];
  List<String> sharedEventIds=[];
 List<User> mutuals=[];
  GuestService _guestService=GuestService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkisFollowing();
    sharedEventFunc();
    getEventDetails(context,sharedEventIds);
  }

  void getEventDetails(BuildContext context,List<String> eventsIds) async{
    List<EventModel> l=await _eventData.eventsList(context, eventsIds);
    setState(() {
      sharedEvent=l;
    });
  }

    void sharedEventFunc(){
      final userProvider=Provider.of<UserProvider>(context,listen: false);
      List<String> guestEventList=widget.guest.eventattended;
      List<String> userEventList=userProvider.user.eventattended;
      for(int i=0;i<guestEventList.length;i++){
        String guestEvent=guestEventList[i];
        for(int j=0;j<userEventList.length;j++){
          if(guestEvent==userEventList[j]){
            sharedEventIds!.add(guestEvent);
          }
        }
      }
      return;
      
    }
   void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget connectTile(String text,String url,String iconUrl){
    return Visibility(
      visible: url==''?false:true,
      child: Padding(
          padding: const EdgeInsets.only(top: 5,left: 5,right: 5),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                // child: Icon(Icons.person, color: Colors.white),
                child: Image.asset(iconUrl),
              ),
              title: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                url,
                style: TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.open_in_new, color: Colors.blue),
                onPressed: () => _launchURL(url),
              ),
            ),
          ),
        ),
    );
  }

  void checkisFollowing(){
    final userProvider=Provider.of<UserProvider>(context,listen: false);
      for(int i=0;i<userProvider.user.following.length;i++){
        if(userProvider.user.following[i]==widget.guest.id){
          isLocked=false;
          break;
        }
      }
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/icons/back_arrow.png',
            scale: 4.5,
          ),
        ),
        actions: [
          Image.asset(
            'assets/icons/threeDots.png',
            width: 27,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: h * 0.33,
                      decoration: BoxDecoration(
                          color: Color(0xfffE3B6F6),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24))),
                    ),
                    Container(
                      height: h * 0.25,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Image.asset(
                                //   'assets/icons/back_arrow.png',
                                //   width: 40,
                                // ),
                                // Image.asset(
                                //   'assets/icons/threeDots.png',
                                //   width: 27,
                                // )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          // Image.asset('assets/images/person1.png'),
                          if(widget.guest.profile!='') CircleAvatar(radius: 40,backgroundImage: NetworkImage(widget.guest.profile)) else Image.asset('assets/images/person1.png') ,
                          Text(
                            widget.guest.fname,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          Text(
                           widget.guest.lname,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                           widget.guest.description,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          // if (isLocked)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        isLocked ? buttonColor : Colors.white,
                                    minimumSize: Size(123, 34),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: buttonColor),
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () {
                                  _guestService.SendFollowing(context, widget.guest.id);
                                 isLocked = false;
                      setState(() {});
                                },
                                child: Text(
                                  isLocked == true
                                      ? 'Send Request'
                                      : 'Unfollow',
                                  style: TextStyle(
                                      color:
                                          isLocked ? Colors.white : buttonColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: w * 0.12,
                          ),
                          FollowerStats(data: widget.guest.followers.length, title: 'Followers'),
                          SizedBox(
                            width: w * 0.12,
                          ),
                          FollowerStats(data: widget.guest.followers.length, title: 'Following'),
                          SizedBox(
                            width: w * 0.12,
                          ),
                          FollowerStats(data: (widget.guest.eventattended.length+widget.guest.eventcreated.length), title: 'Events'),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: selectedItems.map((category) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          selectedItem = category;
                          setState(() {});
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 160.0,
                              height: 46.0,
                              decoration: BoxDecoration(
                                color: selectedItem == category
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              width: 180.0,
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  category,
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (isLocked)
                  InkWell(
                    onTap: () {
                      print(isLocked);
                      print('tapped');
                    },
                    child: Container(
                      child: Image.asset(
                        'assets/icons/profile_locked.png',
                        height: 140,
                      ),
                    ),
                  ),

                if (selectedItem == 'Connect' && !isLocked)
                  Container(
                    child: Column(
                      children: [
                       connectTile('Linkedn', widget.guest.linkedin,'assets/icons/linkedin.png'),
                       connectTile('Whatsapp', widget.guest.whatsapp,'assets/icons/whatsapp.png'),
                       connectTile('Others', widget.guest.contact,'assets/icons/chat.png'),
                      ],
                    ),
                  ),

                if (selectedItem == 'Shared Moments' && !isLocked)
                  sharedEvent==null?CircularProgressIndicator():ListView.builder(shrinkWrap: true,itemCount: sharedEvent!.length,itemBuilder: (context,index){
                      return SharedMoments(guestName: widget.guest.fname, eventlocation: sharedEvent[index].ecity,);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}