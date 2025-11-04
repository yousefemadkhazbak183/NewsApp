import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset("assets/images/background.png", fit: BoxFit.fill),
          ),
          Positioned.fill(
            top: 70,
            child: Column(
              children: [
                const Text(
                  "NEWST",
                  style: TextStyle(color: AppColor.primaryColor, fontSize: 40, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: TextStyle(color: AppColor.whiteColor, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: Consumer<HomeController>(
                    builder: (BuildContext context, HomeController controller, Widget? child) {
                      switch (controller.everythingStatus) {
                        case RequestStatusEnum.loading:
                          return const Center(child: CircularProgressIndicator());
                        case RequestStatusEnum.error:
                          return Center(child: Text(controller.errorMessage!));
                        case RequestStatusEnum.loaded:
                          return ListView.separated(
                            padding: const EdgeInsets.only(left: 16),
                            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 12),
                            itemCount: controller.newsEverythingList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    if (controller.newsEverythingList[index].urlToImage != null)
                                      Image.network(
                                        controller.newsEverythingList[index].urlToImage!,
                                        width: 240,
                                        height: 140,
                                      ),

                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withValues(alpha: 0.5),
                                              Colors.black.withValues(alpha: 0.7),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
    );
  }
}
