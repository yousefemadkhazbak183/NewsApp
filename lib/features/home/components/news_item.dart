import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/extension/date_time.dart';
import 'package:flutter_news_app/core/widgets/custom_cached_network_image.dart';
import 'package:flutter_news_app/core/widgets/custom_svg.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final ArticleNewsModel model;
  @override
  Widget build(BuildContext context) {
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
                        style: const TextStyle(color: Color(0xFF141414), fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        (model.publishedAt.formatDateTime()),
                        style: const TextStyle(color: Color(0xFF141414), fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ),
                    const CustomSvgPicture.withoutFilterColor(path: "assets/images/bookmarks.svg"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
