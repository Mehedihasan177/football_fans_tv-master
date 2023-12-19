import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/consts/app_sizes.dart';
import '/controllers/color_controller.dart';
import '/controllers/matchdetails_controller.dart';
import '/models/home_live_matches.dart';
import '/models/match_schedule.dart';
// import '/views/screens/registration_screen.dart';
import '/views/widgets/match_commentary.dart';
import '/views/widgets/match_stats.dart';
import '../../consts/app_colors.dart';
import '../../consts/textstyle.dart';
import '../../utils/widgets.dart';
import '../widgets/homepage_widgets.dart';
import '../widgets/match_lineup.dart';

class HomeMatchScreen extends StatefulWidget {
  final Matches match;
  const HomeMatchScreen(this.match, {Key? key}) : super(key: key);

  @override
  State<HomeMatchScreen> createState() => _HomeMatchScreenState();
}

class _HomeMatchScreenState extends State<HomeMatchScreen>
    with TickerProviderStateMixin {
  MatchDetailsController matchDetailsController =
      Get.put(MatchDetailsController());

  ColorController colorController = Get.find();
  TabController? _tabController;
  int index = 0;

  String type = "Statistics";
  @override
  void initState() {
    super.initState();
    matchDetailsController.loadStatistics(widget.match.matchId.toString());
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    _tabController = TabController(length: 3, vsync: this);

    _tabController!.addListener(
      () {
        setState(() {
          index = _tabController!.index;
        });

        if (index == 1 && type == 'Statistics') {
          matchDetailsController
              .loadStatistics(widget.match.matchId.toString());
        }
        if (index == 2 && type == 'Line-Up') {
          matchDetailsController.loadlineup(widget.match.matchId.toString());
        }
        if (index == 3 && type == 'Commentary') {
          matchDetailsController
              .loadCommentary(widget.match.matchId.toString());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor:
          //     !colorController.isLightTheme.value ? Colors.white : Colors.black,
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/images/BG.jpg"))),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 30,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 25,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Text('Match Details'.toUpperCase().tr,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: AppSizes.size16,
                                    color: Colors.white)))
                      ],
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipPath(
                            clipper: const CustomCornerClipPath(),
                            child: Container(
                              height: 110, //based on your need
                              width: 160,
                              color: AppColors.liveContainerColor,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: cachedNetworkImage(
                                                widget.match.image1,
                                                5,
                                                5,
                                                5,
                                                5,
                                                0),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: GlobalText(
                                                  widget.match.score!
                                                      .split('-')
                                                      .first
                                                      .trim(),
                                                  AppSizes.size20,
                                                  FontWeight.normal,
                                                  AppColors.white))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: GlobalText(
                                            widget.match.tName1,
                                            AppSizes.size16,
                                            FontWeight.normal,
                                            AppColors.white))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: ClipPath(
                                  clipper: const CustomCornerClipPath(),
                                  child: Container(
                                    height: 110, //based on your need

                                    width: 160,

                                    color: AppColors.liveContainerColor,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                child: Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: GlobalText(
                                        widget.match.score!
                                            .split('-')
                                            .last
                                            .trim(),
                                        AppSizes.size18,
                                        FontWeight.normal,
                                        AppColors.white)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 30, left: 10),
                                child: cachedNetworkImage(
                                    widget.match.image2, 5, 5, 5, 5, 0),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: GlobalText(
                                        widget.match.tName2,
                                        AppSizes.size16,
                                        FontWeight.normal,
                                        AppColors.white)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 80,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.red.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: GlobalText(
                              widget.match.sId.toString(),
                              AppSizes.size16,
                              FontWeight.normal,
                              AppColors.white),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.3,
                    bottom: TabBar(
                      isScrollable: true,

                      onTap: (v) {
                        if (v == 0) {}
                        if (v == 1) {
                          matchDetailsController
                              .loadStatistics(widget.match.matchId.toString());
                        }
                        if (v == 2) {
                          matchDetailsController
                              .loadlineup(widget.match.matchId.toString());
                        }
                        if (v == 3) {
                          matchDetailsController
                              .loadCommentary(widget.match.matchId.toString());
                        }
                      },
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
                          fontSize: AppSizes.size14),
                      // indicator: UnderlineTabIndicator(
                      //   borderSide: BorderSide(width: 2.0, color: Colors.blue),
                      // ),
                      indicator: const CustomTabIndicator(),
                      tabs: [
                        Tab(text: 'Statistics'.tr),
                        Tab(text: 'Line-Up'.tr),
                        Tab(text: 'Commentary'.tr),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      MatchStats2(widget.match),
                      const MatchLineUp(),
                      const MatchCommentary(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: const CustomBannerAd(),
        ),
      ),
    );
  }

  showbutton(String option) {
    return InkWell(
      onTap: () {
        if (option == "Line-Up") {
          matchDetailsController.loadlineup(widget.match.matchId.toString());
        }
        if (option == "Commentary") {
          matchDetailsController
              .loadCommentary(widget.match.matchId.toString());
        }
        // dd(widget.match.matchId.toString());
        setState(() {
          type = option;
          //    print(type);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        height: AppSizes.newSize(3),
        decoration: BoxDecoration(
          color: type == option ? AppColors.appColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          option.tr,
          style: TextStyle(
              fontSize: AppSizes.size14,
              fontWeight: FontWeight.w600,
              color: type == option ? Colors.white : Colors.grey.shade500),
        ),
      ),
    );
  }
}

matchdetailsscore(Live liveMatch) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                liveMatch.score.toString().split('-').first.trim(),
                textAlign: TextAlign.center,
                style: CustomtextStyle.playerofthematchSmallOne,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 15,
            height: 1,
            color: Colors.white,
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 40,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                liveMatch.score.toString().split('-').last.trim(),
                textAlign: TextAlign.center,
                style: CustomtextStyle.playerofthematchSmallOne,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        alignment: Alignment.center,
        width: 45,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: AppColors.appColor.withOpacity(.12),
            border:
                Border.all(width: 1, color: AppColors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          liveMatch.result.toString(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: AppSizes.size14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

matchdetailsscore2(Matches match) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                match.score == "LIVE"
                    ? "0"
                    : match.score.toString().split('-').first.trim(),
                textAlign: TextAlign.center,
                style: CustomtextStyle.playerofthematchSmallOne,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 15,
            height: 1,
            color: Colors.white,
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 40,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                match.score == "LIVE"
                    ? "0"
                    : match.score.toString().split('-').last.trim(),
                textAlign: TextAlign.center,
                style: CustomtextStyle.playerofthematchSmallOne,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        alignment: Alignment.center,
        width: 45,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: AppColors.appColor.withOpacity(.12),
            border:
                Border.all(width: 1, color: AppColors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          match.result.toString(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: AppSizes.size14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

customColumnLive(String image, String name, String type) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      cachedNetworkImageMaker(image, 5, 5, 5, 5, 5, 5),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.center,
        child: Text(
          name,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.grey,
              fontSize: AppSizes.size13,
              fontWeight: FontWeight.bold,
            ),
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.center,
        child: Text(
          type,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.grey,
              fontSize: AppSizes.size12,
              fontWeight: FontWeight.normal,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

class CustomTabIndicator extends Decoration {
  final double radius;

  final Color color;

  final double indicatorHeight;

  const CustomTabIndicator({
    this.radius = 8,
    this.indicatorHeight = 6,
    this.color = Colors.blue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      this,
      onChanged,
      radius,
      color,
      indicatorHeight,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Paint paint = Paint();
    double xAxisPos = offset.dx + configuration.size!.width / 2;
    double yAxisPos =
        offset.dy + configuration.size!.height - indicatorHeight / 2;
    paint.color = color;

    RRect fullRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: configuration.size!.width / 1,
        height: indicatorHeight / 1.5,
      ),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    canvas.drawRRect(fullRect, paint);
  }
}
