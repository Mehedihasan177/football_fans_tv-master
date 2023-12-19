import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../consts/app_sizes.dart';

// import '../constants/constant.dart';

homeAppbar() {
  return AppBar(
    toolbarHeight: AppSizes.newSize(7),
    elevation: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
    centerTitle: true,
    title: Image.asset(
      "assets/images/Football-Fans-TV.png",
      height: 40,
    ),

    // backgroundColor: mainAppColor,
  );
}

appbarCustomTabs(String name, actions, bool center, bottom) {
  return AppBar(
    toolbarHeight: 40,
    centerTitle: center ? true : false,
    backgroundColor: HexColor('#0F172A'),
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
    title: Text(name),
    iconTheme: const IconThemeData(
      color: Colors.white, //change your color here
    ),
    actions: actions,
    bottom: TabBar(
      indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 3.0, color: Colors.orange),
          insets: EdgeInsets.symmetric(horizontal: 5.0)),

      tabs: bottom,
      // labelStyle: TextStyle(fontSize: AppSizes.size16),

      ///
    ),
  );
}

appBarCustomMiddle(String name, actions) {
  return AppBar(
    // flexibleSpace: Container(
    //     decoration: const BoxDecoration(gradient: AppColors.linearGrad)),
    backgroundColor: HexColor('#0F172A'),
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
    centerTitle: true,
    title: Text(
      name,
      style: TextStyle(
        fontSize: AppSizes.size14,
        fontWeight: FontWeight.bold,
        color: Theme.of(Get.context!).textSelectionTheme.selectionColor,
      ),
    ),
    iconTheme: IconThemeData(
      color: Theme.of(Get.context!).textSelectionTheme.selectionColor,
    ),
    // backgroundColor: mainAppColor,
    actions: actions,
  );
}
