import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/core/extension/date_time.dart';
import 'package:flutter_news_app/core/widgets/custom_cached_network_image.dart';
import 'package:flutter_news_app/details/details_screen.dart';
import 'package:flutter_news_app/features/home/components/trending_news_shimmer.dart';
import 'package:flutter_news_app/features/home/components/view_all_component.dart';
import 'package:flutter_news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h340,
        child: Stack(
          children: [
            SizedBox(
              height: AppSizes.h240,
              width: double.infinity,
              child: Image.asset("assets/images/background.png", fit: BoxFit.fill),
            ),
            Positioned.fill(
              top: 70,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: AppSizes.sp40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppSizes.h6),
                  ViewAllComponent(title: "Trending News", onTap: () {}),
                  SizedBox(height: AppSizes.h12),
                  SizedBox(
                    height: AppSizes.h140,
                    child: Consumer<HomeController>(
                      builder:
                          (
                            BuildContext context,
                            HomeController controller,
                            Widget? child,
                          ) {
                            switch (controller.everythingStatus) {
                              case RequestStatusEnum.loading:
                                return const TrendingNewsShimmer();
                              case RequestStatusEnum.error:
                                return Center(child: Text(controller.errorMessage!));
                              case RequestStatusEnum.loaded:
                                return ListView.separated(
                                  padding: EdgeInsets.only(left: AppSizes.w16),
                                  separatorBuilder: (BuildContext context, int index) =>
                                      SizedBox(width: AppSizes.w12),
                                  itemCount: controller.newsEverythingList.take(3).length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    final model = controller.newsEverythingList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsScreen(model: model),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: AppSizes.w240,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.r12,
                                          ),
                                          child: Stack(
                                            children: [
                                              if (model.urlToImage != null)
                                                CustomCachedNetworkImage(
                                                  imageUrl: model.urlToImage!,
                                                  height: AppSizes.h140,
                                                  width: AppSizes.w240,
                                                ),

                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Colors.black.withValues(
                                                          alpha: 0.5,
                                                        ),
                                                        Colors.black.withValues(
                                                          alpha: 0.7,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: AppSizes.w12,
                                                bottom: AppSizes.h12,
                                                right: AppSizes.w12,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model.title!,
                                                      style: TextStyle(
                                                        color: const Color(0xFFFFFCFC),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: AppSizes.sp16,
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                    SizedBox(height: AppSizes.h6),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                      model.urlToImage
                                                                          .toString(),
                                                                    ),
                                                                radius: AppSizes.r10,
                                                              ),
                                                              SizedBox(
                                                                width: AppSizes.pw6,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  model.author ??
                                                                      "لا يوجد ",
                                                                  style: TextStyle(
                                                                    color: const Color(
                                                                      0xFFFFFCFC,
                                                                    ),
                                                                    fontWeight:
                                                                        FontWeight.w400,
                                                                    fontSize:
                                                                        AppSizes.sp12,
                                                                  ),
                                                                ),
                                                              ),

                                                              Text(
                                                                model.publishedAt
                                                                    .formatDateTime(),
                                                                style: TextStyle(
                                                                  fontSize: AppSizes.sp12,
                                                                  fontWeight:
                                                                      FontWeight.w400,
                                                                  color: const Color(
                                                                    0xFFFFFCFC,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                            }
                          },
                    ),
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
