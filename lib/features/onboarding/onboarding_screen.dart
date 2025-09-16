import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:flutter_news_app/features/onboarding/model/onboarding_model.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                builder:
                    (
                      BuildContext context,
                      OnboardingController value,
                      Widget? child,
                    ) {
                      return value.isLastPage
                          ? const SizedBox()
                          : TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Skip',
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                    },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
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
                      final OnboardingModel model =
                          OnboardingModel.onboardingList[index];
                      return Column(
                        children: [
                          Image.asset(model.image),
                          const SizedBox(height: 24),
                          Text(
                            model.title,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xff4E4B66),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            model.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff6E7191),
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
                  builder:
                      (
                        BuildContext context,
                        OnboardingController value,
                        Widget? child,
                      ) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  color: value.currentIndex == index
                                      ? const Color(0xFFC53030)
                                      : const Color(0xFFD3D3D3),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                ),

                const SizedBox(height: 112),

                Consumer<OnboardingController>(
                  builder:
                      (
                        BuildContext context,
                        OnboardingController value,
                        Widget? child,
                      ) {
                        return ElevatedButton(
                          onPressed: () {
                            controller.onNextPressed();
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              52,
                            ),
                          ),
                          child: Text(
                            value.isLastPage ? 'Get Started' : 'Next',
                          ),
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
