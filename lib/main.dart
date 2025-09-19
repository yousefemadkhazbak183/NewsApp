import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/light_theme.dart';
import 'package:flutter_news_app/features/home/home_screen.dart';
import 'package:flutter_news_app/features/onboarding/onboarding_screen.dart';
import 'package:flutter_news_app/features/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      home: HomeScreen(),
    );
  }
}
