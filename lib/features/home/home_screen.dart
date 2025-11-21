import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/home/components/categorises_list.dart';
import 'package:flutter_news_app/features/home/components/view_all_component.dart';
import 'package:flutter_news_app/features/home/components/trending_news.dart';

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
            body: CustomScrollView(
              slivers: [
                const TrendingNews(),
                SliverToBoxAdapter(
                  child: ViewAllComponent(title: "Categories", titleColor: const Color(0xFF141414), onTap: () {}),
                ),
                CategoriesList(),

                SliverList.builder(
                  itemCount: controller.newsTopHeadLineList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = controller.newsTopHeadLineList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            child: Image.network(model.urlToImage ?? "", height: 70, width: 120, fit: BoxFit.cover),
                          ),

                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.title ?? "",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(backgroundImage: NetworkImage(model.urlToImage ?? "")),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        (model.author ?? "").substring(0, min(model.author!.length, 10)),
                                        style: const TextStyle(
                                          color: Color(0xFF141414),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      (model.publishedAt ?? ""),
                                      style: const TextStyle(
                                        color: Color(0xFF141414),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
