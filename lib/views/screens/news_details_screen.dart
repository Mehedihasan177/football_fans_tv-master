// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/consts/app_colors.dart';

import 'package:get/get.dart';

import 'package:marquee/marquee.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/news_controller.dart';
import '../../controllers/setting _controller.dart';

class NewsDetailsScreen extends StatefulWidget {
  final arguments;
  const NewsDetailsScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  NewsController newsController = Get.find<NewsController>();
  SettingController settingsController = Get.find<SettingController>();

  @override
  void initState() {
    super.initState();
    newsController.loadhomenewsdetail(widget.arguments['newsURL']);
  }

  @override
  void dispose() {
    super.dispose();

    newsController.isLoading2.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: widget.arguments['newsTitle'].length > 25
            ? SizedBox(
                height: 30,
                child: Marquee(
                  text: widget.arguments['newsTitle'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.size14,
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              )
            : Text(widget.arguments['newsTitle']),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColors.appColor,
      body: Obx(() {
        return !newsController.isLoading2.value
            ? Container(
                decoration: BoxDecoration(
                  color: AppColors.league.withOpacity(0.5),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.transparent.withOpacity(0.9), BlendMode.dstATop),
                    image: const AssetImage(AppAssets.backgroundImage),
                    fit: BoxFit.fill,
                  ),
                ),
                margin: const EdgeInsets.all(4),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            newsController.homenewsdetail.value.header?.image ??
                                widget.arguments['newsImage'],
                        height: 25 * screenSize / 100,
                        width: double.infinity,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 25 * screenSize / 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[300],
                            ),
                            child: Image.asset(AppAssets.team),
                          );
                        },
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: double.infinity,
                          child: SizedBox(
                            height: 4 * screenSize / 100,
                            width: 4 * screenSize / 100,
                            child: Image.asset(AppAssets.mloader),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        child: Text(
                          widget.arguments['newsTitle'],
                          style: TextStyle(
                            fontSize: AppSizes.size14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        child: Text(
                          widget.arguments['newsTime'],
                          style: TextStyle(
                            fontSize: AppSizes.size13,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      (newsController.homenewsdetail.value.body?.length ?? 0) >
                              0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: newsController
                                      .homenewsdetail.value.body?.length ??
                                  0,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  child: Text(
                                    newsController.homenewsdetail.value
                                            .body![index].p ??
                                        '',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppSizes.size13,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: AppSizes.newSize(15),
                              child: Center(
                                child: Text(
                                  "No Details Found".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppSizes.size13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              )
            : Center(
                child: Container(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                      color: AppColors.bottomNavBlueColor),
                ),
              );
      }),
    );
  }
}
