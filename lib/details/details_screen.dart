import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/extension/date_time.dart';
import 'package:flutter_news_app/core/widgets/custom_svg.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.model});
  final ArticleNewsModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Details"), centerTitle: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.w16),
          child: Column(
            children: [
              SizedBox(height: AppSizes.ph8),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r4),
                child: CachedNetworkImage(
                  imageUrl: model.urlToImage ?? "",
                  height: AppSizes.h200,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: AppSizes.h12),
              Text(
                model.title ?? "",
                style: TextStyle(fontSize: AppSizes.sp20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: AppSizes.h16),
              Row(
                children: [
                  if (model.urlToImage != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(model.urlToImage ?? ""),
                      radius: AppSizes.r16,
                    ),
                  SizedBox(width: AppSizes.w8),
                  Expanded(
                    child: Text(
                      (model.author ?? "").substring(0, min(model.author!.length, 10)),
                      style: TextStyle(
                        color: const Color(0xFF141414),
                        fontWeight: FontWeight.w400,
                        fontSize: AppSizes.sp14,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.w2),
                  Expanded(
                    child: Text(
                      (model.publishedAt.formatDateTime()),
                      style: TextStyle(
                        color: const Color(0xFF141414),
                        fontWeight: FontWeight.w400,
                        fontSize: AppSizes.sp14,
                      ),
                    ),
                  ),
                  CustomSvgPicture.withoutFilterColor(
                    path: "assets/images/bookmarks.svg",
                    width: AppSizes.w24,
                    height: AppSizes.h24,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.h16),
              Text(
                model.description ?? "",
                style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
