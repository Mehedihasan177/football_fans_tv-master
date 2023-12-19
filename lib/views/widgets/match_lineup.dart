// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import '/consts/app_colors.dart';
import 'package:get/get.dart';

import '../../consts/app_sizes.dart';
import '../../controllers/matchdetails_controller.dart';
import '../../models/lineups.dart';

class MatchLineUp extends StatefulWidget {
  const MatchLineUp({Key? key}) : super(key: key);

  @override
  State<MatchLineUp> createState() => _MatchLineUpState();
}

class _MatchLineUpState extends State<MatchLineUp> {
  MatchDetailsController matchDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => !matchDetailsController.ismatchLineUpsLoading.value
        ? ((matchDetailsController.team1form.length) > 0)
            ? SizedBox(
                //height: AppSizes.newSize(70),
                // width: Get.width > 400 ? 400 : Get.width,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/field.png',
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            ...matchDetailsController.team1form.map(
                              (element) => Expanded(
                                child: Row(
                                  children: [
                                    ...element.map((e) => Expanded(
                                        child: Center(
                                            child:
                                                playerMaker(e, Colors.white))))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                        Expanded(
                          child: Column(
                            children: [
                              ...matchDetailsController.team2form.reversed.map(
                                (element) => Expanded(
                                  child: Row(
                                    children: [
                                      ...element.map((e) => Expanded(
                                          child: Center(
                                              child: playerMaker(
                                                  e, AppColors.secondteam))))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'No Lineups Found'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.size14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
        : Center(
            child: Container(
                margin: const EdgeInsets.all(8),
                child: const CircularProgressIndicator(color: Colors.white)),
          ));
  }

  playerMaker(PlayerList e, Color color) {
    return SizedBox(
      width: Get.width > 400 ? 400 : Get.width,
      child: Column(
        children: [
          Container(
              width: AppSizes.newSize(3),
              height: AppSizes.newSize(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: color,
              ),
              child: Center(
                child: Text(
                  e.t1pNo.toString(),
                  style: TextStyle(
                    fontSize: AppSizes.size16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
          const SizedBox(height: 3),
          Text(
            e.t1pName.toString().split(' ').first,
            style: TextStyle(
                fontSize: AppSizes.size12,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
