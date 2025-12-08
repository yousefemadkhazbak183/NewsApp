import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TopHeadlineShimmer extends StatelessWidget {
  const TopHeadlineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade100,
            child: Container(height: AppSizes.h80, color: Colors.white),
          ),
        );
      },
    );
  }
}
