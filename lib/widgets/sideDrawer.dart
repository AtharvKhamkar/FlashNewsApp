import 'package:flashnewsapp/constants/colorConstants.dart';
import 'package:flashnewsapp/constants/sizeConstants.dart';
import 'package:flashnewsapp/constants/uiConstants.dart';
import 'package:flashnewsapp/controllers/newsController.dart';
import 'package:flashnewsapp/widgets/dropDownList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flashnewsapp/utils/utils.dart';

Drawer sideDrawe(NewsController newsController) {
  return Drawer(
    backgroundColor: Colors.deepPurple[50],
    child: ListView(
      children: <Widget>[
        GetBuilder<NewsController>(
          builder: (controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.dimen_10),
                  bottomRight: Radius.circular(Sizes.dimen_10),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_18, vertical: Sizes.dimen_18),
              child: Column(
                children: [
                  controller.cName.isNotEmpty
                      ? Text(
                          "Country: ${controller.cName.value.toUpperCase()}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                  vertical15,
                  controller.category.isNotEmpty
                      ? Text(
                          "Category: ${controller.category.value.capitalizeFirst}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                  vertical15,
                  controller.channel.isNotEmpty
                      ? Text(
                          "Channel: ${controller.channel.value.capitalizeFirst}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                  vertical15
                ],
              ),
            );
          },
          init: NewsController(),
        ),
        ExpansionTile(
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          title: const Text("Select Country", textScaleFactor: 1.2),
          children: <Widget>[
            for (int i = 0; i < listOfCountry.length; i++)
              drawerDropDown(
                  onCalled: () {
                    newsController.country.value = listOfCountry[i]['code']!;
                    newsController.cName.value =
                        listOfCountry[i]['name']!.toUpperCase();
                    newsController.getAllNews();
                    newsController.getBreakingNews();
                  },
                  name: listOfCountry[i]['name']!.toUpperCase())
          ],
        ),
        ExpansionTile(
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          title: const Text(
            "Select Category",
            textScaleFactor: 1.2,
          ),
          children: <Widget>[
            for (int i = 0; i < listOfCategory.length; i++)
              drawerDropDown(
                  onCalled: () {
                    newsController.category.value = listOfCategory[i]['code']!;

                    newsController.getAllNews();
                  },
                  name: listOfCategory[i]['name']!.toUpperCase())
          ],
        ),
        ExpansionTile(
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          title: const Text(
            "Select Channel",
            textScaleFactor: 1.2,
          ),
          children: [
            for (int i = 0; i < listOfNewsChannel.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.channel.value = listOfNewsChannel[i]['code']!;
                  newsController.getAllNews(
                      channel: listOfNewsChannel[i]['code']);
                  newsController.cName.value = '';
                  newsController.category.value = '';
                  newsController.update();
                },
                name: listOfNewsChannel[i]['name']!.toUpperCase(),
              ),
          ],
        ),
        const Divider(),
        ListTile(
          trailing: const Icon(
            Icons.done_rounded,
            size: Sizes.dimen_28,
            color: AppColors.burgundy,
          ),
          title: const Text(
            "Done",
            textScaleFactor: 1.2,
            style:
                TextStyle(fontSize: Sizes.dimen_16, color: AppColors.burgundy),
          ),
          onTap: () => Get.back(),
        )
      ],
    ),
  );
}
