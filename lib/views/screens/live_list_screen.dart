import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:football_fans_tv/controllers/setting%20_controller.dart';
import 'package:football_fans_tv/services/ads_service.dart';
import '/consts/app_colors.dart';
import '/controllers/league_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../controllers/hightlight_controller.dart' as highlight;
import '../../controllers/home_controller.dart';

import '../../models/highlight_model.dart';
import '../../models/live_matches.dart';
import '../../utils/shimmers.dart';
import '../../utils/widgets.dart';
import '../widgets/highlight_widget.dart';
import '../widgets/homepage_widgets.dart';
import 'live_match_preview.dart';
import 'live_match_streaming_screen.dart';
import 'news_screen.dart';

class LiveListScreen extends StatefulWidget {
  const LiveListScreen({Key? key}) : super(key: key);

  @override
  State<LiveListScreen> createState() => _LiveListScreenState();
}

class _LiveListScreenState extends State<LiveListScreen>
    with TickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());
  ColorController colorController = Get.find();

  LeagueController leagueController = Get.put(LeagueController());
  highlight.HighlightController highlightController = Get.find();
  TabController? _tabController;
  int index = 0;

  SettingController settingController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      highlightController.loadHighlight();
      homeController.loadhomeMatches();
      homeController.loadhomelive();
      homeController.loadLeagues();
      homeController.loadcompletedmatches();
    });
    _tabController = TabController(
      length: settingController.appPublishingControl.value ? 4 : 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: DefaultTabController(
          length: 4,
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: AppSizes.newSize(5),
                  width: double.infinity,
                  child: TabBar(
                    physics: const NeverScrollableScrollPhysics(),
                    isScrollable: settingController.appPublishingControl.value,
                    controller: _tabController,
                    labelColor: Theme.of(Get.context!)
                        .textSelectionTheme
                        .selectionColor,
                    unselectedLabelColor: Theme.of(Get.context!)
                        .textSelectionTheme
                        .selectionColor,
                    indicatorColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Theme.of(Get.context!)
                          .textSelectionTheme
                          .selectionColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSizes.size14,
                    ),
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0, color: Colors.blue),
                    ),
                    tabs: [
                      if (settingController.appPublishingControl.value) ...[
                        Tab(text: 'WATCH LIVE'.tr),
                        Tab(text: 'HIGHLIGHTS'.tr),
                      ],
                      Tab(text: 'LIVE MATCH'.tr),
                      Tab(text: 'FULL TIME'.tr),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      if (settingController.appPublishingControl.value) ...[
                        ////////////watch live///////////
                        RefreshIndicator(
                            onRefresh: () => homeController.loadhomelive(),
                            child: Obx(
                              () => !homeController.isloadinglive.value
                                  ? homeController
                                          .livematches.value.data!.isNotEmpty
                                      ? Container(
                                          color: Colors.transparent,
                                          child: Scaffold(
                                            backgroundColor: Colors.transparent,
                                            body: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 3)
                                                      .copyWith(top: 8),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 8,
                                                    child: ListView.separated(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            homeController
                                                                .livematches
                                                                .value
                                                                .data!
                                                                .length,
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                const SizedBox(
                                                                    height: 10),
                                                        itemBuilder:
                                                            (context, index) {
                                                          Data livedata =
                                                              homeController
                                                                  .livematches
                                                                  .value
                                                                  .data![index];
                                                          final randomBoolean =
                                                              Random()
                                                                  .nextBool();
                                                          return Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if (index % 3 ==
                                                                      0 &&
                                                                  index > 0)
                                                                AdMaker(
                                                                    randomBoolean),
                                                              matchwidget(
                                                                  livedata),
                                                            ],
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'No Live Matches Available'.tr,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: AppSizes.size16,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            reload(() =>
                                                homeController.loadhomelive())
                                          ],
                                        ))
                                  : matchShimmer(),
                            )),
                        /////////highLights/////////////
                        RefreshIndicator(
                            onRefresh: () =>
                                highlightController.loadHighlight(),
                            child: Obx(
                              () => !highlightController.isLoading.value
                                  ? Container(
                                      color: Colors.transparent,
                                      child: Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Container(
                                          padding: const EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 3)
                                              .copyWith(top: 8),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: highlightController
                                                        .highlight
                                                        .value
                                                        .highlight!
                                                        .isNotEmpty
                                                    ? ListView.separated(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            highlightController
                                                                .highlight
                                                                .value
                                                                .highlight!
                                                                .length,
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                const SizedBox(
                                                                    height: 10),
                                                        itemBuilder:
                                                            (context, index) {
                                                          HighLight
                                                              highLightData =
                                                              highlightController
                                                                      .highlight
                                                                      .value
                                                                      .highlight![
                                                                  index];

                                                          return hightLightWidget(
                                                              highLightData);
                                                        })
                                                    : Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'No HighLight Available'
                                                                  .tr,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      AppSizes
                                                                          .size16),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            reload(() =>
                                                                highlightController
                                                                    .loadHighlight()),
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : highlightShimmer(),
                            )),
                      ], ///////live match////////
                      RefreshIndicator(
                        onRefresh: () => homeController.loadcompletedmatches(),
                        child: Obx(() => !homeController.isloadingmatches.value
                            ? (homeController.completedMatches.value.live
                                            ?.length ??
                                        0) >
                                    0
                                ? Container(
                                    padding: const EdgeInsets.only(top: 8),
                                    color: Colors.transparent,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: homeController
                                                .completedMatches
                                                .value
                                                .live
                                                ?.length ??
                                            0,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 0),
                                        itemBuilder: (context, index) {
                                          var live = homeController
                                              .completedMatches
                                              .value
                                              .live![index];

                                          return livematchWidget(live, true);
                                        }),
                                  )
                                : Center(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('No Live Matches Available'.tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: AppSizes.size16)),
                                      const SizedBox(height: 10),
                                      reload(() {
                                        homeController.isloadingmatches.value =
                                            true;
                                        homeController.loadcompletedmatches();
                                      })
                                    ],
                                  ))
                            : Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: AppColors.bottomNavBlueColor,
                                  color: Colors.white,
                                ),
                              )),
                      ),
                      //////////// full time//////
                      RefreshIndicator(
                        onRefresh: () => homeController.loadcompletedmatches(),
                        child: Obx(() => !homeController.isloadingmatches.value
                            ? (homeController.completedMatches.value.ft
                                            ?.length ??
                                        0) >
                                    0
                                ? Container(
                                    padding: const EdgeInsets.only(top: 8),
                                    color: Colors.transparent,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: homeController
                                                .completedMatches
                                                .value
                                                .ft
                                                ?.length ??
                                            0,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 0),
                                        itemBuilder: (context, index) {
                                          var completed = homeController
                                              .completedMatches
                                              .value
                                              .ft![index];

                                          return livematchWidget(
                                              completed, false);
                                        }),
                                  )
                                : Center(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('No Completed Matches Available'.tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: AppSizes.size16)),
                                      const SizedBox(height: 10),
                                      reload(() {
                                        homeController.isloadingmatches.value =
                                            true;
                                        homeController.loadcompletedmatches();
                                      })
                                    ],
                                  ))
                            : Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: AppColors.bottomNavBlueColor,
                                  color: Colors.white,
                                ),
                              )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

matchwidget(Data livedata) {
  //RegistrationController registrationController = Get.find();
  return InkWell(
    onTap: () {
      AdsService.showInterstitialAd(() {
        timeDiff(livedata.matchTime!) < 15
            ? Get.to(() => LiveMatchStreamingScreen(livedata))
            : Get.to(() => LiveMatchPreview(livedata));
      });
    },
    child: Container(
      padding: const EdgeInsets.only(top: 0, bottom: 10, left: 5, right: 5),
      // width: AppSizes.newSize(40),

      decoration: BoxDecoration(
          color: AppColors.league.withOpacity(0.45),
          border: Border.all(color: AppColors.white.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: Alignment.centerRight,
              image: AssetImage('assets/images/BG.jpg'))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.only(top: 3, right: 0, bottom: 10),
            alignment: Alignment.center,
            child: Center(
              child: Text(
                livedata.matchTitle.toString().toUpperCase(),
                style: TextStyle(
                    fontSize: AppSizes.size18,
                    color: Colors.white.withOpacity(0.75)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 10,
                    child: customRowTeamOne(livedata.teamOneImage.toString(),
                        livedata.teamOneName.toString())),
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: const EdgeInsets.only(top: 13, right: 9),
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          '',
                          style: TextStyle(
                              fontSize: AppSizes.size18,
                              color: Colors.white.withOpacity(0.75)),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                Expanded(
                    flex: 10,
                    child: customRowTeamTwo(livedata.teamTwoImage.toString(),
                        livedata.teamTwoName.toString())),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (timeDiff(livedata.matchTime!) < 15)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                AppAssets.watchlive,
                height: 30,
              ),
            )
          else
            CountdownTimer(
              widgetBuilder: (context, time) {
                if (time == null) {
                  return Text(
                    '',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizes.size13,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Match Will Start'.tr,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: AppSizes.size13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${time.days ?? '0'}d : ${time.hours ?? '0'}h : ${time.min ?? '0'}m : ${time.sec}s',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.size15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              endTime: int.parse(livedata.matchTime ?? '') * 1000,
              textStyle: TextStyle(
                  fontSize: AppSizes.size13,
                  color: Theme.of(Get.context!).textTheme.headline4!.color),
            ),
        ],
      ),
    ),
  );
}

customRowTeamOne(String image, String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.center,
          child: Text(name,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: AppSizes.size13,
                fontWeight: FontWeight.normal,
              )),
        ),
      ),
      const SizedBox(width: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 5 * screenSize / 100,
          width: 5 * screenSize / 100,
          errorWidget: (context, url, error) {
            return Image.asset(AppAssets.team);
          },
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: SizedBox(
              height: 2 * screenSize / 100,
              width: 2 * screenSize / 100,
              child: Image.asset(
                AppAssets.mloader,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

customRowTeamTwo(String image, String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 5 * screenSize / 100,
          width: 5 * screenSize / 100,
          errorWidget: (context, url, error) {
            return Image.asset(AppAssets.team);
          },
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: SizedBox(
              height: 2 * screenSize / 100,
              width: 2 * screenSize / 100,
              child: Image.asset(AppAssets.mloader),
            ),
          ),
        ),
      ),
      const SizedBox(width: 6),
      Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: AppSizes.size13,
                fontWeight: FontWeight.normal,
              ),
            ),
          )),
    ],
  );
}

customColumnTeamOne(String image, String name) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.center,
        width: AppSizes.newSize(9),
        child: Text(name,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: AppSizes.size16,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
      const SizedBox(width: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 5 * screenSize / 100,
          width: 5 * screenSize / 100,
          errorWidget: (context, url, error) {
            return Image.asset(AppAssets.team);
          },
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: SizedBox(
              height: 2 * screenSize / 100,
              width: 2 * screenSize / 100,
              child: Image.asset(
                AppAssets.mloader,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

customColumnTeamTwo(String image, String name) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 8 * screenSize / 100,
          width: 8 * screenSize / 100,
          errorWidget: (context, url, error) {
            return Image.asset(AppAssets.team);
          },
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: SizedBox(
              height: 2 * screenSize / 100,
              width: 2 * screenSize / 100,
              child: Image.asset(AppAssets.mloader),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Container(
        alignment: Alignment.center,
        width: AppSizes.newSize(12),
        child: Text(
          name.toUpperCase(),
          maxLines: 2,
          textAlign: TextAlign.center,
          style: GoogleFonts.barlow(
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: AppSizes.size14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    ],
  );
}

reload(VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white,
          width: 0.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        // ignore: unnecessary_const
        child: Text(
          "Try Again".tr,
          style: const TextStyle(
            color: Colors.green,
          ),
        ),
      ),
    ),
  );
}
