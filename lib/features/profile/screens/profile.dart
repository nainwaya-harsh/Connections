import 'dart:io';
import 'dart:developer';
import 'package:connections/constants/colors.dart';
import 'package:connections/features/authentication/services/auth_service.dart';
import 'package:connections/features/home/widgets/friends_checkins.dart';
import 'package:connections/features/profile/screens/followers.dart';
import 'package:connections/features/profile/screens/following.dart';
import 'package:connections/features/profile/services/eventData.dart';
import 'package:connections/features/profile/services/profile_data.dart';
import 'package:connections/features/profile/widgets/bottomSheet.dart';
import 'package:connections/features/profile/widgets/follower_stats.dart';
import 'package:connections/features/profile/widgets/shared_moments.dart';
import 'package:connections/models/eventModel.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  EventData _eventData=EventData();
  bool isLocked = false;
  String selectedItem = 'Events Attended';
  List<String> selectedItems = ['Events Attended', 'Events Created'];
  List<EventModel>? eventAttended=[];
  List<EventModel>? eventCreated;
  File? profilePhoto;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getEventAttendedList();
  }

  void _getEventAttendedList() async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    // List<EventModel> l=await _eventData.eventsList(context, userProvider.user.eventattended);
    eventAttended= await _eventData.eventsList(context, userProvider.user.eventattended);
    eventCreated= await _eventData.eventsList(context, userProvider.user.eventcreated);
    setState(() {
      
    });
    
  } 


  void _modalBottomSheetMenu(){
    
        showModalBottomSheet(
          isScrollControlled: true,
          showDragHandle: true,
            context: context,
            builder: (builder){
              return CustomBottomSheet();
            }
        );
      }

      void selectImages() async {
        ProfileData profileData=ProfileData();
    var res = await pickImages();
    setState(() {
      profilePhoto = res;
    });
    profileData.saveProfile(profilePhoto!, context);
  }

  Future<File> pickImages() async {
  late File images;
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (files != null && files.files != null) {
      images=File(files.files[0].path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
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
        leading: Image.asset(
          'assets/icons/back_arrow.png',
          scale: 4.5,
        ),
        actions: [
          // Image.asset(
          //   'assets/icons/threeDots.png',
          //   width: 27,
          // ),
          PopupMenuButton(itemBuilder: (context)=>[PopupMenuItem(child: Text("Update Profile"),onTap: (){_modalBottomSheetMenu();},),PopupMenuItem(child: Text("LogOut"),onTap: (){
            AuthService _authService=AuthService();
            _authService.logOut(context);
          },),]),
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
                          Stack(
                            children: [
                              Container(width: 90,height: 90,),
                            if(user.profile!='') CircleAvatar(radius: 40,backgroundImage: NetworkImage(user.profile)) else if (profilePhoto==null) Image.asset('assets/images/person1.png') else CircleAvatar(radius: 40,backgroundImage: FileImage(profilePhoto!)),
                              Positioned(right:0,bottom:0,child: IconButton(onPressed: (){
                                selectImages();
                              }, icon: Icon(Icons.add_circle,color: buttonColor,)))
                            ],
                          ),
                          Text(
                            user.fname,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          Text(
                            user.lname,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          // if (isLocked)
                          //   ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //           elevation: 0,
                          //           backgroundColor:
                          //               isLocked ? buttonColor : Colors.white,
                          //           minimumSize: Size(123, 34),
                          //           shape: RoundedRectangleBorder(
                          //               side: BorderSide(color: buttonColor),
                          //               borderRadius:
                          //                   BorderRadius.circular(8))),
                          //       onPressed: () {},
                          //       child: Text(
                          //         isLocked == true
                          //             ? 'Send Request'
                          //             : 'Unfollow',
                          //         style: TextStyle(
                          //             color:
                          //                 isLocked ? Colors.white : buttonColor,
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w600),
                          //       )),
                          SizedBox(height: 13,),
                          Text(user.description,style: GoogleFonts.aBeeZee(fontSize: 17),textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        children: [
                          SizedBox(
                            width: w * 0.12,
                          ),
                          InkWell(onTap: (){
                            Navigator.pushNamed(context, Followers.routeName);
                          },child: FollowerStats(data: user.followers.length, title: 'Followers')),
                          SizedBox(
                            width: w * 0.12,
                          ),
                          InkWell(onTap: (){
                            Navigator.pushNamed(context, Following.routeName);
                          },child: FollowerStats(data: user.following.length, title: 'Following')),
                          SizedBox(
                            width: w * 0.12,
                          ),
                          FollowerStats(data: (user.eventattended.length+user.eventcreated.length), title: 'Total Events'),
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
                if (selectedItem == 'Events Attended')
                    eventAttended==null?CircularProgressIndicator():ListView.builder(itemCount: eventAttended!.length,shrinkWrap: true,itemBuilder: (context,index){
                      return SharedMoments(event: eventAttended![index],isCreated: false,);
                    }),

                if (selectedItem == 'Events Created')
                  eventCreated==null?CircularProgressIndicator():ListView.builder(shrinkWrap: true,itemCount: eventCreated!.length,itemBuilder: (context,index){
                      return SharedMoments(event: eventCreated![index],isCreated: true,);
                    }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
