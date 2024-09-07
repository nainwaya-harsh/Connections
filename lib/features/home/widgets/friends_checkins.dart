import 'dart:developer';

import 'package:connections/constants/colors.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/features/createEvent/screens/attend_event.dart';
import 'package:connections/models/eventModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsCheckins extends StatefulWidget {
  final String name;
  final String place;
  final String attendees;
  final EventModel eventModel;
   const FriendsCheckins({super.key,required this.name,  required this.place, required this.attendees,required this.eventModel});
  

  @override
  State<FriendsCheckins> createState() => _FriendsCheckinsState();
}

class _FriendsCheckinsState extends State<FriendsCheckins> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
     return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              color: cardColor, borderRadius: BorderRadius.circular(20)),
          // color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/person1.png',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: w * 0.03,
                          ),
                          Text(
                            widget.name,
                            style: GoogleFonts.nunito(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '2 min ago',
                            style: GoogleFonts.nunito(
                                color: Color(0xfff85738C),
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: w * 0.45,
                    // ),
          //           IconButton(
          //               onPressed: () {
          // //                 log('presses');
          // //                 PopupMenuButton(itemBuilder: (context)=>[PopupMenuItem(child: Text("Go"),onTap: (){
          // //  Navigator.pushNamed(
          // //                                 context, EventAttendees.routeName,
          // //                                 arguments: widget.eventModel);
          // // },)]);
          //               },
          //               icon: Image.asset(
          //                 'assets/icons/threeDots.png',
          //                 height: 24,
          //               ))

          SizedBox(height: 45,width: 5,)
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Image.asset(
                      'assets/icons/location.png',
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.place,
                      style: GoogleFonts.nunito(
                          color: buttonColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 50,
                          height: 10,
                        ),
                        Image.asset(
                          'assets/images/person1.png',
                          height: 20,
                          width: 20,
                        ),
                        Positioned(
                          left: 11,
                          child: Image.asset(
                            'assets/images/person2.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Positioned(
                          left: 20,
                          child: Image.asset(
                            'assets/images/person2.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Positioned(
                          left: 30,
                          child: Image.asset(
                            'assets/images/person2.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.attendees,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: buttonTextColor),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 80,
                      height: 22,
                      decoration: BoxDecoration(
                          color: Color(0xfffE3B6F6),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text('10 Mutuals'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                         Navigator.pushNamed(
                                          context, EventAttendees.routeName,
                                          arguments: widget.eventModel);
                      },
                      child: Container(
                        width: h * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(100))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/like.png',
                                height: 20,
                                color: buttonTextColor,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Intrested',
                                style: GoogleFonts.nunito(
                                    color: buttonTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
        ),
      );
  }
}