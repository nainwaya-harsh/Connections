import 'package:connections/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowerStats extends StatelessWidget {
  final int data;
  final String title;
  const FollowerStats({super.key,required this.data,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
         data.toString(),
          style: GoogleFonts.nunito(
              color: buttonColor, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Text(
          title,
          style: GoogleFonts.nunito(
              color: buttonColor, fontSize: 14, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
