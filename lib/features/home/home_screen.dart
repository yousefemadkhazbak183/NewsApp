import 'package:flutter/material.dart';

import 'package:flutter_news_app/features/home/controller/home_controller.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: (controller.errorMessage?.isNotEmpty ?? false)
                ? Center(child: Text(controller.errorMessage!))
                : controller.isEverythingLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      if (controller.isEverythingLoading)
                        const Center(child: CircularProgressIndicator()),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.newsTopHeadLineList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              controller.newsTopHeadLineList[index].title ?? "",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
