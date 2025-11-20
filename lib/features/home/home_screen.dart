import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/home/components/view_all_component.dart';
import 'package:flutter_news_app/features/home/components/trending_news.dart';

import 'package:flutter_news_app/features/home/controller/home_controller.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: Column(
              children: [
                const TrendingNews(),
                ViewAllComponent(title: "Categories", titleColor: const Color(0xFF141414), onTap: () {}),

                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Text(categories[index], style: const TextStyle(color: Color(0xFF363636), fontSize: 16));
                      },
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 12);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // business entertainment general health science sports technology

  final List<String> categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"];
}
