import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color textColor = Colors.white;
  static Color black = Colors.black;
  static Color blue = Colors.blue;

  static TextStyle appBarTitle = GoogleFonts.poppins(
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
  static TextStyle text = GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: black,
  );
  static TextStyle button = GoogleFonts.poppins(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: textColor,
  );
  static TextStyle hint = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
