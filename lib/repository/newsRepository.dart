import 'dart:convert';
import 'package:flashnewsapp/constants/newsApiConstants.dart';
import 'package:flashnewsapp/models/newsModel.dart';
import 'package:http/http.dart' as http;

class newsRepository {
  Future<List<NewsModel>> fetchNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?q=business&languages=en&apiKey=431cc141c7ae48f4bd75f2990dbeeed3";

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

  Future<List<NewsModel>> searchNews({required String query}) async {
    String url = '';
    if (query.isEmpty) {
      url =
          'https://newsapi.org/v2/everything?q=biden&from=2022-07-12&sortBy=popularity&apiKey=431cc141c7ae48f4bd75f2990dbeeed3';
    } else {
      url =
          "https://newsapi.org/v2/everything?q=$query&apiKey=${NewsApiConstants.newsApiKey}";
    }

    var response = await http.get(Uri.parse(url));
    print(url);
    var jsonData = jsonDecode(response.body);
    List<NewsModel> articleModelList = [];
    if (response.statusCode == 200) {
      for (var data in jsonData[NewsApiConstants.articles]) {
        if (query.isNotEmpty && data[NewsApiConstants.urlToImage] != null) {
          NewsModel articleModel = NewsModel.fromJson(data);
          articleModelList.add(articleModel);
        } else if (query.isEmpty) {
          throw Exception('Query is empty');
        } else {
          throw Exception('Data was not loaded properly');
        }
      }
      return articleModelList;
    } else {
      // returns an empty list.
      return articleModelList;
    }
  }
}
