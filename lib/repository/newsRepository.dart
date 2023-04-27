import 'dart:convert';
import 'package:flashnewsapp/constants/newsApiConstants.dart';
import 'package:flashnewsapp/models/newsModel.dart';
import 'package:http/http.dart' as http;

class newsRepository {
  Future<List<NewsModel>> fetchNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=431cc141c7ae48f4bd75f2990dbeeed3";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<NewsModel> articleModelList = [];
    if (response.statusCode == 200) {
      for (var data in jsonData[NewsApiConstants.articles]) {
        if (data[NewsApiConstants.urlToImage] != null) {
          NewsModel articleModel = NewsModel.fromJson(data);
          articleModelList.add(articleModel);
        }
      }
      return articleModelList;
    } else {
      return articleModelList;
    }
  }

  Future<List<NewsModel>> fetchBreakingNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=${NewsApiConstants.newsApiKey}";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    List<NewsModel> articleModelList = [];
    if (response.statusCode == 200) {
      for (var data in jsonData[NewsApiConstants.articles]) {
        if (data[NewsApiConstants.description].toString().isNotEmpty &&
            data[NewsApiConstants.urlToImage].toString().isNotEmpty) {
          NewsModel articleModel = NewsModel.fromJson(data);
          articleModelList.add(articleModel);
        }
      }
      return articleModelList;
    } else {
      return articleModelList;
    }
  }
}
