import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/data/local_data/shared_preferences.dart';
import 'package:flutter_news_app/features/auth/login_screen.dart';
import 'package:flutter_news_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:flutter_news_app/features/onboarding/model/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _onFinish(BuildContext context) async {
    await PreferencesManager().setBool('onBoarding_complete', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingController>(
      create: (_) => OnboardingController(),

      builder: (context, child) {
        final controller = context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFf5f5f5),
            actions: [
              Consumer<OnboardingController>(
                builder: (BuildContext context, OnboardingController value, Widget? child) {
                  return value.isLastPage
                      ? const SizedBox()
                      : TextButton(
                          onPressed: () {
                            _onFinish(context);
                          },
                          child: Text('Skip', style: TextStyle(fontSize: AppSizes.sp16)),
                        );
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.h30, horizontal: AppSizes.pw16),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: OnboardingModel.onboardingList.length,
                    onPageChanged: (int index) {
                      context.read<OnboardingController>().onPageChanged(index);
                    },
                    controller: controller.pageController,
                    itemBuilder: (BuildContext context, int index) {
                      final OnboardingModel model = OnboardingModel.onboardingList[index];
                      return Column(
                        children: [
                          Image.asset(model.image),
                          SizedBox(height: AppSizes.h24),
                          Text(
                            model.title,
                            style: TextStyle(
                              fontSize: AppSizes.sp20,
                              color: const Color(0xff4E4B66),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: AppSizes.h12),
                          Text(
                            model.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppSizes.sp16,
                              color: const Color(0xff6E7191),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<OnboardingController>(
                  builder: (BuildContext context, OnboardingController value, Widget? child) {
                    return SmoothPageIndicator(
                      controller: value.pageController,
                      count: 3,
                      effect: const WormEffect(activeDotColor: Color(0xFFC53030)),
                    );
                  },
                ),

                SizedBox(height: AppSizes.h112),

                Consumer<OnboardingController>(
                  builder: (BuildContext context, OnboardingController value, Widget? child) {
                    return ElevatedButton(
                      onPressed: () {
                        if (!value.isLastPage) {
                          controller.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _onFinish(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(fixedSize: Size(MediaQuery.of(context).size.width, AppSizes.h52)),
                      child: Text(value.isLastPage ? 'Get Started' : 'Next'),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
