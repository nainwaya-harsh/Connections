import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryRow extends StatefulWidget {
  final bool isYours;
  final String imgUrl;
  final String title;
  final bool viewed;
  const StoryRow({super.key, required this.isYours, required this.imgUrl, required this.title, required this.viewed});

  @override
  State<StoryRow> createState() => _StoryRowState();
}

class _StoryRowState extends State<StoryRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                minRadius: 33,
                backgroundColor: Color(0xfffEBE9EC),
                child: widget.isYours
                    ? Image.asset(
                        'assets/icons/profile.png',
                        color: Color(0xfffA294A8),
                        height: 34,
                      )
                    : Image.asset(
                        'assets/images/tushar.png',
                        // color: Color(0xfffA294A8),
                        height: 70,
                      ),
              ),
              if (widget.isYours)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Color(0xfffDDD8DF), // Adjust color as needed
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.black, // Adjust icon color as needed
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.title,
            style:
                GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 12),
          )
        ],
      ),
    );
  }
}
