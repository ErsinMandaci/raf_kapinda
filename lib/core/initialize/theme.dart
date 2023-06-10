import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData get theme => ThemeData.light().copyWith(
    
        textTheme: GoogleFonts.questrialTextTheme(),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
        ),
      );
}
