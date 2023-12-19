import 'package:flutter/material.dart';
import '/consts/app_colors.dart';
import '/consts/app_sizes.dart';
import '/views/screens/live_list_screen.dart';
import 'package:get/get.dart';

import '../../models/highlight_model.dart';
import 'highlight_streaming_screen.dart';

Widget hightLightWidget(HighLight highLightData) {
  return InkWell(
    onTap: () {
      Get.to(() => HighlightStreamingScreen(highLightData));
    },
    child: Stack(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 0, bottom: 10, left: 13, right: 13),
          margin: const EdgeInsets.only(bottom: 4, left: 5, right: 5),
          // width: AppSizes.newSize(40),
          height: AppSizes.newSize(24),
          decoration: BoxDecoration(
              // color: AppColors.secondary,
              // border: Border.all(color: AppColors.white),
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.league,
                  AppColors.league,
                ],
              ),
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.centerRight,
                  colorFilter: ColorFilter.mode(
                      Colors.transparent.withOpacity(0.9), BlendMode.dstATop),
                  image: NetworkImage(highLightData.coverImage.toString()))),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 0, bottom: 10, left: 13, right: 13),
          margin: const EdgeInsets.only(bottom: 4, left: 5, right: 5),
          // width: AppSizes.newSize(40),
          height: AppSizes.newSize(24),
          decoration: BoxDecoration(
            // color: AppColors.secondary,
            // border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.black.withOpacity(0.5),
                AppColors.black.withOpacity(0.9),
              ],
            ),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 0, bottom: 10, left: 13, right: 13),
          margin: const EdgeInsets.only(bottom: 4, left: 5, right: 5),
          // width: AppSizes.newSize(40),
          height: AppSizes.newSize(24),
          decoration: BoxDecoration(
            // color: AppColors.secondary,
            // border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 13,
                      child: customColumnTeamTwo(
                          highLightData.teamOneImage.toString(),
                          highLightData.teamOneName.toString())),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 0),
                          child: Container(
                              // padding: const EdgeInsets.only(top: 0, right: 0),
                              alignment: Alignment.center,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppColors.selective,
                                  size: 42,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 13,
                      child: customColumnTeamTwo(
                          highLightData.teamTwoImage.toString(),
                          highLightData.teamTwoName.toString())),
                ],
              ),
              // Padding(
              //             padding: const EdgeInsets.only(bottom: 0),
              //             child: Image.asset(
              //               "assets/images/watch-live.png",
              //               height: 40,
              //             ),
              //           )
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 0),
              //   child: Image.asset(
              //     "assets/watch-live.png",
              //     height: 40,
              //   ),
              // )
              // Stack(
              //   children: [
              //     Container(
              //       alignment: Alignment.center,
              //       width: AppSizes.newSize(13.3),
              //       height: AppSizes.newSize(4),
              //       padding: const EdgeInsets.all(5),
              //       margin: const EdgeInsets.only(bottom: 10, top: 6),
              //       decoration: BoxDecoration(
              //         color: AppColors.appbar.withOpacity(.12),
              //         // border: Border.all(width: 1, color: AppColors.back),
              //         border: Border(
              //             top: BorderSide(width: 1.0, color: AppColors.back),
              //             bottom: BorderSide(width: 1.0, color: AppColors.back),
              //             right: BorderSide(width: 1.0, color: AppColors.back),
              //             left: BorderSide(width: 1.0, color: AppColors.back)),
              //         borderRadius: BorderRadius.only(
              //           topRight: Radius.circular(120.0),
              //           topLeft: Radius.circular(120.0),
              //           bottomLeft: Radius.circular(120.0),
              //           bottomRight: Radius.circular(120.0),
              //         ),
              //       ),
              //       child: Center(
              //         child: Text(
              //           'WATCH LIVE'.tr,
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: AppSizes.size13,
              //             fontWeight: FontWeight.bold,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ),
              //     Positioned(
              //       bottom: 9,
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 18),
              //         child: Container(
              //           height: 2,
              //           width: 80,
              //           color: AppColors.colors,
              //           child: Container(
              //             height: 4,
              //             width: 4,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(100),
              //                 color: Colors.white),
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ],
    ),
  );
}
