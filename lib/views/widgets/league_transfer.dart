import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../models/league_transfer.dart';

class LeagueTransferWidget extends StatelessWidget {
  const LeagueTransferWidget(this.list, {Key? key}) : super(key: key);
  final List<Transfers> list;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(children: [
            if (index == 0)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2).copyWith(bottom: 9),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: customHText("Date")),
                    Expanded(flex: 5, child: customHText("Player")),
                    Expanded(flex: 3, child: customHText("Fee")),
                  ],
                ),
              ),
            transferItem(list[index])
          ]);
        });
  }

  Widget transferItem(Transfers list) {
    ColorController colorController = Get.find();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.2,
            color: colorController.isLightTheme.value
                ? Colors.white
                : Colors.white,
          ),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: customText2(list.date)),
          Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.player.toString(),
                    style: TextStyle(
                        fontSize: AppSizes.size13, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              cachedImageMaker(list.from!.image.toString()),
                              const SizedBox(width: 3),
                              Text(
                                list.from!.tname.toString(),
                                style: TextStyle(
                                    fontSize: AppSizes.size12,
                                    color: Colors.white),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/transfer.png',
                            height: AppSizes.newSize(3),
                            width: AppSizes.newSize(3),
                          )),
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              cachedImageMaker(list.to!.image.toString()),
                              const SizedBox(width: 3),
                              Text(
                                list.to!.tname.toString(),
                                style: TextStyle(
                                    fontSize: AppSizes.size12,
                                    color: Colors.white),
                              )
                            ],
                          )),
                    ],
                  )
                ],
              )),
          Expanded(flex: 3, child: customText2(list.fee)),
        ],
      ),
    );
  }
}

cachedImageMaker(url) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      width: AppSizes.newSize(3),
      height: AppSizes.newSize(3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
    ),
    placeholder: (context, url) => Transform.scale(
      scale: .15,
      child: const CircularProgressIndicator(color: Colors.white),
    ),
    errorWidget: (context, url, error) => Image.asset(
      'assets/images/default-team.png',
      height: 20,
      width: 20,
    ),
  );
}

customText2(text) {
  ColorController colorController = Get.find();
  return Center(
      child: Text(
    text.toString().tr,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
          color:
              colorController.isLightTheme.value ? Colors.white : Colors.white,
          fontSize: AppSizes.size12),
      // textAlign: TextAlign.center,
    ),
  ));
}

customHText(text, [int controller = 2]) {
  ColorController colorController = Get.find();
  return Center(
    child: Text(
      text.toString().tr,
      style: controller == 2
          ? GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: colorController.isLightTheme.value
                      ? Colors.white
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size12))
          : GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: controller == 0 ? AppColors.white : AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size12)),
    ),
  );
}
