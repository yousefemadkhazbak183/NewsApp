import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/bookmark/bookmark_screen.dart';
import 'package:flutter_news_app/features/home/home_screen.dart';
import 'package:flutter_news_app/features/profile/profile_screen.dart';
import 'package:flutter_news_app/features/search/search_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _screens = [const HomeScreen(), SearchScreen(), const BookmarkScreen(), const ProfileScreen()];

  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen,
        onTap: (int? index) {
          _currentScreen = index ?? 0;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/main.svg',
              colorFilter: ColorFilter.mode(
                _currentScreen == 0 ? const Color(0xFFC53030) : const Color(0xFF363636),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/search.svg',
              colorFilter: ColorFilter.mode(
                _currentScreen == 1 ? const Color(0xFFC53030) : const Color(0xFF363636),
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/bookmark.svg',
              colorFilter: ColorFilter.mode(
                _currentScreen == 2 ? const Color(0xFFC53030) : const Color(0xFF363636),
                BlendMode.srcIn,
              ),
            ),
            label: 'BookMark',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/person.svg',

              colorFilter: ColorFilter.mode(
                _currentScreen == 3 ? const Color(0xFFC53030) : const Color(0xFF363636),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),

      body: _screens[_currentScreen],
    );
  }
}
