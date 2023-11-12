import 'dart:convert';

import 'package:daily_news_app1/models/article_model.dart';
import 'package:http/http.dart' as http;


class News{
  List<ArticleModel> news = [];
  Future<void> getNews()async{
    String url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=3c2b186736be411bb5999fe4f92143ac";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == 'ok'){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articleModel);
        }



      });
    }
  }
}