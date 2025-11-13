import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/features/home/components/view_all_component.dart';
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
                ViewAllComponent(title: "Trending News", onTap: () {}),
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
                            itemCount: controller.newsEverythingList.take(3).length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final model = controller.newsEverythingList[index];
                              return SizedBox(
                                width: 240,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Stack(
                                    children: [
                                      if (model.urlToImage != null)
                                        Image.network(model.urlToImage!, width: 240, height: 140),

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
                                      Positioned(
                                        left: 12,
                                        bottom: 12,
                                        right: 12,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.title!,
                                              style: const TextStyle(
                                                color: Color(0xFFFFFCFC),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage(model.urlToImage.toString()),
                                                        radius: 10,
                                                      ),
                                                      const SizedBox(width: 6),
                                                      Expanded(
                                                        child: Text(
                                                          model.author ?? "لا يوجد ",
                                                          style: const TextStyle(
                                                            color: Color(0xFFFFFCFC),
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),

                                                      Text(
                                                        formatDataTime(model.publishedAt),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color(0xFFFFFCFC),
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

  /// TODO :  Refactor
  String formatDataTime(String? date) {
    if (date == null) {
      return "";
    }
    final differenceTime = DateTime.now().difference(DateTime.parse(date));

    if (differenceTime.inMinutes < 60) {
      return "${differenceTime.inMinutes} m ago.";
    }
    if (differenceTime.inHours < 24) {
      return "${differenceTime.inHours} h ago.";
    }
    return "${differenceTime.inDays} d ago.";
  }
}
