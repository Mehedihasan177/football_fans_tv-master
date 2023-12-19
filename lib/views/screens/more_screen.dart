// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '/controllers/auth_controller.dart';
import '/models/user.dart';
import '/views/dialogs/language_dialog.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/setting _controller.dart';
import '../../utils/widgets.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  ColorController colorController = Get.find();
  SettingController settingsController = Get.put(SettingController());
  AuthController authController = Get.find();
  HomeController homeController = Get.find();

  setting() {
    return settingsController.settings.value;
  }

  @override
  void initState() {
    // print("${settingsController.currentLanguage.value} language");
    // print("${settingsController.language.value} language");
    super.initState();
  }

  rate() async {
    if (GetPlatform.isAndroid) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      launchURL(
          'https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
    } else {
      // launchURL(setting().iosAppRatingLink);
    }
  }

  share() async {
    if (GetPlatform.isAndroid) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Share.share(
          'Please install this app and stay safe , AppLink : https://play.google.com/store/apps/details?id=${packageInfo.packageName}',
          subject: 'Look what we made!');
    } else {
      Share.share(
          'Please install this app and stay safe , AppLink : ${setting().iosShareLink}',
          subject: 'Look what we made!');
    }
  }

  mail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mail@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Support mail',
      }),
    );

    launch(emailLaunchUri.toString());
  }

  privacy() => launchURL(setting().privacyPolicy);

  facebook() => launchURL(setting().facebook);

  youtube() => launchURL(setting().youtube);

  telegram() => launchURL(setting().telegram);

  // registration() => Get.to(() => const RegistrationScreen());

  language() => languageDialog(Get.context!);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Obx(
                  //   () => Visibility(
                  //       visible: !registrationController.logged.value,
                  //       child: Column(children: [
                  //         customRow(Icons.app_registration, 'Register',
                  //             registration),
                  //         dividerContainer(),
                  //       ])),
                  // ),

                  customRow("LANGUAGE", language, Icons.arrow_forward_ios),
                  const SizedBox(height: 3),
                  customRow("NOTIFICATION"),
                  const SizedBox(height: 3),
                  customRow("SUBSCRIPTION HISTORY", share),
                  const SizedBox(height: 3),
                  customRow('PRIVACY & POLICY', privacy),
                  const SizedBox(height: 3),
                  customRow('TERMS AND CONDITIONS', privacy),
                  const SizedBox(height: 3),
                  customRow('SHARE APP', share),
                  const SizedBox(height: 3),
                  customRow('RATE APP', rate),
                  const SizedBox(height: 30),
                  // Container(
                  //   height: 100,
                  //   child: Stack(
                  //     children: [
                  //       ...List.generate(
                  //           10,
                  //           (index) => Builder(builder: (context) {
                  //                 left = left + 15.0;
                  //                 return Positioned(
                  //                   left: left,
                  //                   top: 0,
                  //                   child: Container(
                  //                     clipBehavior: Clip.antiAliasWithSaveLayer,
                  //                     width: 25,
                  //                     height: 25,
                  //                     decoration: BoxDecoration(
                  //                         borderRadius:
                  //                             BorderRadius.circular(10),
                  //                         border:
                  //                             Border.all(color: Colors.white),
                  //                         color: Colors.red),
                  //                     child: Image.asset(AppAssets.team),
                  //                   ),
                  //                 );
                  //               }))
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          //    buildBody(),
        ],
      ),
    );
  }
}

buildBody() {
  AuthController authController = Get.find();
  User user = authController.user.value;
  if (user != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: user.image ?? "",
        ),
        Text(user.name ?? ''),
        Text(user.email ?? ""),
      ],
    );
  }
}

iconContainer(IconData icon, [Function()? ontap]) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(100)),
      child: Icon(
        icon,
        size: 25,
        color: AppColors.white,
      ),
    ),
  );
}

customRow(String text, [Function()? ontap, IconData? icon]) {
  HomeController homeController = Get.find();
  return InkWell(
    onTap: ontap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                text.tr,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppSizes.size15,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          // if (text == "LANGUAGE")
          //   Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: Text(
          //       settingController.currentLanguage.value,
          //       style: TextStyle(
          //           color: Colors.white.withOpacity(.3),
          //           fontSize: AppSizes.size12,
          //           fontWeight: FontWeight.normal),
          //     ),
          //   )

          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          if (text == "NOTIFICATION")
            ObxValue(
              (data) => SizedBox(
                height: AppSizes.newSize(2),
                child: Switch(
                  value: homeController.notificationscontroller.value,
                  focusColor: AppColors.bottomNavBlueColor,
                  onChanged: (val) {
                    homeController.storeprefs(val);
                    //print(val);

                    OneSignal.shared.disablePush(!val);
                  },
                  activeColor: Colors.white,
                ),
              ),
              false.obs,
            ),
        ],
      ),
    ),
  );
}

dividerContainer() {
  return Container(
    margin: const EdgeInsets.only(right: 15, left: 10),
    height: .1,
    color: AppColors.white,
  );
}
