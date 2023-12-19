import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../consts/app_sizes.dart';
import '../../consts/textstyle.dart';
import '../../controllers/color_controller.dart';
import '../../models/league_table.dart';

class LeagueTableWidget extends StatefulWidget {
  const LeagueTableWidget(this.table, {Key? key}) : super(key: key);
  final LeagueTable table;

  @override
  State<LeagueTableWidget> createState() => _LeagueTableWidgetState();
}

class _LeagueTableWidgetState extends State<LeagueTableWidget> {
  ColorController colorController = Get.find();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int rank = 0;

    buildHeader([heading = 'Team Name']) {
      rank = 0;
      return Container(
        decoration: BoxDecoration(
          //  color: AppColorm.appBgColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(child: Text('#', style: CustomtextStyle.scoretext)),
            Expanded(
              flex: 6,
              child: Center(
                  child: Text(
                heading,
                style: CustomtextStyle.scoretextsm,
                textAlign: TextAlign.justify,
              )),
            ),
            Expanded(
                child: Center(
                    child: Text('GP', style: CustomtextStyle.scoretextsm))),
            Expanded(
                child: Center(
                    child: Text('W', style: CustomtextStyle.scoretextsm))),
            Expanded(
                child: Center(
                    child: Text('D', style: CustomtextStyle.scoretextsm))),
            Expanded(
                child: Center(
                    child: Text('L', style: CustomtextStyle.scoretextsm))),
            Expanded(
                child: Center(
                    child: Text('GF', style: CustomtextStyle.scoretextsm))),
            Expanded(
                child: Center(
                    child: Text('GA', style: CustomtextStyle.scoretextsm))),
            Expanded(
                child: Center(
                    child: Text('GD', style: CustomtextStyle.scoretextsm))),
            Expanded(
                child: Center(
                    child: Text('P', style: CustomtextStyle.scoretextsm))),
          ],
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      children: [
        if (!widget.table.team![0].heding!.contains('Group') &&
            !widget.table.team![0].heding!.contains('GROUP'))
          Container(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(child: Text('#', style: CustomtextStyle.scoretextsm)),
                Expanded(
                  flex: 6,
                  child: Center(
                      child: Text(
                    "NAME",
                    style: CustomtextStyle.scoretextsm,
                    textAlign: TextAlign.justify,
                  )),
                ),
                Expanded(child: Text('GP', style: CustomtextStyle.scoretextsm)),
                Expanded(child: Text('W', style: CustomtextStyle.scoretextsm)),
                Expanded(child: Text('D', style: CustomtextStyle.scoretextsm)),
                Expanded(child: Text('L', style: CustomtextStyle.scoretextsm)),
                Expanded(child: Text('GF', style: CustomtextStyle.scoretextsm)),
                Expanded(child: Text('GA', style: CustomtextStyle.scoretextsm)),
                Expanded(child: Text('GD', style: CustomtextStyle.scoretextsm)),
                Expanded(child: Text('P', style: CustomtextStyle.scoretextsm)),
              ],
            ),
          ),
        ListView.builder(
          itemCount: widget.table.team!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            if (widget.table.team![i].heding!.contains('Group') ||
                widget.table.team![i].heding!.contains('GROUP')) {
              return buildHeader(widget.table.team![i].heding);
            } else {
              rank++;
              return Container(
                margin: const EdgeInsets.only(bottom: 0),
                decoration: const BoxDecoration(
                  //  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: Text(
                          rank.toString(),
                          style: TextStyle(
                              color: colorController.isLightTheme.value
                                  ? Colors.white
                                  : Colors.white,
                              fontSize: AppSizes.size13),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CachedNetworkImage(
                          imageUrl: widget.table.team![i].logo.toString(),
                          width: 25,
                          height: 25,
                          placeholder: (context, url) => Transform.scale(
                            scale: .25,
                            child: const CircularProgressIndicator(
                                color: Colors.white),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/default-team.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          widget.table.team![i].heding.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(widget.table.point![i].gP.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          )),
                    ),
                    Expanded(
                      child: Text(widget.table.point![i].w.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          )),
                    ),
                    Expanded(
                      child: Text(widget.table.point![i].d.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          )),
                    ),
                    Expanded(
                      child: Text(widget.table.point![i].l.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          )),
                    ),
                    Expanded(
                      child: Text(widget.table.point![i].gF.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          )),
                    ),
                    Expanded(
                      child: Text(widget.table.point![i].gA.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          )),
                    ),
                    Expanded(
                      child: Text(widget.table.point![i].gD.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          )),
                    ),
                    Expanded(
                      child: Text(widget.table.point![i].p.toString(),
                          style: TextStyle(
                            color: colorController.isLightTheme.value
                                ? Colors.grey
                                : Colors.white,
                            fontSize: AppSizes.size13,
                          )),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
