import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football_fans_tv/services/ads_service.dart';
import '/models/completed_matches.dart';
import '/models/live_matches.dart';
import '/views/screens/live_match_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../screens/live_match_preview.dart';
import '/consts/app_colors.dart';
import '/consts/textstyle.dart';
import '/models/home_details.dart';
import '/models/home_live_matches.dart';
import '/models/match_schedule.dart' as sch;
import '../../consts/app_assets.dart';
import '../../consts/app_sizes.dart';
import '../../utils/widgets.dart';
import '../screens/home_match_screen.dart';
import '../screens/league_screen.dart';
import '../screens/live_match_streaming_screen.dart';
import '../screens/team_screen.dart';

topLeagues(League league) {
  return InkWell(
    onTap: () {
      var arguments = {
        'fixtures': league.fixtures,
        'table': league.table,
        'teams': league.teams,
        'stats': league.stats,
        'transfers': league.transfers,
        'name': league.name,
        'image': league.image
      };

      AdsService.showInterstitialAd(() {
        Get.to(() => LeagueScreen(arguments));
      });
    },
    child: Container(
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: AppSizes.newSize(6.2),
              width: AppSizes.newSize(6.2),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.selective.withOpacity(0.2),
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: AppColors.selective.withOpacity(0.2),
                    offset: const Offset(-2.0, -2.0),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColors.selective.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: cachedNetworkImageMakerTwo(league.image),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

topTeams(Team team) {
  return InkWell(
    onTap: () {
      var arguments = {
        'fixtures': team.fixtures,
        'squad': team.squad,
        'stats': team.stats,
        'transfers': team.transfers,
        'name': team.name,
        'image': team.image
      };

      AdsService.showInterstitialAd(() {
        Get.to(() => TeamScreen(arguments));
      });
    },
    child: Padding(
      padding: const EdgeInsets.only(
        right: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // height: AppSizes.newSize(6),
            // width: AppSizes.newSize(6),
            decoration: BoxDecoration(
                color: AppColors.appColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.selective.withOpacity(0.1),
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: AppColors.selective.withOpacity(0.1),
                    offset: const Offset(-2.0, -2.0),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: AppColors.selective.withOpacity(0.2), width: 0.5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: cachedNetworkImageMakerTwo(team.image),
            ),
          ),
        ],
      ),
    ),
  );
}

livematchWidget(Ft liveMatch, bool bool) {
  return InkWell(
    onTap: () {
      AdsService.showInterstitialAd(() {
        Get.to(() => LiveMatchDetails(liveMatch, bool));
      });
    },
    child: Stack(
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
                  height: AppSizes.newSize(12),
                  width: AppSizes.newSize(20),
                  color: AppColors.league.withOpacity(0.45),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: cachedNetworkImage(
                                    liveMatch.t1image, 5, 5, 5, 5, 0),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: liveMatch.score != 'v'
                                      ? GlobalText(
                                          liveMatch.score!
                                              .split('-')
                                              .first
                                              .trim(),
                                          AppSizes.size20,
                                          FontWeight.normal,
                                          AppColors.white)
                                      : const SizedBox())
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: SizedBox(
                                width: AppSizes.newSize(15),
                                child: GlobalText(
                                    liveMatch.t1name.toString(),
                                    AppSizes.size14,
                                    FontWeight.normal,
                                    AppColors.white)))
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
                        height: AppSizes.newSize(12),
                        width: AppSizes.newSize(20),
                        color: AppColors.league.withOpacity(0.45),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: liveMatch.score != 'v'
                            ? GlobalText(
                                liveMatch.score!.split('-').last.trim(),
                                AppSizes.size18,
                                FontWeight.normal,
                                AppColors.white)
                            : const SizedBox()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 10),
                    child: cachedNetworkImage(liveMatch.t2image, 5, 5, 5, 5, 0),
                  ),
                  Positioned(
                    bottom: 20,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                            width: AppSizes.newSize(15),
                            child: GlobalText(
                                liveMatch.t2name.toString(),
                                AppSizes.size14,
                                FontWeight.normal,
                                AppColors.white))),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 75,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: bool
                  ? GlobalText("LIVE", AppSizes.size16, FontWeight.normal,
                      Colors.red.withOpacity(0.75))
                  : GlobalText("FT", AppSizes.size16, FontWeight.normal,
                      AppColors.white),
            ),
          ),
        )
      ],
    ),
  );
}

class CustomCornerClipPath extends CustomClipper<Path> {
  final double cornerR;
  const CustomCornerClipPath({this.cornerR = 20.0});

  @override
  Path getClip(Size size) => Path()
    ..lineTo(size.width, 0)
    ..lineTo(
      size.width * 1.19,
      size.height - cornerR,
    )
    ..arcToPoint(
      Offset(
        size.width - cornerR,
        size.height * 1.09,
      ),
      radius: Radius.circular(cornerR),
      clockwise: false,
    )
    ..lineTo(0, size.height);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

customRow(String image1, String image2, String name1, String name2,
    String type1, String type2, String score1, String score2) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cachedNetworkImageMakerThree(image1),
          cachedNetworkImageMakerThree(image2),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.centerLeft,
              width: 70,
              child: Text(
                name1,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.size13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Expanded(
            flex: 1,
            child: Text(
              score1.split('-').first.trim(),
              textAlign: TextAlign.end,
              style: CustomtextStyle.playerofthematchSmallOne,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.centerLeft,
              width: 70,
              child: Text(
                name2,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.size13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Text(
            score2.split('-').last.trim(),
            textAlign: TextAlign.end,
            style: CustomtextStyle.playerofthematchSmallOne,
          ),
        ],
      ),
    ],
  );
}

customColumn(String image, String name, String type) {
  return Column(
    children: [
      // cachedNetworkImageMaker(image),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.center,
        child: Text(
          name,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: AppSizes.size13,
              fontWeight: FontWeight.bold,
            ),
          ),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.bottomCenter,
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

scoreWidget(Live liveMatch) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            liveMatch.score.toString(),
            style: CustomtextStyle.scoretext,
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
            border: Border.all(width: 2, color: AppColors.appColor),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          liveMatch.result.toString(),
          style: TextStyle(
            color: Colors.white,
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

matchLiveStream(Data e) {
  return InkWell(
    onTap: () {
      AdsService.showInterstitialAd(() {
        timeDiff(e.matchTime!) < 15
            ? Get.to(() => LiveMatchStreamingScreen(e))
            : Get.to(() => LiveMatchPreview(e));
      });
    },
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: AppColors.selective.withOpacity(0.2), width: 0.5)
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.2),
          //     spreadRadius: 1,
          //     blurRadius: 2,
          //     offset: const Offset(0, 2), // changes position of shadow
          //   ),
          // ],
          ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5)
          .copyWith(bottom: 5),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customTextTwo(e.matchTitle.toString().toUpperCase(), AppSizes.size12,
              FontWeight.normal, Colors.white),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: e.teamOneImage.toString(),
                      height: AppSizes.newSize(5.5),
                      width: AppSizes.newSize(5.5),
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAssets.team);
                      },
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        child: SizedBox(
                          height: AppSizes.newSize(2),
                          width: AppSizes.newSize(2),
                          child: Image.asset(
                            AppAssets.mloader,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    customTextTwo(e.teamOneName.toString().toUpperCase(),
                        AppSizes.size13, FontWeight.normal, Colors.white)
                  ],
                ),
              ),
              // Expanded(
              //     flex: 2,
              //     child: Column(
              //       children: [
              //         customTextTwo(e.matchTitle.toString(), AppSizes.size12,
              //             FontWeight.normal, Colors.white),
              //       ],
              //     )),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: e.teamTwoImage.toString(),
                      height: AppSizes.newSize(5.5),
                      width: AppSizes.newSize(5.5),
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAssets.team);
                      },
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        child: SizedBox(
                          height: AppSizes.newSize(2),
                          width: AppSizes.newSize(2),
                          child: Image.asset(
                            AppAssets.mloader,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    customTextTwo(e.teamTwoName.toString().toUpperCase(),
                        AppSizes.size13, FontWeight.normal, Colors.white)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Image.asset(
              "assets/images/watch-live.png",
              height: 30,
            ),
          )
        ],
      ),
    ),
  );
}

matches(sch.Matches match) {
  // log(jsonEncode(match.mtime));
  // log(jsonEncode(match.result));
  return InkWell(
    onTap: () {
      match.result == "LIVE" || match.result == "FT"
          ? Get.to(HomeMatchScreen(match))
          : null;
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: const CustomCornerClipPath(),
                      child: Container(
                        height: 110,
                        color: AppColors.league.withOpacity(0.45),
                      ),
                    ),
                    SizedBox(
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 30),
                                    child: cachedNetworkImage(
                                        match.image1, 5, 5, 5, 5, 0),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: match.score == 'v'
                                          ? const Text("")
                                          : GlobalText(
                                              match.score!
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
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: AppSizes.newSize(15),
                                child: GlobalText(
                                    match.tName1.toString().toUpperCase(),
                                    AppSizes.size16,
                                    FontWeight.normal,
                                    AppColors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: ClipPath(
                        clipper: const CustomCornerClipPath(),
                        child: Container(
                          height: 110,
                          color: AppColors.league.withOpacity(0.45),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 30),
                                    child: cachedNetworkImage(
                                        match.image2, 5, 5, 5, 5, 0),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: match.score == 'v'
                                          ? const Text("")
                                          : GlobalText(
                                              match.score!
                                                  .split('-')
                                                  .last
                                                  .trim(),
                                              AppSizes.size20,
                                              FontWeight.normal,
                                              AppColors.white))
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                    width: AppSizes.newSize(15),
                                    child: GlobalText(
                                        match.tName2.toString().toUpperCase(),
                                        AppSizes.size16,
                                        FontWeight.normal,
                                        AppColors.white)))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                color: AppColors.league.withOpacity(0.45),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: match.result == "LIVE"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(4, 3, 4, 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              match.result ?? '',
                              style: TextStyle(
                                fontSize: AppSizes.size16,
                                color: match.result != 'LIVE'
                                    ? Colors.white
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: match.mtime == ""
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text(
                                //   match.score ?? '',
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: AppSizes.size14,
                                //     color: AppColors.white,
                                //   ),
                                // ),
                                Text(
                                  match.result ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppSizes.size17,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('h:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(match.mtime ?? '') * 1000,
                                    ),
                                  ),
                                  // /item.mtime,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppSizes.size12,
                                    color: AppColors.white,
                                  ),
                                ),
                                // Text(
                                //   DateFormat('d MMMM').format(
                                //     DateTime.fromMillisecondsSinceEpoch(
                                //       int.parse(match.mtime ?? '') * 1000,
                                //     ),
                                //   ),
                                //   // /item.mtime,
                                //   style: TextStyle(
                                //     fontSize: AppSizes.size12,
                                //     color: AppColors.white,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                    ),
            ),
          ),
        )
      ],
    ),
  );
}
// matches(sch.Matches match) {
//   // log(jsonEncode(match.mtime));
//   // log(jsonEncode(match.result));
//   return InkWell(
//     onTap: () {
//       match.result == "LIVE" || match.result == "FT"
//           ? Get.to(HomeMatchScreen(match))
//           : null;
//     },
//     child: Container(
//       decoration: BoxDecoration(
//         color: AppColors.appColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 2,
//             offset: const Offset(0, 2), // changes position of shadow
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           Expanded(
//               flex: 3,
//               child: customTextTwo(match.tName1.toString(), AppSizes.size12,
//                   FontWeight.normal, Colors.white)),
//           Expanded(
//               flex: 1,
//               child: cachedNetworkImageMakerFour(match.image1.toString())),
// Expanded(
//   flex: 2,
//   child: match.result == "LIVE"
//       ? Column(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               child: Container(
//                   padding: const EdgeInsets.fromLTRB(4, 3, 4, 3),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4)),
//                   child: Text(
//                     match.result ?? '',
//                     style: TextStyle(
//                       fontSize: AppSizes.size12,
//                       color: match.result != 'LIVE'
//                           ? Colors.white
//                           : Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )),
//             ),
//           ],
//         )
//       : Container(
//           alignment: Alignment.center,
//           child: match.mtime == ""
//               ? Column(
//                   children: [
//                     Text(
//                       match.score ?? '',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: AppSizes.size14,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     Text(
//                       match.result ?? '',
//                       style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: AppSizes.size12,
//                         color: Colors.white,
//                       ),
//                       maxLines: 2,
//                     )
//                   ],
//                 )
//               : Column(
//                   children: [
//                     Text(
//                       DateFormat('h:mm a').format(
//                         DateTime.fromMillisecondsSinceEpoch(
//                           int.parse(match.mtime ?? '') * 1000,
//                         ),
//                       ),
//                       // /item.mtime,
//                       style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: AppSizes.size12,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     Text(
//                       DateFormat('d MMMM').format(
//                         DateTime.fromMillisecondsSinceEpoch(
//                           int.parse(match.mtime ?? '') * 1000,
//                         ),
//                       ),
//                       // /item.mtime,
//                       style: TextStyle(
//                         fontSize: AppSizes.size12,
//                         color: AppColors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//         ),

// ),
//           Expanded(
//               flex: 1,
//               child: cachedNetworkImageMakerFour(match.image2.toString())),
//           Expanded(
//               flex: 3,
//               child: customTextTwo(match.tName2.toString(), AppSizes.size12,
//                   FontWeight.normal, Colors.white)),
//         ],
//       ),
//     ),
//   );
// }

customText(String s) {
  return Center(
    child: Text(
      s,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
            color: AppColors.appColor,
            fontSize: AppSizes.size14,
            fontWeight: FontWeight.w600,
            letterSpacing: .8),
      ),
      textAlign: TextAlign.center,
    ),
  );
}

customTextTwo(String s, fontSize, fontWeight, color) {
  return Text(
    s.toUpperCase(),
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: .8),
    ),
    textAlign: TextAlign.center,
  );
}

percentColorText(String val, String type, Color c) {
  return Column(
    children: [
      Text(val,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: c,
                fontSize: AppSizes.size14,
                fontWeight: FontWeight.bold,
                letterSpacing: .8),
          )),
      Text(type,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: c,
                fontSize: AppSizes.size12,
                fontWeight: FontWeight.normal,
                letterSpacing: .8),
          )),
    ],
  );
}

homeLivematch(Data live) {
  return InkWell(
    // onTap: () => Get.to(PredictionDetails(e.prediction_details.toString())),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.appColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5)
          .copyWith(bottom: 5),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: live.teamOneImage.toString(),
                        height: AppSizes.newSize(4),
                        width: AppSizes.newSize(4),
                        errorWidget: (context, url, error) {
                          return Image.asset(AppAssets.team);
                        },
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: double.infinity,
                          child: SizedBox(
                            height: AppSizes.newSize(2),
                            width: AppSizes.newSize(2),
                            child: Image.asset(
                              AppAssets.mloader,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      customTextTwo(live.teamOneName.toString(),
                          AppSizes.size16, FontWeight.normal, Colors.white)
                    ],
                  )),
              // Expanded(
              //     flex: 2,
              //     child: customTextTwo(
              //         'VS', AppSizes.size20, FontWeight.normal, Colors.white)),
              Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: live.teamTwoImage.toString(),
                        height: AppSizes.newSize(4),
                        width: AppSizes.newSize(4),
                        errorWidget: (context, url, error) {
                          return Image.asset(AppAssets.team);
                        },
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: double.infinity,
                          child: SizedBox(
                            height: AppSizes.newSize(2),
                            width: AppSizes.newSize(2),
                            child: Image.asset(
                              AppAssets.mloader,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      customTextTwo(live.teamTwoName.toString(),
                          AppSizes.size16, FontWeight.normal, Colors.white)
                    ],
                  )),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    ),
  );
}
