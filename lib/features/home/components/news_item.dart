import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/extension/date_time.dart';
import 'package:flutter_news_app/core/widgets/custom_cached_network_image.dart';
import 'package:flutter_news_app/core/widgets/custom_svg.dart';
import 'package:flutter_news_app/details/details_screen.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final ArticleNewsModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(model: model)),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(AppSizes.r8),
              child: CustomCachedNetworkImage(imageUrl: model.urlToImage ?? ""),
            ),

            SizedBox(width: AppSizes.pw8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title ?? "",
                    style: TextStyle(
                      fontSize: AppSizes.sp16,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      if (model.urlToImage != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(model.urlToImage ?? ""),
                          radius: AppSizes.r10,
                        ),
                      SizedBox(width: AppSizes.pw6),
                      Expanded(
                        child: Text(
                          (model.author ?? "").substring(
                            0,
                            min(model.author!.length, 10),
                          ),
                          style: TextStyle(
                            color: const Color(0xFF141414),
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.sp12,
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizes.pw8),
                      Expanded(
                        child: Text(
                          (model.publishedAt.formatDateTime()),
                          style: TextStyle(
                            color: const Color(0xFF141414),
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.sp12,
                          ),
                        ),
                      ),
                      const CustomSvgPicture.withoutFilterColor(
                        path: "assets/images/bookmarks.svg",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
