import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/home/models/article_news_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArticleNewsModel> newsArticlesList = [];

  @override
  void initState() {
    callEndPoint();
    super.initState();
  }

  Future<void> callEndPoint() async {
    final urlForTopHeadlines = Uri.https('newsapi.org', 'v2/top-headlines', {
      'apiKey': 'd4cc963b2b5a412295660d970e0610f6',
      'country': 'us',
    });

    // print(urlForTopHeadlines);

    final Response response = await http.get(urlForTopHeadlines);
    // print(response.body);

    final Map<String, dynamic> result =
        jsonDecode(response.body) as Map<String, dynamic>;
    setState(() {
      newsArticlesList = (result["articles"] as List)
          .map((e) => ArticleNewsModel.fromJson(e))
          .toList();
    });
    // print(result['articles'][0]['description']);

    // var response = await http.post(
    //   url,
    //   body: {'name': 'doodle', 'color': 'blue'},
    // );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: newsArticlesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(newsArticlesList[index].title ?? "");
              },
            ),
          ),
        ],
      ),
    );
  }
}
