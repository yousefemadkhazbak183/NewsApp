import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';
import 'package:flutter_news_app/features/home/repository/news_repository.dart';

NewsRepository newsRepository = NewsRepository();

class HomeController extends ChangeNotifier {
  List<ArticleNewsModel> newsTopHeadLineList = [];
  List<ArticleNewsModel> newsEverythingList = [];
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
      topHeadLineStatus = RequestStatusEnum.loading;
      notifyListeners();
      newsTopHeadLineList = await newsRepository.getTopHeadlines(selectedCategory: selectedCategory);

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
      newsEverythingList = await newsRepository.getEverything();
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
