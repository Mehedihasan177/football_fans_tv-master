// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football_fans_tv/services/ads_service.dart';
import '/models/live_matches.dart' as livematches;
import '/models/live_stream_model.dart' as livestreammodel;
import '/views/screens/watch_screen.dart';
import 'package:get/get.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/live_match_stream_controller.dart' as data;
import '../../utils/widgets.dart';

data.LiveMatchStreamController liveMatchStreamController = Get.find();
// SettingController settingController = Get.find();
var colors = [
  AppColors.appColor,
  AppColors.appgrad,
];

Widget HomeLiveMatchStreaming(
    livestreammodel.Data data, livematches.Data liveMatchs) {
  return GestureDetector(
      onTap: () {
        var arguments = {
          'data': data,
          'id': data.id,
          'title': data.streamTitle,
          'stream_url': data.streamUrl,
          'stream': true,
        };

        AdsService.showInterstitialAd(
          () {
            Get.to(() => WatchScreen(arguments));
          },
          adControl: false,
        );
      },
      child: !liveMatchStreamController.isloading.value
          ? Card(
              elevation: 0.8,
              color: AppColors.league.withOpacity(0.45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // margin: const EdgeInsets.symmetric(
              //     vertical: 3, horizontal: 4),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      globalTextStyleTwo(data.streamTitle, Colors.white,
                          AppSizes.size15, FontWeight.bold),
                      const SizedBox(
                        height: 9,
                      ),
                      // globalTextStyleTwo(data.streamType, Colors.white,
                      //     AppSizes.size15, FontWeight.bold),
                      // const SizedBox(
                      //   height: 19,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: liveMatchs.teamOneImage.toString(),
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
                                Center(
                                  child: Text(
                                    liveMatchs.teamOneName ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppSizes.size15,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, right: 0),
                              child: Center(
                                child: Text(
                                  "VS",
                                  style: TextStyle(
                                      fontSize: AppSizes.size18,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: liveMatchs.teamTwoImage.toString(),
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
                                Center(
                                  child: Text(
                                    liveMatchs.teamTwoName ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppSizes.size15,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                      // const SizedBox(
                      //   height: 13,
                      // ),
                      // Center(
                      //   child: globalTextStyleTwo(" Venue: ${liveMatchs.vanue}",
                      //       Colors.white, AppSizes.size15, FontWeight.normal),
                      // ),
                    ],
                  )),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ));
}
