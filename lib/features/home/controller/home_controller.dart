import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/data/remote_data/api_config.dart';
import 'package:flutter_news_app/core/data/remote_data/api_service.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';

class HomeController extends ChangeNotifier {
  bool isTopHeadLineLoading = true;
  bool isEverythingLoading = true;
  List<ArticleNewsModel> newsTopHeadLineList = [];
  List<ArticleNewsModel> newsEverythingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;

  HomeController() {
    getEverything();
    getTopHeadLines();
  }
  Future<void> getTopHeadLines() async {
    try {
      final Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,

        query: {"country": "us"},
      );

      newsTopHeadLineList = (result["articles"] as List)
          .map((e) => ArticleNewsModel.fromJson(e))
          .toList();
      isTopHeadLineLoading = false;
      errorMessage = null;
    } catch (e) {
      isTopHeadLineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> getEverything() async {
    try {
      final Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        query: {"q": "AL-Ahly", 'language': 'us'},
      );

      newsEverythingList = (result["articles"] as List)
          .map((e) => ArticleNewsModel.fromJson(e))
          .toList();
      isEverythingLoading = false;
      errorMessage = null;
    } catch (e) {
      isEverythingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
