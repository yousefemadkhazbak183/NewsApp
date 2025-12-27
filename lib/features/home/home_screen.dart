import 'package:flutter/material.dart';

import 'package:flutter_news_app/features/home/components/categorises_list.dart';
import 'package:flutter_news_app/features/home/components/top_headline.dart';
import 'package:flutter_news_app/features/home/components/trending_news.dart';

import 'package:flutter_news_app/features/home/controller/home_controller.dart';
import 'package:flutter_news_app/core/repository/news_repository.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) {
        return HomeController(NewsRepository());
      },
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: CustomScrollView(slivers: [const TrendingNews(), CategoriesList(), const TopHeadline()]),
          );
        },
      ),
    );
  }
}
