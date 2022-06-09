import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme _buildTextTheme(TextTheme base) => GoogleFonts.latoTextTheme(base);

AppBarTheme _buildAppBarTheme(AppBarTheme base) => base.copyWith(elevation: 0);

AppBarTheme _buildLightAppBarTheme(AppBarTheme base) =>
    _buildAppBarTheme(base).copyWith(
      foregroundColor: Colors.white,
    );

ThemeData appLightTheme(BuildContext context) {
  final base = ThemeData.light();

  return base.copyWith(
    useMaterial3: true,
    textTheme: _buildTextTheme(base.textTheme),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: _buildLightAppBarTheme(base.appBarTheme),
  );
}

ThemeData appDarkTheme(BuildContext context) {
  final base = ThemeData.dark();

  return base.copyWith(
    useMaterial3: true,
    textTheme: _buildTextTheme(base.textTheme),
    scaffoldBackgroundColor: const Color(0xFF131212),
    appBarTheme: _buildAppBarTheme(base.appBarTheme),
  );
}
