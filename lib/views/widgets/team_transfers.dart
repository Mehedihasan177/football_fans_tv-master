// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/consts/app_assets.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '/consts/app_sizes.dart';
import '/models/team_transfer.dart';
// import '/views/widgets/squad_widget.dart';
import '/views/widgets/teamstats.dart';
import '../../consts/app_colors.dart';
import '../../controllers/color_controller.dart';
import 'league_transfer.dart';

class TeamTransferWidgets extends StatefulWidget {
  TeamTransferWidgets(this.transfers, {Key? key}) : super(key: key);
  final Transfers transfers;
  @override
  State<TeamTransferWidgets> createState() => _TeamTransferWidgetsState();
}

class _TeamTransferWidgetsState extends State<TeamTransferWidgets> {
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
            totalSwitches: 2,
            labels: ['Players In'.tr, 'Players Out'.tr],
            radiusStyle: true,
            onToggle: (index) {
              setState(() {
                controller = index!;
              });

              print(controller);
            },
          ),
        ),
        SizedBox(height: 10),
        Visibility(
          visible: controller == 0,
          child: (widget.transfers.playersIn!.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.transfers.playersIn!.length,
                  itemBuilder: (context, index) {
                    PlayersIn e = widget.transfers.playersIn![index];
                    return Column(
                      children: [
                        if (index == 0)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: customHText("Date", controller)),
                                Expanded(
                                    flex: 5,
                                    child: customHText("Name", controller)),
                                Expanded(
                                    flex: 3,
                                    child: customHText("From", controller)),
                                Expanded(
                                    flex: 2,
                                    child: customHText("Fee", controller)),
                              ],
                            ),
                          ),
                        transferRowIn(e),
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
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.size14),
                  ),
                ),
        ),
        Visibility(
          visible: controller == 1,
          child: (widget.transfers.playersOut!.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.transfers.playersOut!.length,
                  itemBuilder: (context, index) {
                    PlayersOut e = widget.transfers.playersOut![index];
                    return Column(
                      children: [
                        if (index == 0)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: customHText("Date", controller)),
                                Expanded(
                                    flex: 5,
                                    child: customHText("Name", controller)),
                                Expanded(
                                    flex: 3,
                                    child: customHText("From", controller)),
                                Expanded(
                                    flex: 2,
                                    child: customHText("Fee", controller)),
                              ],
                            ),
                          ),
                        transferRowOut(e),
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

  transferRowOut(PlayersOut e) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(flex: 2, child: customText2(e.date)),
          Expanded(flex: 5, child: customTextrow(e.name)),
          Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CachedNetworkImage(
                      imageUrl: e.imgId ?? "",
                      placeholder: (context, url) => Transform.scale(
                        scale: .25,
                        child: const CircularProgressIndicator(
                            color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppAssets.team,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: customTextrow(e.from)),
                ],
              )),
          Expanded(flex: 3, child: customText2(e.fee)),
        ],
      ),
    );
  }

  transferRowIn(PlayersIn e) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(flex: 2, child: customText2(e.date)),
          Expanded(flex: 5, child: customTextrow(e.name)),
          Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CachedNetworkImage(
                      imageUrl: e.imgId.toString(),
                      placeholder: (context, url) => Transform.scale(
                        scale: .25,
                        child: const CircularProgressIndicator(
                            color: Colors.white),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Expanded(flex: 2, child: customTextrow(e.from)),
                ],
              )),
          Expanded(flex: 3, child: customText2(e.fee)),
        ],
      ),
    );
  }
}
