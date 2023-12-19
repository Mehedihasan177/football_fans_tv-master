import 'package:flutter/material.dart';
import '/models/completed_matches.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '/models/match_schedule.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../consts/textstyle.dart';
import '../../controllers/matchdetails_controller.dart';

class MatchStats extends StatefulWidget {
  final Ft liveMatch;
  const MatchStats(this.liveMatch, {Key? key}) : super(key: key);

  @override
  State<MatchStats> createState() => _MatchStatsState();
}

class _MatchStatsState extends State<MatchStats> {
  MatchDetailsController matchDetailsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.all(0).copyWith(top: 0),
          child: !matchDetailsController.ismatchStatsLoading.value
              ? ((matchDetailsController.stats.value.info?.length ?? 0) > 0)
                  ? ListView(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        widget.liveMatch.t1name.toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: AppSizes.size15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Center(
                                      child: Image.network(
                                        widget.liveMatch.t1image.toString(),
                                        height: 40,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Center(
                                      child: Image.network(
                                        widget.liveMatch.t2image.toString(),
                                        height: 40,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        widget.liveMatch.t2name.toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: AppSizes.size15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        statMaker(
                            "Possession",
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.homeChart
                                .toString()
                                .replaceAll('%', '')),
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.awayChart
                                .toString()
                                .replaceAll('%', ''))),
                        statMaker(
                            "Shots",
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.homeShots
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(' ')
                                .first),
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.awayShots
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(' ')
                                .first)),
                        statMaker(
                            "Shots on Goal",
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.homeShots
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(' ')
                                .last),
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.awayShots
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(' ')
                                .last)),
                        if ((matchDetailsController.stats.value.info?.length ??
                                0) >
                            0)
                          ...matchDetailsController.stats.value.info!.map(
                              (info) => statMaker(
                                  info.problem.toString(),
                                  int.parse(info.home.toString()),
                                  int.parse(info.away.toString()))),
                      ],
                    )
                  : SizedBox(
                      height: 300,
                      child: Center(
                        child: Text(
                          'No Statistics Found'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.size14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
        ));
  }
}

statMaker(String name, int teamone, int teamtwo) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Column(
      children: [
        Center(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  teamone.toString(),
                  style: CustomtextStyle.maintext2,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: 5,
                color: AppColors.appColor.withOpacity(.2),
                child: (teamone + teamtwo != 0)
                    ? LinearPercentIndicator(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.black.withOpacity(0.2),
                        width: AppSizes.newSize(15),
                        lineHeight: 6.0,
                        percent: teamone / (teamone + teamtwo),
                        trailing: null,
                        progressColor:
                            teamone < teamtwo ? Colors.yellow : AppColors.blue,
                        isRTL: true,
                        alignment: MainAxisAlignment.end,
                        animation: true,
                        animationDuration: 2000,
                        barRadius: const Radius.circular(10),
                      )
                    : Container(
                        width: AppSizes.newSize(15),
                        color: Colors.black.withOpacity(0.2),
                      ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  name,
                  style: CustomtextStyle.maintext2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: 6,
                color: AppColors.appColor.withOpacity(.2),
                child: (teamone + teamtwo != 0)
                    ? LinearPercentIndicator(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.black.withOpacity(0.2),
                        width: AppSizes.newSize(15),
                        lineHeight: 6.0,
                        percent: teamtwo / (teamone + teamtwo),
                        isRTL: false,
                        progressColor:
                            teamone > teamtwo ? Colors.yellow : AppColors.blue,
                        animation: true,
                        animationDuration: 2000,
                        barRadius: const Radius.circular(10),
                      )
                    : Container(
                        width: AppSizes.newSize(15),
                        color: Colors.black.withOpacity(0.2),
                      ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  teamtwo.toString(),
                  style: CustomtextStyle.maintext2,
                ),
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}

class MatchStats2 extends StatefulWidget {
  final Matches match;
  const MatchStats2(this.match, {Key? key}) : super(key: key);

  @override
  State<MatchStats2> createState() => _MatchStats2State();
}

class _MatchStats2State extends State<MatchStats2> {
  MatchDetailsController matchDetailsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.all(0).copyWith(top: 0),
          child: !matchDetailsController.ismatchStatsLoading.value
              ? ((matchDetailsController.stats.value.info?.length ?? 0) > 0)
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: AppSizes.newSize(9),
                                        child: Center(
                                          child: Text(
                                            widget.match.tName1.toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: AppSizes.size16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Center(
                                        child: Image.network(
                                          widget.match.image1.toString(),
                                          height: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Image.network(
                                          widget.match.image2.toString(),
                                          height: 40,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: AppSizes.newSize(9),
                                        child: Center(
                                          child: Text(
                                            widget.match.tName2.toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: AppSizes.size16,
                                            ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        statMaker(
                            "Possession",
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.homeChart
                                .toString()
                                .replaceAll('%', '')),
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.awayChart
                                .toString()
                                .replaceAll('%', ''))),
                        statMaker(
                            "Shots",
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.homeShots
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(' ')
                                .first),
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.awayShots
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(' ')
                                .first)),
                        statMaker(
                            "Shots on Goal",
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.homeShots
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(' ')
                                .last),
                            int.parse(matchDetailsController
                                .stats.value.team!.graph!.awayShots
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(' ')
                                .last)),
                        if ((matchDetailsController.stats.value.info?.length ??
                                0) >
                            0)
                          ...matchDetailsController.stats.value.info!.map(
                              (info) => statMaker(
                                  info.problem.toString(),
                                  int.parse(info.home.toString()),
                                  int.parse(info.away.toString()))),
                      ],
                    )
                  : SizedBox(
                      height: AppSizes.newSize(30),
                      child: Center(
                        child: Text(
                          'No Statistics Found'.tr,
                          style: TextStyle(
                            fontSize: AppSizes.size14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
        ));
  }
}
