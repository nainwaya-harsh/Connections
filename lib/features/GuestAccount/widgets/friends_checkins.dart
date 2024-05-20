import 'package:connections/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsCheckins extends StatelessWidget {
  const FriendsCheckins({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      'Tushar Shah',
                      style: GoogleFonts.nunito(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: w * 0.5,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/threeDots.png',
                          height: 24,
                        ))
                  ],
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in mi sit amet augue lobortis rhoncus a imperdiet nibh.',
                  style: GoogleFonts.nunito(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Image.asset('assets/images/arijit.png'),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
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
                              'Like',
                              style: GoogleFonts.nunito(
                                  color: buttonTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/share.png',
                              height: 20,
                              color: buttonTextColor,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Share',
                              style: GoogleFonts.nunito(
                                  color: buttonTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
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