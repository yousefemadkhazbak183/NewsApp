import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/core/extension/date_time.dart';
import 'package:flutter_news_app/core/widgets/custom_cached_network_image.dart';
import 'package:flutter_news_app/core/widgets/custom_svg.dart';
import 'package:flutter_news_app/features/home/components/news_item.dart';
import 'package:flutter_news_app/features/home/components/top_headline_shimmer.dart';
import 'package:flutter_news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        switch (controller.topHeadLineStatus) {
          case RequestStatusEnum.loading:
            return const TopHeadlineShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(child: Center(child: Text(controller.errorMessage ?? "")));
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadLineList.length,
              itemBuilder: (BuildContext context, int index) {
                final model = controller.newsTopHeadLineList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
