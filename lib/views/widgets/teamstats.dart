import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:toggle_switch/toggle_switch.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../models/team_stats.dart';
import '../screens/league_transfer.dart';

class TeamStatWidget extends StatefulWidget {
  const TeamStatWidget(this.stats, {Key? key}) : super(key: key);
  final Stats stats;
  @override
  State<TeamStatWidget> createState() => _TeamStatWidgetState();
}

class _TeamStatWidgetState extends State<TeamStatWidget> {
  var controller = 0;
  ColorController colorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: ToggleSwitch(
            minWidth: AppSizes.newSize(13),
            cornerRadius: 20.0,
            activeBgColors: const [
              [AppColors.white],
              [AppColors.white]
            ],
            activeFgColor: AppColors.appColor,
            inactiveBgColor: AppColors.appColor,
            inactiveFgColor: AppColors.white,
            initialLabelIndex: controller,
            customTextStyles: const [],
            totalSwitches: 2,
            labels: ['Top Scorers'.tr, 'Top Assists'.tr],
            radiusStyle: true,
            onToggle: (index) {
              setState(() {
                controller = index!;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: controller == 0,
          child: (widget.stats.topScorers!.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.stats.topScorers!.length,
                  itemBuilder: (context, index) {
                    TopScorers e = widget.stats.topScorers![index];
                    return Column(
                      children: [
                        if (index == 0)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: customHText("Rank", controller)),
                                Expanded(
                                    flex: 7,
                                    child: customHText("Name", controller)),
                                Expanded(
                                    flex: 2,
                                    child: customHText("Matches", controller)),
                                Expanded(
                                    flex: 2,
                                    child: customHText("Goals", controller)),
                              ],
                            ),
                          ),
                        previewPlayerWidgetScorers(e)
                      ],
                    );
                  })
              : Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    'No Player available'.tr,
                    style: TextStyle(
                        color: !colorController.isLightTheme.value
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size14),
                  ),
                ),
        ),
        Visibility(
          visible: controller == 1,
          child: (widget.stats.topAssists!.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.stats.topAssists!.length,
                  itemBuilder: (context, index) {
                    TopAssists e = widget.stats.topAssists![index];
                    return Column(
                      children: [
                        if (index == 0)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: customHText("Rank", controller)),
                                Expanded(
                                    flex: 7,
                                    child: customHText("Name", controller)),
                                Expanded(
                                    flex: 2,
                                    child: customHText("Matches", controller)),
                                Expanded(
                                    flex: 2,
                                    child: customHText("Assists", controller)),
                              ],
                            ),
                          ),
                        previewPlayerWidgetAssists(e)
                      ],
                    );
                  })
              : Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    'No Player available',
                    style: TextStyle(
                        color: !colorController.isLightTheme.value
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size14),
                  ),
                ),
        ),
      ],
    );
  }

  Widget previewPlayerWidgetScorers(TopScorers e) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: customText2(e.rk)),
          Expanded(flex: 7, child: customTextrow(e.name)),
          Expanded(flex: 2, child: customText2(e.p)),
          Expanded(flex: 2, child: customText2(e.g)),
        ],
      ),
    );
  }

  Widget previewPlayerWidgetAssists(TopAssists e) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: customText2(e.rk)),
          Expanded(flex: 7, child: customTextrow(e.name)),
          Expanded(flex: 2, child: customText2(e.p)),
          Expanded(flex: 2, child: customText2(e.a)),
        ],
      ),
    );
  }
}

customTextrow(text) {
  ColorController colorController = Get.find();
  return Container(
    padding: const EdgeInsets.only(left: 12),
    child: Text(
      text.toString(),
      style: TextStyle(
          color:
              colorController.isLightTheme.value ? Colors.white : Colors.white,
          fontSize: AppSizes.size12),
      textAlign: TextAlign.start,
    ),
  );
}
