import 'dart:convert';
import 'package:flashnewsapp/constants/newsApiConstants.dart';
import 'package:flashnewsapp/models/articleModel.dart';
import 'package:flashnewsapp/models/newsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  // for list view

  List<ArticleModel> allNews = <ArticleModel>[];

  // for carousel
  List<ArticleModel> breakingNews = <ArticleModel>[];
  ScrollController scrollController = ScrollController();
  RxBool articleNotFound = false.obs;
  RxBool isLoading = false.obs;
  RxString cName = ''.obs;
  RxString country = ''.obs;
  RxString category = ''.obs;
  RxString channel = ''.obs;
  RxString searchNews = ''.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 10.obs;
  String baseUrl = "https://newsapi.org/v2/top-headlines?";

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListner);

    getAllNews();
    getBreakingNews();
    super.onInit();
  }

  _scrollListner() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading.value = true;
      getAllNews();
    }
  }

  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {
    } else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    baseUrl =
        "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&";

    baseUrl += country.isEmpty ? 'country=us&' : 'country=$country&';

    baseUrl += 'apiKey=${NewsApiConstants.newsApiKey}';
    print([baseUrl]);
    getBreakingNewsFromApi(baseUrl);
  }

  getAllNews({
    channel = '',
    searchKey = '',
    reload = false,
  }) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {
    } else {
      country.value = '';
      category.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      allNews = [];

      pageNum.value = 2;
    }

    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";

    baseUrl += country.isEmpty ? 'country=in&' : 'country=$country&';

    baseUrl += category.isEmpty ? 'category=businesss&' : 'category=$category&';
    baseUrl += 'apiKey=${NewsApiConstants.newsApiKey}';
    if (channel != '') {
      country.value = '';
      category.value = '';
      baseUrl =
          "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=${NewsApiConstants.newsApiKey}";
    }
    if (searchKey != '') {
      country.value = '';
      category.value = '';
      baseUrl =
          "https://newsapi.org/v2/everything?q=$searchKey&from=2022-07-01&sortBy=popularity&pageSize=10&apiKey=${NewsApiConstants.newsApiKey}";
    }
    print(baseUrl);
    getAllNewsFromApi(baseUrl);
  }

  getBreakingNewsFromApi(url) async {
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          breakingNews = [...breakingNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            breakingNews = newsData.articles;
            update();
          }
        }
        articleNotFound.value = false;
        isLoading.value = false;
      }
    } else {
      articleNotFound.value = true;
      update();
    }
  }

  getAllNewsFromApi(url) async {
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          allNews = [...allNews, ...newsData.articles];
          update();
        } else {}
        articleNotFound.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotFound.value = true;
      update();
    }
  }
}
