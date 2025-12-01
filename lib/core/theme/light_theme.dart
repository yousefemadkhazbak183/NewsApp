import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(secondary: Color(0xFF6A6A6A)),
  primaryColor: AppColor.primaryColor,
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),

  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFFC53030))),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColor.secondColor),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColor.secondColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFC53030),
      foregroundColor: const Color(0xFFFFFCFC),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      shape: const RoundedRectangleBorder(),
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFFC53030),
    unselectedItemColor: Color(0xFF363636),
    backgroundColor: Color(0xfFF6F7F9),
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    selectedIconTheme: IconThemeData(color: Color(0xFFC53030)),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: AppColor.secondColor, fontSize: 16, fontWeight: FontWeight.w400),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    focusColor: Color(0xFFD1DAD6),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,

      borderSide: BorderSide(color: Colors.red),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,

      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,

      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
  ),
);
