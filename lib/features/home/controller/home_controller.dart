import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/data/remote_data/api_config.dart';
import 'package:flutter_news_app/core/data/remote_data/api_service.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';

class HomeController extends ChangeNotifier {
  List<ArticleNewsModel> newsTopHeadLineList = [];
  List<ArticleNewsModel> newsEverythingList = [];
  ApiService apiService = ApiService();
  String? errorMessage;
  String? selectedCategory;

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadLineStatus = RequestStatusEnum.loading;

  HomeController() {
    getEverything();
    getTopHeadLines();
  }
  Future<void> getTopHeadLines({String? category}) async {
    try {
      final Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        query: {"country": "us", "category": selectedCategory},
      );

      newsTopHeadLineList = (result["articles"] as List).map((e) => ArticleNewsModel.fromJson(e)).toList();
      topHeadLineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      topHeadLineStatus = RequestStatusEnum.error;
    }
    notifyListeners();
  }

  Future<void> getEverything() async {
    try {
      final Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        query: {"q": "egypt", 'language': 'en'},
      );

      newsEverythingList = (result["articles"] as List).map((e) => ArticleNewsModel.fromJson(e)).toList();
      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLines(category: selectedCategory);
    notifyListeners();
  }
}
