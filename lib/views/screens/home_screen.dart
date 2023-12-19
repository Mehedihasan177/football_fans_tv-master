import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '/consts/app_colors.dart';
import '/consts/app_sizes.dart';
import '/views/screens/parent_screen.dart';
import 'package:get/get.dart';

import '../../controllers/color_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/news_controller.dart';
import '../../controllers/setting _controller.dart';
import '../../utils/shimmers.dart';
import '../widgets/homepage_widgets.dart';
import '../widgets/news_widgets.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  ColorController colorController = Get.put(ColorController());
  HomeController homeController = Get.find();
  CarouselController carouselController = CarouselController();
  ScrollController scrollController = ScrollController();
  NewsController newsController = Get.put(NewsController());
  SettingController settingController = Get.find();
  int newscount = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.loadhomedetails();
      homeController.loadhomelive();
      newsController.loadNews();
    });
  }

  Future<void> refresh() async {
    homeController.isloadinghome.value = true;
    homeController.loadhomedetails();
    homeController.loadhomelive();
    newsController.loadNews();
    newscount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refresh(),
      child: Container(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Container(
                  width: double.infinity,
                  height: AppSizes.newSize(15),
                  decoration: BoxDecoration(
                    //color: AppColors.league.withOpacity(0.45),

                    border: Border.all(
                      color: AppColors.selective.withOpacity(0.2),
                      width: 0.5,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.containerBorder.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, bottom: 3),
                        child: Text(
                          'TOP LEAGUES'.tr,
                          style: TextStyle(
                              letterSpacing: 0.5,
                              color: Colors.white.withOpacity(0.9),
                              fontSize: AppSizes.size17,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Expanded(
                        child: Obx(() => !homeController.isloadinghome.value
                            ? (homeController
                                            .homeDetails.value.league?.length ??
                                        0) >
                                    0
                                ? Container(
                                    alignment: Alignment.center,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(left: 15),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.homeDetails
                                              .value.league?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        var league = homeController
                                            .homeDetails.value.league![index];
                                        return topLeagues(league);
                                      },
                                    ),
                                  )
                                : const SizedBox()
                            : matchShimmer21()),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 20),
                child: Container(
                  height: AppSizes.newSize(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.league.withOpacity(0.45),
                    border: Border.all(
                        color: AppColors.selective.withOpacity(0.2),
                        width: 0.5),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.containerBorder.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 20, bottom: 3),
                        child: Text(
                          'TOP TEAMS'.tr,
                          style: TextStyle(
                              letterSpacing: 0.5,
                              color: Colors.white.withOpacity(0.9),
                              fontSize: AppSizes.size17,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Expanded(
                        child: Obx(() => !homeController.isloadinghome.value
                            ? (homeController
                                            .homeDetails.value.league?.length ??
                                        0) >
                                    0
                                ? ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController
                                            .homeDetails.value.team?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      var team = homeController
                                          .homeDetails.value.team![index];
                                      return topTeams(team);
                                    })
                                : const SizedBox()
                            : matchShimmer2()),
                      ),
                    ],
                  ),
                ),
              ),
              if (settingController.appPublishingControl.value)
                Obx(
                  () => !homeController.isloadinglive.value
                      ? (homeController.livematches.value.data?.length ?? 0) > 0
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'LIVE MATCHES'.tr,
                                        style: TextStyle(
                                            letterSpacing: 0.5,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: AppSizes.size17,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: InkWell(
                                          onTap: () {
                                            Get.offAll(
                                                () => const ParentScreen(0));
                                          },
                                          child: Text(
                                            'View All'.tr,
                                            style: TextStyle(
                                                letterSpacing: 0.5,
                                                color: Colors.white
                                                    .withOpacity(0.75),
                                                fontSize: AppSizes.size15,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Stack(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 7),
                                        decoration: BoxDecoration(
                                            // color: AppColors.league
                                            //     .withOpacity(0.45),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: CarouselSlider(
                                          carouselController:
                                              carouselController,
                                          items: [
                                            ...homeController
                                                .livematches.value.data!
                                                .map((e) => matchLiveStream(e)),
                                          ],
                                          options: CarouselOptions(
                                            height: AppSizes.newSize(22),
                                            aspectRatio: 16 / 9,
                                            enlargeCenterPage: false,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                const Duration(seconds: 10),
                                            viewportFraction: 1,
                                            onPageChanged: (index, reason) {
                                              homeController.leagueAndTeamIndex
                                                  .value = index;
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Obx(() {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: homeController
                                                .livematches.value.data!
                                                .take(30)
                                                .toList()
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              return GestureDetector(
                                                onTap: () => carouselController
                                                    .animateToPage(entry.key),
                                                child: Container(
                                                  width: 4.0,
                                                  height: 4.0,
                                                  margin: const EdgeInsets.only(
                                                      top: 4.0, right: 5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: homeController
                                                                .leagueAndTeamIndex
                                                                .value ==
                                                            entry.key
                                                        ? AppColors
                                                            .bottomNavBlueColor
                                                        : AppColors
                                                            .bottomNavBlueColor
                                                            .withOpacity(0.5),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            )
                          : const SizedBox()
                      : const SizedBox(),
                ),
              Obx(() {
                return !newsController.isLoading.value
                    ? (newsController.news.value.news?.length ?? 0) > 0
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 10, bottom: 10),
                                child: Text(
                                  'TRENDING NEWS'.tr,
                                  style: TextStyle(
                                      letterSpacing: 0.5,
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: AppSizes.size17,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Container(
                                  padding:
                                      const EdgeInsets.only(bottom: 4, top: 4),
                                  child: Divider(
                                    height: .3,
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                ),
                                itemCount: min(
                                    newsController.news.value.news?.length ?? 0,
                                    10),
                                itemBuilder: (context, index) {
                                  return newsblockleaguelarge1(
                                      newsController.news.value.news![index]);
                                },
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(bottom: 15),
                                child: InkWell(
                                  onTap: () {
                                    Get.offAll(() => const ParentScreen(3));
                                  },
                                  child: Text(
                                    'More News'.tr,
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        color: Colors.white.withOpacity(0.75),
                                        fontSize: AppSizes.size15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          shimmerheader(),
                          const SizedBox(height: 10),
                          newsContainer(),
                          const SizedBox(height: 10),
                          newsContainer(),
                        ],
                      );
              }),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
