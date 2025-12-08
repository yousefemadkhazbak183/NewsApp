import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/theme/light_theme.dart';
import 'package:flutter_news_app/features/home/components/news_item.dart';
import 'package:flutter_news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class HomeCategoryScreen extends StatelessWidget {
  HomeCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories"), centerTitle: true),
      body: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppSizes.pw16, top: AppSizes.ph16, bottom: AppSizes.ph16),
                child: SizedBox(
                  height: AppSizes.h35,
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final bool isSelected = controller.selectedCategory == categories[index];

                      return GestureDetector(
                        onTap: () {
                          controller.updateSelectedCategory(categories[index]);
                        },
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Text(
                                categories[index][0].toUpperCase() + categories[index].substring(1),
                                style: TextStyle(color: const Color(0xFF363636), fontSize: AppSizes.sp16),
                              ),
                              if (isSelected) ...[
                                SizedBox(height: AppSizes.h2),
                                Container(color: lightTheme.primaryColor, height: AppSizes.h2),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: AppSizes.pw12);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.newsTopHeadLineList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = controller.newsTopHeadLineList[index];
                    return NewsItem(model: model);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final List<String> categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"];
}
