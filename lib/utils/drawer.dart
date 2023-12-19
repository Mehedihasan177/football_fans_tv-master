import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../consts/app_sizes.dart';
import '../controllers/color_controller.dart';

drawer() {
  ColorController colorController = Get.find();
  return Drawer(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Icon(
            Icons.change_circle,
            size: 24,
            color: Theme.of(Get.context!).textSelectionTheme.selectionColor,
          ),
          const SizedBox(width: 20),
          Text(
            "Change Theme".tr,
            style: TextStyle(
                color: Theme.of(Get.context!).textSelectionTheme.selectionColor,
                fontSize: AppSizes.size13),
          ),
        ],
      ),
      ObxValue(
        (data) => Switch(
          value: colorController.isLightTheme.value,
          onChanged: (val) {
            colorController.isLightTheme.value = val;
            Get.changeThemeMode(
              colorController.isLightTheme.value
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Theme.of(Get.context!).brightness,
              ),
            );

            //   _saveThemeStatus();
          },
        ),
        false.obs,
      ),
    ],
  ));
}
