import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class News {
  List<ArticleModel> news = [];


  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/everything?q=apple&from=2024-06-19&to=2024-06-19&sortBy=popularity&apiKey=bec3d99652c64462acd94c9aedee1171";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
