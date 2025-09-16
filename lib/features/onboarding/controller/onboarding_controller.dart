import 'package:flutter/material.dart';

class OnboardingController with ChangeNotifier {
  int currentIndex = 0;
  final PageController pageController = PageController();
  bool isLastPage = false;
  void onPageChanged(int index) {
    if (index == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    currentIndex = index;
    notifyListeners();
  }

  void onNextPressed() {
    if (currentIndex < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutExpo,
      );
    }
  }
}
