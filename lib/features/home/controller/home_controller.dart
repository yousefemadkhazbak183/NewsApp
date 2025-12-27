import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/core/mixins/notify_mixin.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';
import 'package:flutter_news_app/core/repository/news_repository.dart';

class HomeController extends ChangeNotifier with NotifyMixin {
  List<ArticleNewsModel> newsTopHeadLineList = [];
  List<ArticleNewsModel> newsEverythingList = [];
  String? errorMessage;
  String? selectedCategory;
  NewsRepository newsRepository;
  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadLineStatus = RequestStatusEnum.loading;

  HomeController(this.newsRepository) {
    getEverything();
    getTopHeadLines();
  }
  Future<void> getTopHeadLines({String? category}) async {
    try {
      topHeadLineStatus = RequestStatusEnum.loading;
      safeNotify();
      newsTopHeadLineList = await newsRepository.getTopHeadlines(selectedCategory: selectedCategory);

      topHeadLineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      topHeadLineStatus = RequestStatusEnum.error;
    }
    safeNotify();
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
    safeNotify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLines(category: selectedCategory);
    safeNotify();
  }
}
