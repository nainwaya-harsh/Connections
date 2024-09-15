import 'package:connections/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularCheckins extends StatefulWidget {
  final String eventName;
  final String attendees;
  final String imgUrl;
  const PopularCheckins({super.key, required this.eventName, required this.attendees,required this.imgUrl});

  @override
  State<PopularCheckins> createState() => _PopularCheckinsState();
}

class _PopularCheckinsState extends State<PopularCheckins> {
  @override
  Widget build(BuildContext context) {
   return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: cardColor, borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.imgUrl,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.eventName,
                        style: GoogleFonts.nunito(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/peoples.png',
                            color: Colors.black,
                            height: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${widget.attendees} Attendees',
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: buttonTextColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
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
                                left: 22,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 9.5,
                                  child: Text(
                                    '+8',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            '10 Mutuals',
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: buttonTextColor),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}