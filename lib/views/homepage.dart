import 'package:carousel_slider/carousel_slider.dart';
import 'package:flashnewsapp/constants/colorConstants.dart';
import 'package:flashnewsapp/constants/sizeConstants.dart';
import 'package:flashnewsapp/constants/uiConstants.dart';
import 'package:flashnewsapp/controllers/newsController.dart';
import 'package:flashnewsapp/views/webViewNews.dart';
import 'package:flashnewsapp/widgets/customAppBar.dart';
import 'package:flashnewsapp/widgets/newsCard.dart';
import 'package:flashnewsapp/widgets/sideDrawer.dart';
import 'package:flashnewsapp/widgets/tiles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homePage extends StatelessWidget {
  homePage({super.key});

  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();

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
                searchController.clear();
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
              Flexible(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
                margin: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_18, vertical: Sizes.dimen_8),
                decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Search News"),
                        onChanged: (val) {
                          newsController.searchNews.value = val;
                          newsController.update();
                        },
                        onSubmitted: (value) async {
                          newsController.searchNews.value = value;
                          newsController.getAllNews(
                              searchKey: newsController.searchNews.value);
                        },
                      ),
                    ),
                  ],
                ),
              )),
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
              GetBuilder<NewsController>(builder: (controller) {
                return Container(
                  margin: EdgeInsets.only(left: Sizes.dimen_16),
                  height: Get.height * 0.05,
                  child: Row(
                    children: [
                      const Text(
                        "Sorted by:   ",
                        style: TextStyle(
                            color: AppColors.burgundy,
                            fontWeight: FontWeight.w500),
                      ),
                      controller.cName.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              height: Get.height * 0.04,
                              decoration: BoxDecoration(
                                  color: AppColors.darkBackground,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "${controller.cName.value.toUpperCase()} ",
                                  style: const TextStyle(
                                      color: AppColors.burgundy,
                                      fontWeight: FontWeight.w500),
                                ),
                              ))
                          : const SizedBox.shrink(),
                      controller.category.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              padding: const EdgeInsets.all(4),
                              height: Get.height * 0.04,
                              decoration: BoxDecoration(
                                  color: AppColors.darkBackground,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "${controller.category.value.toUpperCase()} ",
                                  style: const TextStyle(
                                      color: AppColors.burgundy,
                                      fontWeight: FontWeight.w500),
                                ),
                              ))
                          : const SizedBox.shrink(),
                      controller.channel.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              padding: const EdgeInsets.all(4),
                              height: Get.height * 0.04,
                              decoration: BoxDecoration(
                                  color: AppColors.darkBackground,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "${controller.channel.value.toUpperCase()} ",
                                  style: const TextStyle(
                                      color: AppColors.burgundy,
                                      fontWeight: FontWeight.w500),
                                ),
                              ))
                          : const SizedBox.shrink()
                    ],
                  ),
                );
              }),
              const SizedBox(
                height: Sizes.dimen_10,
              ),
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
