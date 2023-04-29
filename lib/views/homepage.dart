import 'package:carousel_slider/carousel_slider.dart';
import 'package:flashnewsapp/constants/sizeConstants.dart';
import 'package:flashnewsapp/constants/uiConstants.dart';
import 'package:flashnewsapp/controllers/newsController.dart';
import 'package:flashnewsapp/views/webViewNews.dart';
import 'package:flashnewsapp/widgets/customAppBar.dart';
import 'package:flashnewsapp/widgets/newsCard.dart';
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
              const SizedBox(
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
                                          child: InkWell(
                                            onTap: () => Get.to(() =>
                                                WebViewNews(
                                                    newsUrl: instance.url)),
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
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
                                                              StackTrace?
                                                                  stackTrace) {
                                                    return Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const SizedBox(
                                                        height: 200,
                                                        width: 200,
                                                        child: Icon(Icons
                                                            .broken_image_rounded),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                                Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              Colors.black12
                                                                  .withOpacity(
                                                                      0),
                                                              Colors.black
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter),
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            instance.title,
                                                            style: const TextStyle(
                                                                fontSize: Sizes
                                                                    .dimen_16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ))
                                              ],
                                            ),
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
                  }),
              vertical10,
              const Divider(),
              vertical10,
              newsController.cName.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: Sizes.dimen_18),
                      child: Obx(() {
                        return Text(
                          newsController.cName.value.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: Sizes.dimen_20,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                    )
                  : const SizedBox.shrink(),
              vertical10,
              GetBuilder<NewsController>(
                  init: NewsController(),
                  builder: (controller) {
                    return controller.articleNotFound.value
                        ? const Center(
                            child: Text("Noothing Found"),
                          )
                        : controller.allNews.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                controller: controller.scrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.allNews.length,
                                itemBuilder: (context, index) {
                                  index == controller.allNews.length - 1 &&
                                          controller.isLoading.isTrue
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const SizedBox();
                                  return InkWell(
                                    onTap: () => Get.to(() => WebViewNews(
                                        newsUrl:
                                            controller.allNews[index].url)),
                                    child: NewsCard(
                                        posturl: controller.allNews[index].url,
                                        imaUrl: controller
                                                .allNews[index].urlToImage ??
                                            '',
                                        title: controller.allNews[index].title,
                                        desc: controller
                                                .allNews[index].description ??
                                            '',
                                        content:
                                            controller.allNews[index].content ??
                                                ''),
                                  );
                                });
                  })
            ]),
      ),
    );
  }
}
