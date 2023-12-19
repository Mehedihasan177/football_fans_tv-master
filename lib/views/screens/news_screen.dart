// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '/controllers/promotion_controller.dart';
import '/controllers/setting%20_controller.dart';
import '/models/promotion.dart';
import '/utils/widgets.dart';
import '/views/screens/live_list_screen.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../controllers/news_controller.dart';
import '../../models/newslist.dart';
import '../../utils/shimmers.dart';
import '../widgets/news_widgets.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  NewsController newsController = Get.find();
  ColorController colorController = Get.find();

  SettingController settingController = Get.find();

  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 8,
        child: Container(
          color: Colors.transparent,
          height: double.infinity,
          child: Obx(
            () => !newsController.isLoading.value
                ? (newsController.news.value.news?.length ?? 0) > 0
                    ? Container(
                        // color: AppColors.newsBackground,
                        height: Get.height,
                        margin: const EdgeInsets.only(top: 0),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            newsController.loadNews();
                          },
                          child: OrientationBuilder(
                            builder: (context, orientation) {
                              Map<dynamic, List<News>> groupGames = groupBy(
                                  newsController.news.value.news!,
                                  (News obj) => obj.time);
                              groupGames.forEach((key, value) {
                                //  dd(key.toString().split(' ').first.toString());
                              });
                              //  dd(groupGames.toString());

                              return ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 4, top: 4),
                                        child: Divider(
                                          height: .3,
                                          color: Colors.white.withOpacity(0.4),
                                        ),
                                      ),
                                  itemCount:
                                      newsController.news.value.news?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    final randomBoolean = Random().nextBool();
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (index % 3 == 0 && index > 0)
                                          AdMaker(randomBoolean),
                                        newsblockleaguelarge1(newsController
                                            .news.value.news![index]),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No News found'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.size16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          reload(() => newsController.loadNews())
                        ],
                      ))
                : newsShimmer(),
          ),
        ),
      ),
    );
  }
}

class AdMaker extends StatefulWidget {
  const AdMaker(this.randomBoolean, {Key? key}) : super(key: key);
  final bool randomBoolean;

  @override
  State<AdMaker> createState() => _AdMakerState();
}

class _AdMakerState extends State<AdMaker> {
  late VideoPlayerController _controller;

  PromotionController promotionController = Get.find();

  PromotionData promotion = PromotionData();
  @override
  void initState() {
    super.initState();

    promotion = promotionController.promotion;

    if (promotion.promotionType == 'video') {
      _controller = VideoPlayerController.network(
        promotion.video!,
        httpHeaders: {},
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false,
        ),
      )..initialize().then((_) {
          setState(() {});
        });

      _controller.play();
      _controller.setLooping(true);
      _controller.setVolume(0);
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (promotion.promotionType == 'video') {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchURL(promotion.actionUrl);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 9),
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.selective.withOpacity(0.2), width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     AppColors.appColor,
          //     Colors.black,
          //   ],
          // ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              return Stack(
                children: [
                  promotion.promotionType == 'video'
                      ? VisibilityDetector(
                          key: const Key('my-widget-key'),
                          onVisibilityChanged: (visibilityInfo) {
                            var visiblePercentage =
                                visibilityInfo.visibleFraction * 100;

                            if (visiblePercentage < 50) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          },
                          child: InkWell(
                            onTap: () {
                              _controller.play();
                            },
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: Stack(
                                children: [
                                  // ignore: unnecessary_null_comparison
                                  if (_controller != null)
                                    VideoPlayer(
                                      _controller,
                                    ),
                                  Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Row(
                                        children: [
                                          Builder(builder: (context) {
                                            //   dev.log('${_controller.value.volume}s');
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _controller.value.volume ==
                                                          1.0
                                                      ? _controller.setVolume(0)
                                                      : _controller
                                                          .setVolume(100);
                                                });
                                              },
                                              child: Icon(
                                                _controller.value.volume == 1.00
                                                    ? Icons.volume_up_outlined
                                                    : Icons.volume_off,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            );
                                          }),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: promotion.image!,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                          placeholder: (context, url) => const SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.yellow,
                      ),
                      child: Text(
                        " Ads",
                        style: TextStyle(
                          fontSize: AppSizes.size13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(.75),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0)
                    .copyWith(bottom: 8, top: 6),
                child: Text(
                  promotion.description!,
                  style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: AppSizes.size14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
