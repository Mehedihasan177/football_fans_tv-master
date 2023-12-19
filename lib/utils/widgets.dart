// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../consts/app_assets.dart';
import '../consts/app_colors.dart';
import '../consts/app_sizes.dart';

launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // print(url);
    //errorMessage('Could not launch $url');
  }
}

divider(double widt) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: widt, color: AppColors.appColor),
      ),
    ),
  );
}

buttonText(String text, bool bool) {
  return Text(
    text,
    style: bool
        ? const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // decoration: TextDecoration.underline,
            decorationThickness: 3
            //decorationColor: Colors.red
            )
        : const TextStyle(color: Color.fromARGB(255, 214, 213, 213)),
  );
}

buttonText2(String text, bool bool) {
  return Text(text,
      style: bool
          ? const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              // decoration: TextDecoration.underline,
              decorationThickness: 3
              //decorationColor: Colors.red
              )
          : const TextStyle(color: Colors.black87));
}

customborder() {
  return const Border(
    bottom: BorderSide(width: 4, color: Colors.orange),
  );
}

void showSnackBar(String message,
    [int duration = 600, callback, Color c = Colors.grey]) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
          fontSize: AppSizes.size14,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    ),
    backgroundColor: c,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: duration),
    // action: callback != null
    //     ? SnackBarAction(
    //         label: 'Refresh',
    //         textColor: Colors.white,
    //         onPressed: () {
    //           ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
    //           callback();
    //         },
    //       )
    //     : null,
  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}

// SettingController settingController = Get.find();

// customButton(String text, int progres) {
//   return Center(
//     child: settingController.currentLanguage.value == "English"
//         ? Container(
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             padding: const EdgeInsets.symmetric(vertical: 11),
//             decoration: BoxDecoration(
//                 color: AppColors.appColor,
//                 borderRadius: BorderRadius.circular(100)),
//             width: Get.width * .4,
//             child: Center(
//               child: progres == 1
//                   ? const SizedBox(
//                       height: 22,
//                       width: 22,
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   : Text(
//                       text,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: AppSizes.size20,
//                           fontWeight: FontWeight.bold),
//                     ),
//             ),
//           )
//         : Container(
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             padding: const EdgeInsets.symmetric(vertical: 11),
//             decoration: BoxDecoration(
//                 color: AppColors.appColor,
//                 borderRadius: BorderRadius.circular(100)),
//             width: Get.width * .4,
//             child: Center(
//               child: progres == 1
//                   ? const SizedBox(
//                       height: 26,
//                       width: 26,
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   : Text(
//                       text,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: AppSizes.size20,
//                           fontWeight: FontWeight.bold),
//                     ),
//             ),
//           ),
//   );
// }

cachedNetworkImageMaker(image, containerHeight, containerWidth, height, width,
    plachholderheight, plachholderWidth) {
  return Container(
    height: AppSizes.newSize(containerHeight),
    width: AppSizes.newSize(containerWidth),
    decoration: BoxDecoration(
      color: Colors.transparent,
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withOpacity(0.2),
      //     offset: const Offset(2.0, 2.0),
      //     blurRadius: 2.0,
      //     spreadRadius: 2.0,
      //   ), //BoxShadow
      //   BoxShadow(
      //     color: Colors.black.withOpacity(0.2),
      //     offset: const Offset(-2.0, -2.0),
      //     blurRadius: 2.0,
      //     spreadRadius: 2.0,
      //   ),
      // ],
      borderRadius: BorderRadius.circular(0),
      // border: Border.all(),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: image,
        height: AppSizes.newSize(height),
        width: AppSizes.newSize(width),
        errorWidget: (context, url, error) {
          return Image.asset(AppAssets.team);
        },
        placeholder: (context, url) => Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: SizedBox(
            height: AppSizes.newSize(plachholderheight),
            width: AppSizes.newSize(plachholderWidth),
            child: Image.asset(
              AppAssets.mloader,
            ),
          ),
        ),
      ),
    ),
  );
}

cachedNetworkImageMakerFour(image) {
  return SizedBox(
    height: AppSizes.newSize(4),
    width: AppSizes.newSize(4),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: image,
        height: AppSizes.newSize(3),
        width: AppSizes.newSize(3),
        errorWidget: (context, url, error) {
          return Image.asset(AppAssets.team);
        },
        placeholder: (context, url) => Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: SizedBox(
            height: AppSizes.newSize(2),
            width: AppSizes.newSize(2),
            child: Image.asset(
              AppAssets.mloader,
            ),
          ),
        ),
      ),
    ),
  );
}

cachedNetworkImage(image, height, width, placeHolderHeight, placeHolderWidth,
    double borderRadiusAll) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: AppColors.appColor),
        borderRadius: BorderRadius.circular(100)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusAll),
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: SizedBox(
            width: AppSizes.newSize(placeHolderWidth),
            height: AppSizes.newSize(placeHolderHeight),
            child: Image.asset(
              AppAssets.team,
              color: AppColors.appColor,
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          return Image.asset(AppAssets.mloader);
        },
        fit: BoxFit.fill,
        height: AppSizes.newSize(height),
        width: AppSizes.newSize(width),
      ),
    ),
  );
}

cachedNetworkImageMakerTwo(image) {
  return Center(
    child: CachedNetworkImage(
      imageUrl: image,
      height: AppSizes.newSize(6.2),
      width: AppSizes.newSize(6.2),
      errorWidget: (context, url, error) {
        return Image.asset(AppAssets.mloader);
      },
      placeholder: (context, url) => Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: SizedBox(
          height: AppSizes.newSize(2),
          width: AppSizes.newSize(2),
          child: Image.asset(
            AppAssets.team,
          ),
        ),
      ),
    ),
  );
}

cachedNetworkImageMakerThree(image) {
  return Container(
    height: AppSizes.newSize(3.6),
    width: AppSizes.newSize(3.6),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(2.0, 2.0),
          blurRadius: 4.0,
          spreadRadius: 1.0,
        ), //BoxShadow
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(-2.0, -2.0),
          blurRadius: 4.0,
          spreadRadius: 1.0,
        ),
      ],
      borderRadius: BorderRadius.circular(100),
      border: Border.all(width: 1),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: image,
        height: AppSizes.newSize(3.6),
        width: AppSizes.newSize(3.6),
        errorWidget: (context, url, error) {
          return Image.asset(AppAssets.mloader);
        },
        placeholder: (context, url) => Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: SizedBox(
            height: AppSizes.newSize(2),
            width: AppSizes.newSize(2),
            child: Image.asset(
              AppAssets.mloader,
            ),
          ),
        ),
      ),
    ),
  );
}

void popupSnackBar() {
  showDialog(
    barrierDismissible: true,
    context: Get.context!,
    builder: (_) => WillPopScope(
        onWillPop: () async => true,
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "To enjoy football match live streaming, you must need to register. Click the below Register Now button."
                              .tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: AppSizes.size14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                          // onTap: () => Get.to(const RegistrationScreen()),
                          child: RichText(
                        text: TextSpan(
                          text: 'Register Now'.tr,
                          style: TextStyle(
                              fontSize: AppSizes.size20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ],
                  ))),
        )),
  );
}

// void languagePopUp() {
//   SettingController settingController = Get.find();
//   showDialog(
//     barrierDismissible: true,
//     context: Get.context!,
//     builder: (_) => WillPopScope(
//         onWillPop: () async => true,
//         child: Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: const EdgeInsets.only(left: 20, right: 20),
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15), color: Colors.white),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15)
//                   .copyWith(top: 10),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ListView.builder(
//                     shrinkWrap: true,
//                     //controller: _scrollController,
//                     itemCount: LocalizationService.langs.length,
//                     itemBuilder: (context, index) {
//                       var data = LocalizationService.langs[index];

//                       return LanguageWidget(
//                         name: data,
//                         isSelected:
//                             data == settingController.currentLanguage.value,
//                         callback: () {
//                           settingController.currentLanguage.value = data;
//                           LocalizationService().changeLocale(data);
//                           Get.back();
//                         },
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )),
//   );
// }

globalTextStyleLeft(text, color, fontSize, fontWeight) {
  return SizedBox(
    height: 20,
    width: double.infinity,
    // color: Colors.red,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      maxLines: 1,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

globalTextStyle4(text, color, fontSize, fontWeight) {
  return SizedBox(
    height: 35,
    width: 200,
    // color: Colors.red,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      maxLines: 2,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

globalTextStyle6(text, color, fontSize, fontWeight) {
  return SizedBox(
    height: 35,
    width: 300,
    // color: Colors.red,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      maxLines: 1,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

globalTextStyle7(text, color, fontSize, fontWeight) {
  return SizedBox(
    height: 35,
    width: 250,
    // color: Colors.red,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      maxLines: 1,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

globalTextStyleOne(text, color, fontSize, fontWeight) {
  return Text(text,
      style: GoogleFonts.getFont(
        'Barlow',
        textStyle: TextStyle(
          color: color,
          letterSpacing: .5,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ));
}

globalTextStyle5(text, color, fontSize, fontWeight) {
  return SizedBox(
    height: 20,
    width: double.infinity,
    // color: Colors.red,
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        maxLines: 1,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}

globalTextStyleTwo(text, color, fontSize, fontWeight) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    maxLines: 2,
    textAlign: TextAlign.start,
    overflow: TextOverflow.ellipsis,
  );
}

globalTextStyleTime(text, color, fontSize, fontWeight) {
  return SizedBox(
    height: 20,
    width: 80,
    // color: Colors.red,
    child: Center(
      child: Text(
        DateFormat('h:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(
            int.parse(text ?? '') * 1000,
          ),
        ),
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        maxLines: 2,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}

dd(object) {
  if (kDebugMode) print(object);
}

int timeDiff(String matchTimestamp) {
  int diff = 0;

  final matchTimeStamp = int.parse(matchTimestamp);
  final DateTime date1 =
      DateTime.fromMillisecondsSinceEpoch(matchTimeStamp * 1000);
  final DateTime dateNow = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch);

  diff = date1.difference(dateNow).inMinutes;

  return diff;
}
