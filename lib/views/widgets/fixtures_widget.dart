import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../models/fixtures.dart';

class FixtureWidget extends StatefulWidget {
  const FixtureWidget(this.teamFix, {Key? key}) : super(key: key);
  final TeamFix teamFix;

  @override
  State<FixtureWidget> createState() => _FixtureWidgetState();
}

class _FixtureWidgetState extends State<FixtureWidget> {
  ColorController colorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Center(
              child: Text(
                widget.teamFix.matchDate.toString(),
                style: TextStyle(
                  fontSize: AppSizes.size14,
                  fontWeight: FontWeight.w700,
                  color: colorController.isLightTheme.value
                      ? Colors.white
                      : Colors.white,
                ),
              ),
            ),
            Container(
              height: AppSizes.newSize(7),
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: .25,
                  color: !colorController.isLightTheme.value
                      ? Colors.black
                      : Colors.white,
                ),
                color: AppColors.appColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      padding: const EdgeInsets.only(right: 7),
                                      child: Text(
                                        widget.teamFix.team1 ?? '',
                                        maxLines: 2,
                                        style: GoogleFonts.barlow(
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
                                      border:
                                          Border.all(color: AppColors.appColor),
                                      //color: AppColors.gradbottom,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius:
                                              1, // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.teamFix.image1 ?? '',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: AppSizes.newSize(3.5),
                                        height: AppSizes.newSize(3.5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Transform.scale(
                                        scale: .25,
                                        child: const CircularProgressIndicator(
                                            color: Colors.white),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images/default-team.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.teamFix.matchDate.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.size12,
                                      color: !colorController.isLightTheme.value
                                          ? Colors.white
                                          : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    DateFormat('hh:mm a').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(widget.teamFix.mTime
                                                .toString()) *
                                            1000,
                                      ).toLocal(),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: AppSizes.size12,
                                      color: !colorController.isLightTheme.value
                                          ? Colors.white
                                          : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  //  imageUrl: e.t2Img ?? '',
                                  imageUrl: widget.teamFix.image2.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: AppSizes.newSize(4),
                                    height: AppSizes.newSize(4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.grey[400]!,
                                        width: 1.5,
                                      ),
                                      //shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    width: AppSizes.newSize(3.2),
                                    padding: const EdgeInsets.all(5),
                                    height: AppSizes.newSize(3.2),
                                    child: const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                AppColors.primary)),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    AppAssets.team,
                                    width: AppSizes.newSize(3.2),
                                    height: AppSizes.newSize(3.2),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Text(
                                      widget.teamFix.team2.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: AppSizes.size13,
                                        color:
                                            !colorController.isLightTheme.value
                                                ? Colors.white
                                                : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
