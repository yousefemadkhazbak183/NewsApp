import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/light_theme.dart';
import 'package:flutter_news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: SizedBox(
              height: 35,
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
                            style: const TextStyle(color: Color(0xFF363636), fontSize: 16),
                          ),
                          if (isSelected) ...[
                            const SizedBox(height: 2),
                            Container(color: lightTheme.primaryColor, height: 2),
                          ],
                        ],
                      ),
                    ),
                  );
                },
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 12);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  final List<String> categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"];
}
