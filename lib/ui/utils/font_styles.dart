import 'colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MyFontStyles {
  static TextTheme textTheme = GoogleFonts.loversQuarrelTextTheme();

  static final title = GoogleFonts.loversQuarrel(
    fontWeight: FontWeight.bold,
    color: darkColor1,
    fontSize: 44,
  );

  static final titles = GoogleFonts.loversQuarrel(
    fontWeight: FontWeight.bold,
    color: darkColor1,
    fontSize: 33,
  );

  static final button = GoogleFonts.lora(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  static final subtitleColor = GoogleFonts.lora(
    color: primColor,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static final subSubtitle = GoogleFonts.lora(
    color: gColor4,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static final normal = GoogleFonts.lora(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}
