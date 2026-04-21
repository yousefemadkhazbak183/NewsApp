import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/data/local_data/shared_preferences.dart';
import 'package:flutter_news_app/core/data/user_repository.dart';
import 'package:flutter_news_app/core/theme/light_theme.dart';
import 'package:flutter_news_app/features/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await PreferencesManager().init();
  UserRepository().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 832),
      minTextAdapt: true,
      builder: (conte, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
