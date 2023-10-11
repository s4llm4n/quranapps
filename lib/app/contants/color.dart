import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color(0xFF1E0771);
const appPurpleLight1 = Color(0xFF9345F2);
const appPurpleLight2 = Color(0xFFB9A2DB);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFE6704A);

ThemeData themeLight = ThemeData(
  primaryColor: appPurple,
  scaffoldBackgroundColor: appWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurple,
  ),
);
ThemeData themeDark = ThemeData(
  primaryColor: appPurple,
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurpleDark,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: appWhite,
    ),
    bodyText2: TextStyle(
      color: appWhite,
    ),
  ),
);