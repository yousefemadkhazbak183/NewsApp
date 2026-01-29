import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/repository/news_repository.dart';
import 'package:flutter_news_app/details/details_screen.dart';
import 'package:flutter_news_app/features/search/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SearchScreenController(NewsRepository());
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Search'), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Consumer<SearchScreenController>(
            builder:
                (BuildContext context, SearchScreenController controller, Widget? child) {
                  return Column(
                    children: [
                      TextField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.getEverything();
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          suffixIcon: Icon(
                            Icons.search,
                            color: AppColor.iconColor,
                            size: AppSizes.r30,
                          ),
                        ),
                      ),

                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.newsEverythingList.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final model = controller.newsEverythingList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(model: model),
                                    ),
                                  );
                                },
                                leading: Icon(
                                  Icons.search,
                                  color: AppColor.iconColor,
                                  size: AppSizes.r20,
                                ),

                                title: Text(
                                  model.title ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(color: AppColor.iconColor);
                          },
                        ),
                      ),
                    ],
                  );
                },
          ),
        ),
      ),
    );
  }
}
