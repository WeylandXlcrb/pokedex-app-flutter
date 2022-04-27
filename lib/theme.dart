import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme _buildTextTheme(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return GoogleFonts.latoTextTheme(textTheme);
}

ThemeData appLightTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.blue,
    textTheme: _buildTextTheme(context),
  );
}