import 'package:carousel_slider/carousel_slider.dart';
import 'package:flashnewsapp/constants/sizeConstants.dart';
import 'package:flashnewsapp/controllers/newsController.dart';
import 'package:flashnewsapp/widgets/customAppBar.dart';
import 'package:flashnewsapp/widgets/sideDrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homePage extends StatelessWidget {
  homePage({super.key});

  NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawe(newsController),
      appBar: customAppBar(
        'Flash News',
        context,
        actions: [
          IconButton(
              onPressed: () {
                newsController.country.value = '';
                newsController.category.value = '';
                newsController.searchNews.value = '';
                newsController.channel.value = '';
                newsController.cName.value = '';
                newsController.getAllNews(reload: true);
                newsController.getBreakingNews(reload: true);
                newsController.update();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Sizes.dimen_10,
            ),
            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200, autoPlay: true, enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center(
                              child: Text("Not Found"),
                            )
                          : controller.breakingNews.isEmpty
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Builder(
                                  builder: (BuildContext context) {
                                    try {
                                      return Banner(
                                        location: BannerLocation.topStart,
                                        message: 'Top Headlines',
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                instance.urlToImage ?? "",
                                                fit: BoxFit.fill,
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                      return Container();
                                    }
                                  },
                                );
                    }).toList(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
