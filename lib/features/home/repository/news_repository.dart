import 'package:flutter_news_app/core/data/remote_data/api_config.dart';
import 'package:flutter_news_app/core/data/remote_data/api_service.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';

class NewsRepository {
  //
  Future<List<ArticleNewsModel>> getTopHeadlines({String? selectedCategory = "general"}) async {
    final Map<String, dynamic> result = await ApiService().get(
      ApiConfig.topHeadlines,
      query: {"country": "us", "category": selectedCategory},
    );

    return (result["articles"] as List).map((e) => ArticleNewsModel.fromJson(e)).toList();
  }

  Future<List<ArticleNewsModel>> getEverything() async {
    final Map<String, dynamic> result = await ApiService().get(
      ApiConfig.everything,
      query: {"q": "egypt", 'language': 'en'},
    );

    return (result["articles"] as List).map((e) => ArticleNewsModel.fromJson(e)).toList();
  }
}
