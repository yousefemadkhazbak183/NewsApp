import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(),

  scaffoldBackgroundColor: const Color(0xFFF5F5F5),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: const Color(0xFFC53030)),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFC53030),
      foregroundColor: const Color(0xFFFFFCFC),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),
);
