import '/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
  width: 42,
  height: 42,
  textStyle: const TextStyle(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(100),
    // boxShadow: [
    //   BoxShadow(
    //     color: Colors.black.withOpacity(0.2),
    //     spreadRadius: 1,
    //     blurRadius: 2,
    //     offset: const Offset(0, 2), // changes position of shadow
    //   ),
    // ],
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.appColor),
    borderRadius: BorderRadius.circular(100),
    color: AppColors.appColor.withOpacity(0.8));

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: AppColors.appColor.withOpacity(0.8),
  ),
);
