import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/core/extension/date_time.dart';
import 'package:flutter_news_app/core/widgets/custom_cached_network_image.dart';
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(8),
                        child: CustomCachedNetworkImage(imageUrl: model.urlToImage ?? ""),
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
                                if (model.urlToImage != null)
                                  CircleAvatar(backgroundImage: NetworkImage(model.urlToImage ?? ""), radius: 10),
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
                                  (model.publishedAt.formatDateTime()),
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
            );
        }
      },
    );
  }
}
