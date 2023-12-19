import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/consts/app_assets.dart';
import '/consts/textstyle.dart';
import '/models/home_details.dart';
import '/utils/dotted_line.dart';
import '/views/screens/news_details_screen.dart';
import 'package:get/get.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../models/newslist.dart';
import '../screens/news_details_webview.dart';

Widget newsblockleaguelarge(Topstore news) {
  //log(news.link ?? "");
  return InkWell(
    onTap: () {
      var arguments = {
        'newsTitle': news.title ?? '',
        'newsImage': news.image ?? '',
        'newsTime': news.publisher?.pubTime ?? '',
        'newsURL': news.link ?? '',
      };

      Get.to(() => NewsDetailsScreen(arguments));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.selective.withOpacity(0.2), width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.appColor,
                Colors.black,
              ],
            )),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: news.image ?? '',
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      )),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset(AppAssets.team),
                fit: BoxFit.fill,
                height: AppSizes.newSize(25),
                width: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 220,
                // width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.appColor.withOpacity(0.0),
                      AppColors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: GlobalText1(news.title, AppSizes.size15,
                          FontWeight.normal, Colors.white),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10, right: 10),
                  // child: Container(
                  //   height: 15,
                  //   width: 1.2,
                  //   color: Colors.grey,
                  // ),
                  // ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height: 15,
                                width: 1.2,
                                color: Colors.grey,
                              ),
                            ),
                            globalText2(
                                news.publisher?.pubName?.toString() ?? '',
                                AppSizes.size10,
                                FontWeight.normal,
                                Colors.white),
                          ],
                        )),
                  ),
                ],
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: 50,
                // width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.black,
                      AppColors.black,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

newsblockleaguelarge1(News news) {
  return InkWell(
    onTap: () {
      var arguments = {'webview': news.link};
      Get.to(() => NewsDetailsWebview(arguments));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.selective.withOpacity(0.2), width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.appColor,
                Colors.black,
              ],
            )),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    // bottomLeft: const Radius.circular(10),
                    // bottomRight: const Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: news.image
                            ?.replaceAll("w=64", "w=1280")
                            .replaceAll("h=64", "h=720") ??
                        '',
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          )),
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset(AppAssets.team),
                    fit: BoxFit.fill,
                    height: AppSizes.newSize(25),
                    width: double.infinity,
                  ),
                ),
                Container(
                  height: 60,
                  color: AppColors.league.withOpacity(0.4),
                )
              ],
            ),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: GlobalText1(news.title, AppSizes.size15,
                          FontWeight.normal, Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: AppSizes.newSize(3)),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height: AppSizes.newSize(3),
                                width: 1.2,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: globalText2(
                                  (news.source ?? "").trim(),
                                  AppSizes.size12,
                                  FontWeight.normal,
                                  Colors.white),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: 50,
                // width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      // bottomLeft: Radius.circular(10),
                      // bottomRight: Radius.circular(10)
                      ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.black,
                      AppColors.black,
                    ],
                  ),
                ),
              ),
            ),
            ...getPosition()
          ],
        ),
      ),
    ),
  );
}
