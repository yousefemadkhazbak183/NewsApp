import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/enum/request_status_enum.dart';
import 'package:flutter_news_app/core/mixins/notify_mixin.dart';
import 'package:flutter_news_app/core/repository/news_repository.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';

class SearchScreenController extends ChangeNotifier with NotifyMixin {
  SearchScreenController(this.newsRepository);
  final BaseNewsRepository newsRepository;

  final TextEditingController searchController = TextEditingController();

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  List<ArticleNewsModel> newsEverythingList = [];
  String? errorMessage;

  Future<void> getEverything() async {
    try {
      newsEverythingList = await newsRepository.getEverything(query: searchController.text);
      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }
    safeNotify();
  }
}
