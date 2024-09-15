import 'package:connections/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedMoments extends StatelessWidget {
  final String guestName;
  final String eventlocation;
  const SharedMoments({super.key,required this.guestName,required this.eventlocation});

  @override
  Widget build(BuildContext context) {
   return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Container(
          decoration: BoxDecoration(
              color: cardColor, borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/person2.png',
                      height: 20,
                    ),
                    Text(
                      'You and ${guestName} shared moment at',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    SizedBox(width: 50),
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
                      eventlocation,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }
}