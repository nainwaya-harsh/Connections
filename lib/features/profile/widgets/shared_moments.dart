import 'package:connections/constants/colors.dart';
import 'package:connections/features/createEvent/screens/attend_event.dart';
import 'package:connections/models/eventModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedMoments extends StatelessWidget {
  final EventModel event;
  final bool isCreated;
  const SharedMoments(
      {super.key, required this.event, required this.isCreated});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: InkWell(
        onTap: (){
           Navigator.pushNamed(
                                          context, EventAttendees.routeName,
                                          arguments: event);
        },
        child: Container(
          decoration: BoxDecoration(
              color: cardColor, borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 11,
                        ),
                        Image.asset(
                          'assets/images/person2.png',
                          height: 20,
                        ),
                        if(isCreated)
                          Text(
                          '   You Created ${event.ename} on ${event.edate}',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
        
                        if(!isCreated)
                          Text(
                          '   You attended ${event.ename} on ${event.edate}',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/threeDots.png',
                          height: 20,
                        ))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Image.asset(
                      'assets/icons/location.png',
                      height: 22,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      event.ecity,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
