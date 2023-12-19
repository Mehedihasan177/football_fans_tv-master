// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class CustomtextStyle {
  static final TextStyle newsheadline = TextStyle(
      color: Colors.purple,
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.size16);

  static final TextStyle scoretext = GoogleFonts.roboto(
      textStyle: TextStyle(
          color: Colors.white,
          fontSize: AppSizes.size14,
          fontWeight: FontWeight.bold));

  static final TextStyle scoretextsm = GoogleFonts.roboto(
      textStyle: TextStyle(
          color: Colors.grey,
          fontSize: AppSizes.size14,
          fontWeight: FontWeight.normal));
  static final TextStyle scoretextBl = GoogleFonts.roboto(
      textStyle: TextStyle(
          color: Colors.black,
          fontSize: AppSizes.size20,
          fontWeight: FontWeight.bold));
  static final TextStyle maintext = TextStyle(
      color: HexColor('#0F172A'),
      fontWeight: FontWeight.normal,
      fontSize: AppSizes.size13);
  static final TextStyle maintext2 =
      TextStyle(color: AppColors.white, fontSize: AppSizes.size12);
  static final TextStyle matchtext = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.size13));

  static final TextStyle resultText = TextStyle(
      color: const Color.fromARGB(255, 134, 133, 133),
      fontSize: AppSizes.size12);

  static final TextStyle playerofthematch = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.size22);
  static final TextStyle playerofthematchSmall =
      TextStyle(color: Colors.white, fontSize: AppSizes.size16);
  static final TextStyle playerofthematchSmallOne = TextStyle(
      color: Colors.white,
      fontSize: AppSizes.size18,
      fontWeight: FontWeight.bold);

  static final TextStyle noDataText = TextStyle(
      fontSize: AppSizes.size16,
      color: Colors.black,
      fontWeight: FontWeight.w800);

  static final TextStyle leadtext = GoogleFonts.lato(
      textStyle: TextStyle(
    color: AppColors.appColor,
    fontSize: AppSizes.size14,
    fontWeight: FontWeight.bold,
  ));

  static final TextStyle playerText = GoogleFonts.lato(
      textStyle: TextStyle(
    color: AppColors.appColor,
    fontSize: AppSizes.size13,
    fontWeight: FontWeight.bold,
  ));

  static const labelsize = 11.0;
}

boldText(bool val) {
  TextStyle(
      color: val ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.size14);
}

playerstyle(bool val) {
  return TextStyle(
    fontSize: AppSizes.size14,
    color: Colors.black,
    fontWeight: val ? FontWeight.w800 : FontWeight.normal,
  );
}

tabText(text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 14),
    textAlign: TextAlign.center,
  );
}

playerinfocenter(String text, TextStyle style) {
  return Text(
    text,
    style: style,
    textAlign: TextAlign.center,
  );
}

GlobalText(text, fontSize, fontWeight, color) {
  return Text(
    text,
    maxLines: 1,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      letterSpacing: 0.2,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

GlobalText1(text, fontSize, fontWeight, color) {
  return Text(
    text,
    maxLines: 2,
    textAlign: TextAlign.start,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      letterSpacing: 0.2,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

globalText2(text, fontSize, fontWeight, color) {
  return SizedBox(
    width: 30,
    child: Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.end,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        letterSpacing: 0.2,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}
