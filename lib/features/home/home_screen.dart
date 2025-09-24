import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/data/remote_data/api_config.dart';
import 'package:flutter_news_app/core/data/remote_data/api_service.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArticleNewsModel> newsTopHeadLineList = [];
  List<ArticleNewsModel> newsEverythingList = [];
  ApiService apiService = ApiService();

  @override
  void initState() {
    getTopHeadLines();
    getEverything();
    super.initState();
  }

  Future<void> getTopHeadLines() async {
    final Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadlines,

      query: {"country": "us"},
    );

    setState(() {
      newsTopHeadLineList = (result["articles"] as List)
          .map((e) => ArticleNewsModel.fromJson(e))
          .toList();
    });
  }

  Future<void> getEverything() async {
    final Map<String, dynamic> result = await apiService.get(
      ApiConfig.everything,
      query: {"q": "AL-Ahly", 'language': 'us'},
    );

    setState(() {
      newsEverythingList = (result["articles"] as List)
          .map((e) => ArticleNewsModel.fromJson(e))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: newsTopHeadLineList.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(newsTopHeadLineList[index].title ?? "");
              },
            ),
          ),
        ],
      ),
    );
  }
}
