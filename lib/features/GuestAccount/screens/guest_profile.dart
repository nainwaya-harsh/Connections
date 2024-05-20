import 'package:connections/features/GuestAccount/widgets/follower_stats.dart';
import 'package:connections/features/GuestAccount/widgets/friends_checkins.dart';
import 'package:connections/features/GuestAccount/widgets/shared_moments.dart';
import 'package:connections/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  String selectedItem = 'Posts';
  List<String> selectedItems = ['Posts', 'Shared Moments'];
  bool isLocked=true;
 List<User> mutuals=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                          Image.asset('assets/images/person1.png'),
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
                          if (isLocked)
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
                                onPressed: () {},
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
                          FollowerStats(data: mutuals.length, title: 'Mutuals'),
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
                                // border: Border.all(
                                //   color: selectedItem == category
                                //       ? Colors.black
                                //       : Colors.white,
                                //   width: 3.0,
                                // ),
                                // border: Border(
                                //     bottom: BorderSide(color: Colors.black, width: 10))
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
                // Obx(() {
                //   if(isLocked){
                //     return
                //   }
                // }),
                if (selectedItem == 'Posts' && isLocked)
                  InkWell(
                    onTap: () {
                      print(isLocked);
                      print('tapped');
                      isLocked = false;
                      setState(() {});
                    },
                    child: Container(
                      child: Image.asset(
                        'assets/icons/profile_locked.png',
                        height: 140,
                      ),
                    ),
                  ),

                if (selectedItem == 'Posts' && !isLocked)
                  Column(
                    children: [
                      FriendsCheckins(),
                      FriendsCheckins(),
                    ],
                  ),

                if (selectedItem == 'Shared Moments' && !isLocked)
                  Column(
                    children: [
                      SharedMoments(),
                      SharedMoments(),
                      SharedMoments(),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}