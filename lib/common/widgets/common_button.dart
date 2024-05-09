import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final Color? color;
  final Color? fontcolor;
  const customButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.color,
      this.fontcolor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: color,
            minimumSize: Size(358, 62),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: ontap,
        child: Text(
          title,
          style: TextStyle(
              color: fontcolor, fontSize: 19, fontWeight: FontWeight.w600),
        ));
  }
}
