import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../models/league_fixtures.dart';

class LeagueFixturesWidget extends StatefulWidget {
  const LeagueFixturesWidget(this.leagueFixtures, {Key? key}) : super(key: key);
  final LeagueFixtures leagueFixtures;
  @override
  State<LeagueFixturesWidget> createState() => _LeagueFixturesWidgetState();
}

class _LeagueFixturesWidgetState extends State<LeagueFixturesWidget> {
  ColorController colorController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(Get.context!).primaryColor.withOpacity(.2),
      //color: Colors.red,
      child: Column(
        children: [
          Center(
            child: Text(
              widget.leagueFixtures.title.toString(),
              style: TextStyle(
                fontSize: AppSizes.size14,
                fontWeight: FontWeight.w700,
                color: colorController.isLightTheme.value
                    ? Colors.white
                    : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...widget.leagueFixtures.matches!.map(
            (matchItem) => InkWell(
              onTap: () {
                // var arguments = {
                //   'matchId': matchItem.matchId,
                //   'result': matchItem.result != ''
                //       ? matchItem.result
                //       : matchItem.mtime,
                //   'score': matchItem.score,
                //   'homeName': matchItem.tName1,
                //   'homeImage': matchItem.image1,
                //   'awayName': matchItem.tName2,
                //   'awayImage': matchItem.image2,
                // };
              },
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
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.only(right: 7),
                              child: Text(
                                matchItem.tName1 ?? '',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: AppSizes.size13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: AppSizes.newSize(3.5),
                            height: AppSizes.newSize(3.5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.appColor),
                              //color: AppColors.gradbottom,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1, // changes position of shadow
                                ),
                              ],
                            ),
                            child: CachedNetworkImage(
                              imageUrl: matchItem.image1 ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: AppSizes.newSize(3.5),
                                height: AppSizes.newSize(3.5),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              placeholder: (context, url) => Transform.scale(
                                scale: .25,
                                child: const CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/default-team.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: matchItem.result == "LIVE" ||
                              matchItem.result == "Postponed" ||
                              matchItem.result == "TBD"
                          ? Container(
                              alignment: Alignment.center,
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 3, 4, 3),
                                  decoration: BoxDecoration(
                                      // border: Border.all(
                                      //     color: AppColors.gradtop),
                                      //color: AppColors.gradbottom,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(matchItem.result ?? '',
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontSize: AppSizes.size12,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))),
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: matchItem.mtime == "" &&
                                      matchItem.score != 'v'
                                  ? Column(
                                      children: [
                                        Text(
                                          matchItem.score ?? '',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizes.size14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(matchItem.result ?? '',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: AppSizes.size14,
                                                color: AppColors.appColor,
                                              ),
                                            ))
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          DateFormat('h:mm a').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(matchItem.mtime ?? '') *
                                                  1000,
                                            ),
                                          ),
                                          // /item.mtime,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizes.size13,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          DateFormat('d MMM').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(matchItem.mtime ?? '') *
                                                  1000,
                                            ),
                                          ),
                                          // /item.mtime,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontSize: AppSizes.size12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: AppSizes.newSize(3.5),
                            height: AppSizes.newSize(3.5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.appColor),
                              //  color: AppColorm.screenBg,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1, // changes position of shadow
                                ),
                              ],
                            ),
                            child: CachedNetworkImage(
                              imageUrl: matchItem.image2 ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: AppSizes.newSize(3.5),
                                height: AppSizes.newSize(3.5),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              placeholder: (context, url) => Transform.scale(
                                scale: .25,
                                child: const CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/default-team.png'),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.only(left: 7),
                              child: Text(
                                matchItem.tName2 ?? '',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: AppSizes.size13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
