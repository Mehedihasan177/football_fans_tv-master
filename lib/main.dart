import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '/controllers/auth_controller.dart';
import '/controllers/hightlight_controller.dart';
import '/controllers/news_controller.dart';
import '/services/localization_service.dart';
import '/views/screens/splash_screen.dart';
import 'controllers/color_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/live_match_stream_controller.dart';
import 'controllers/promotion_controller.dart';
import 'controllers/setting _controller.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();

  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      tagForChildDirectedTreatment: TagForChildDirectedTreatment.unspecified,
      testDeviceIds: <String>[
        "44ED549B19BF3E3821333CDD816044A5",
      ],
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);
  OneSignal.shared.setAppId('0cd20dd6-5cea-4d09-af03-10c68f682f79');
  OneSignal.shared.promptUserForPushNotificationPermission().then(
    (accepted) {
      //print("Accepted permission: $accepted");
    },
  );

  _googleSignIn.signInSilently();
  runApp(
    GetMaterialApp(
      translations: LocalizationService(),
      locale: LocalizationService().getCurrentLocale(),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      title: 'Football Fans TV',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Barlow',
      ),
      // theme: ThemesC.light,
      darkTheme: ThemesC.dark,
      themeMode: ThemeMode.light,
      onInit: () {
        Get.put(SettingController());
        Get.put(AuthController());
        Get.put(NewsController());
        Get.put(HomeController());
        Get.put(LiveMatchStreamController());
        Get.put(HighlightController());
        Get.put(PromotionController());
      },
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HighlightController highlightController = Get.find();
  HomeController homeController = Get.find();
  AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    highlightController.loadHighlight();
    homeController.loadhomeMatches();
    homeController.loadhomelive();

    // initSignal();
  }

  // void initSignal() async {
  //  print(1);

  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     var data = result.notification.additionalData!;

  //     if (data['notification_type'] == 'news') {}

  //     if (data['notification_type'] == 'url') {
  //       launchURL(data['action_url']);
  //     }

  //     if (data['notification_type'] == 'inApp') {}
  //   });

  //   OneSignal.shared
  //       .setInAppMessageClickedHandler((OSInAppMessageAction action) {
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //  key: _scaffoldKey,
      body: SplashScreen(),
    );
  }
}
