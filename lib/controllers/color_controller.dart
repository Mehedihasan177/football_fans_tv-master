// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ColorController extends GetxController {
  RxBool isLightTheme = false.obs;
}

class ThemesC {
  static ThemeData light = ThemeData(
      fontFamily: GoogleFonts.roboto().fontFamily,
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 241, 241, 241),
      accentColor: const Color.fromARGB(255, 239, 239, 239),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.black,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        disabledColor: Colors.grey,
      ));

  static ThemeData dark = ThemeData(
      fontFamily: GoogleFonts.roboto().fontFamily,
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      accentColor: HexColor('#040404'),
      //colorScheme: ColorScheme(secondary: Color.fromARGB(255, 87, 87, 87)),
      iconTheme: const IconThemeData(color: Colors.white),
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: Colors.white),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        disabledColor: Colors.grey,
      ));
}
