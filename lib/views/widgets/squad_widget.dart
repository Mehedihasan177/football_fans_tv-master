// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../consts/app_colors.dart';
import '/consts/app_sizes.dart';
import '/controllers/color_controller.dart';
import '/models/squads.dart';
import 'package:get/get.dart';

goalkeeperList(List<Goalkeepers> goalkeepers) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5).copyWith(left: 8),
                  //height: 30,
                  child: customText("NAME")),
              ...goalkeepers.map((e) => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 9).copyWith(left: 8),
                  //  height: 30,
                  child: Text(
                    e.name.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: AppSizes.size12, color: Colors.white),
                  )))
            ],
          )),
      Expanded(
        flex: 6,
        child: Column(
          children: [
            Container(
                // color: Colors.black.withOpacity(.1),
                height: AppSizes.newSize(5.5) * (goalkeepers.length),
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          goalkeeperheader(),
                          ...goalkeepers.map(
                            (e) => goalkeepersRow(e),
                          ),
                        ],
                      )
                    ])),
          ],
        ),
      )
    ],
  );
}

goalkeeperheader() {
  var widt = 40.0;
  return Container(
    height: 25.0,
    child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        Container(
            width: widt * 1.5,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("Jersey ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("age ")),
        Container(
          width: widt,
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          child: customText(
            "ht ",
          ),
        ),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("wt ")),
        Container(
            width: widt * 2,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("nat ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("app ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("sub ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("sv ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("ga ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("a ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("fc ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("fa ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("yc ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("rc ")),
      ],
    ),
  );
}

goalkeepersRow(Goalkeepers e) {
  var widt = 40.0;
  return Container(
    padding: const EdgeInsets.only(top: 7, bottom: 7),
    child: Row(
      children: [
        Container(
            width: widt * 1.5,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText2(
              e.jercy.toString(),
            )),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(
              e.age.toString(),
            )),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              e.ht.toString(),
              style: TextStyle(fontSize: AppSizes.size12, color: Colors.white),
              maxLines: 1,
            )),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.wt.toString().replaceAll("kg", ""))),
        Container(
            width: widt * 2,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              e.nat.toString(),
              maxLines: 1,
              style: TextStyle(fontSize: AppSizes.size12, color: Colors.white),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            )),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.app.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.sub.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.sv.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.ga.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.a.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.fc.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.fa.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.yc.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.rc.toString())),
      ],
    ),
  );
}

playerList(List<Outfield> players) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5).copyWith(left: 8),
                  child: customText("NAME")),
              ...players.map((e) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 9)
                        .copyWith(left: 8),
                    child: Text(
                      e.name.toString(),
                      style: TextStyle(
                          fontSize: AppSizes.size12, color: Colors.white),
                      maxLines: 1,
                    ),
                  ))
            ],
          )),
      Expanded(
        flex: 6,
        child: Column(
          children: [
            Container(
                color: Colors.white.withOpacity(.1),
                height: AppSizes.newSize(5) * (players.length),
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          playersheader(),
                          ...players.map(
                            (e) => playersrow(e),
                          ),
                        ],
                      )
                    ])),
          ],
        ),
      )
    ],
  );
}

playersheader() {
  var widt = 40.0;
  return Container(
    height: 25.0,
    child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        // Container(
        //     width: widt * 3,
        //     padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        //     child: customText("NAME ")),
        Container(
            width: widt * 1.5,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("Jersey ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("age ")),
        Container(
          width: widt,
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          child: customText(
            "ht ",
          ),
        ),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("wt ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("pos ")),
        Container(
            width: widt * 2.5,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("nat ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("app ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("sub ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("g ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("a ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("sh ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("st ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("fc ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("fa ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("yc ")),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText("rc ")),
      ],
    ),
  );
}

playersrow(Outfield e) {
  var widt = 40.0;
  return Container(
    padding: const EdgeInsets.only(top: 7, bottom: 7),
    child: Row(
      children: [
        // Container(
        //     width: widt * 3,
        //     padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        //     child: Text(
        //       e.name.toString(),
        //       style: TextStyle(fontSize: AppSizes.size12),
        //       maxLines: 1,
        //     )),
        Container(
            width: widt * 1.5,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: customText2(
              e.jercy.toString(),
            )),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(
              e.age.toString(),
            )),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              e.ht.toString().replaceAll('m', ''),
              style: TextStyle(fontSize: AppSizes.size12, color: Colors.white),
              maxLines: 1,
              textAlign: TextAlign.center,
            )),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.wt.toString().replaceAll("kg", ""))),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.pos.toString())),
        Container(
            width: widt * 2.5,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              e.nat.toString(),
              maxLines: 1,
              style: TextStyle(fontSize: AppSizes.size12, color: Colors.white),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            )),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.app.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.sub.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.g.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.a.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.sh.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.st.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.fc.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.fa.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.yc.toString())),
        Container(
            width: widt,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: customText2(e.rc.toString())),
      ],
    ),
  );
}

customText2(text) {
  ColorController colorController = Get.find();
  return Center(
    child: Text(
      text.toString(),
      style: TextStyle(
          color:
              !colorController.isLightTheme.value ? Colors.white : Colors.white,
          fontSize: AppSizes.size12),
      // textAlign: TextAlign.center,
    ),
  );
}

customText(text) {
  ColorController colorController = Get.find();
  return Center(
    child: Text(
      text.toString().toUpperCase(),
      style: TextStyle(
          color: !colorController.isLightTheme.value
              ? AppColors.white
              : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.size13),
    ),
  );
}
