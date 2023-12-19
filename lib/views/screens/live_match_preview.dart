import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import '/controllers/setting%20_controller.dart';
import '/models/live_matches.dart';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';

class LiveMatchPreview extends StatefulWidget {
  const LiveMatchPreview(this.livedata, {Key? key}) : super(key: key);
  final Data livedata;
  @override
  State<LiveMatchPreview> createState() => _LiveMatchPreviewState();
}

class _LiveMatchPreviewState extends State<LiveMatchPreview> {
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "${widget.livedata.teamOneName ?? ""} Vs. ${widget.livedata.teamTwoName ?? ""}",
          style: TextStyle(
            fontSize: AppSizes.size14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Stack(
              children: [
                Image.asset(
                  AppAssets.cover,
                  fit: BoxFit.cover,
                  height: 220,
                  width: double.infinity,
                ),
                Container(
                  height: 220,
                  width: AppSizes.newSize(100),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Row(
                          children: [
                            Expanded(
                              child: team(widget.livedata.teamOneName,
                                  widget.livedata.teamOneImage),
                            ),
                            Container(
                              height: 34,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.pink,
                              ),
                              child: Center(
                                child: Text(
                                  'VS',
                                  style: TextStyle(
                                    fontSize: AppSizes.size14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: team(widget.livedata.teamTwoName,
                                  widget.livedata.teamTwoImage),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: CountdownTimer(
                            widgetBuilder: (context, time) {
                              if (time == null) {
                                return Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.red[600],
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppSizes.size14,
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '${'The match will start in'.tr} ${time.days ?? '0'}d : ${time.hours ?? '0'}h : ${time.min ?? '0'}m : ${time.sec}s',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: AppSizes.size13,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Streaming will start before 15 mins of the match started.'
                                          .tr,
                                      style: TextStyle(
                                        color: Colors.red[600],
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.size15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                            endTime:
                                int.parse(widget.livedata.matchTime ?? '') *
                                    1000,
                            textStyle: TextStyle(
                              fontSize: AppSizes.size13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ).copyWith(left: 15),
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ).copyWith(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Share Football Fans TV app now to enjoy the match live streaming with friends.'
                            .tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.size14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(
                          "${widget.livedata.teamOneName} VS ${widget.livedata.teamTwoName}, ${widget.livedata.matchTitle} \n${"Download Football Fans TV app from the below link and enjoy every match's Live Streaming".tr} \n${settingController.settings.value.iosAppShareLink}",
                        );
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            //  const NativeAds(),
          ],
        ),
      ),
      //   bottomNavigationBar: BannerAds(),
    );
  }

  team(teamOneName, teamOneImage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.all(4),
          child: CachedNetworkImage(
            imageUrl: teamOneImage,
            imageBuilder: (context, imageProvider) => Container(
              width: AppSizes.newSize(6),
              height: AppSizes.newSize(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Container(
              width: AppSizes.newSize(3),
              padding: const EdgeInsets.all(5),
              height: AppSizes.newSize(3),
              child: Transform.scale(
                scale: 0.25,
                child: const CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          teamOneName,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSizes.size16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
