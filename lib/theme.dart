import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle titleLarge = GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static TextStyle titleMedium = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static TextStyle bodyLarge = GoogleFonts.nunito(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle bodyMedium = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  static TextStyle buttonText = GoogleFonts.nunito(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
}
