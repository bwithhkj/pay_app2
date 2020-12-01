import 'package:flutter/material.dart';
//import 'package:indianapp/LightColor.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign align;

  const TitleText(
      {Key key,
      this.text,
      this.fontSize = 18,
      this.color = Colors.white,
      this.fontWeight = FontWeight.w800,
      this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.muli(fontSize: fontSize, fontWeight: fontWeight, color: color),
      textAlign: align != null ? align : TextAlign.start,
    );
  }
}
