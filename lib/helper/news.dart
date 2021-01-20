import 'articleModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String stockName) async {
    //working string for categories
    String url =
        'https://newsapi.org/v2/everything?q=microsoft&apiKey=1d04c0e93b54469cac9d7cfb0b8fa9e4';
    // String url =
    //     'http://newsapi.org/v2/top-headlines?country=us&category=$stockName&apiKey=1d04c0e93b54469cac9d7cfb0b8fa9e4';

    // String url =
    //     'http://newsapi.org/v2/everything?domains=wsj.com&q=tesla&apiKey=1d04c0e93b54469cac9d7cfb0b8fa9e4';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article["urlToImage"] != null && article["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: article['title'],
            author: article['author'],
            description: article['description'],
            urlToImage: article['urlToImage'],
            content: article['content'],
            url: article['url'],
            //publishedAt: article['publishedAt'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
