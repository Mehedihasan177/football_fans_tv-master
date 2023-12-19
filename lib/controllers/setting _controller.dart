// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/setting.dart';
import '../services/api_services.dart';
import '../services/vpnService.dart';
import '../utils/widgets.dart';
import '../views/screens/parent_screen.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class SettingController extends GetxController {
  var isLoading = true.obs;
  var settings = Data().obs;
  var adCount = 0.obs;
  var bannerPlacementId = ''.obs;
  var interstitialPlacementId = ''.obs;
  var appOpenPlacementId = ''.obs;
  var promotionSliderIndex = 0.obs;
  var showRating = true.obs;
  var appPublishingControl = true.obs;
  var isDontShow = false.obs;
  var screenIndex = 1.obs;
  RxString appAddsControl = ''.obs;
  RxString appName = ''.obs;
  var adsCount = 0;
  var isReady = false.obs;
  var watchNow = 0.obs;
  RxString currentLanguage = 'English'.obs;
  RxBool notification = true.obs;
  RxBool adsStatus = false.obs;
  RxBool isLoading2 = true.obs;
  RxInt parentIndex = 0.obs;
  RxBool isSubscribed = false.obs;
  RxString adsType = 'google'.obs;

  @override
  void onInit() {
    super.onInit();
    getValue();
    loadSetting();
  }

  storeValue(language) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("language", language);
  }

  getValue() async {
    final SharedPreferences prefs = await _prefs;
    prefs.getString("language");
    currentLanguage.value =
        prefs.getString("language") ?? currentLanguage.value;

    // print(getLanguages);
  }

  loadSetting() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadsettings();

        settings.value = response.data!;
        store(settings.value);
        //  log(jsonEncode(settings.value));
        Timer(3.seconds, (() => Get.offAll(() => const ParentScreen(2))));
      } catch (e) {
        // showSnackBar('Server Error! Please Try again.'.tr, 2, () {});
      } finally {}
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  void store(Data setting) async {
    var quickSetting = setting;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    settings.value = setting;
    bannerPlacementId.value = Platform.isAndroid
        ? quickSetting.androidGbannerAdsCode ?? ''
        : quickSetting.iosGbannerAdsCode ?? '';
    interstitialPlacementId.value = Platform.isAndroid
        ? quickSetting.androidGinterstitialAdsCode ?? ''
        : quickSetting.iosGinterstitialAdsCode ?? '';
    appOpenPlacementId.value = Platform.isAndroid
        ? quickSetting.androidGappopenAdsCode ?? ''
        : quickSetting.iosGappopenAdsCode ?? '';

    if (Platform.isAndroid) {
      appPublishingControl.value =
          (quickSetting.androidAppPublishingControl ?? 'on') == 'off'
              ? true
              : false;
      appAddsControl.value = setting.androidClickControl ?? '';
    } else {
      appPublishingControl.value =
          (quickSetting.iosAppPublishingControl ?? 'on') == 'off'
              ? true
              : false;
      appAddsControl.value = setting.iosClickControl ?? '';
    }

    appName.value = packageInfo.appName;
  }
  // getAppStatus() {
  //   var box = gs.GetStorage();

  //   var _status2 = box.read('notification') ?? true;
  //   notification.value = _status2;

  //   Future.delayed(const Duration(seconds: 2), () async {
  //     if (_status2) {
  //       OneSignal.shared.disablePush(false);
  //     }
  //   });
  // }

  // changeNotificationStatus() async {
  //   var box = gs.GetStorage();
  //   box.write('notification', !notification.value);
  //   notification.value = !notification.value;

  //   if (notification.value) {
  //     OneSignal.shared.disablePush(false);
  //   } else {
  //     OneSignal.shared.disablePush(true);
  //   }
  // }

  bool showAd() {
    if (!adsStatus.value) return false;
    var setting = settings.value;

    if (Platform.isAndroid) {
      if (setting.androidClickControl != 'off') {
        adCount.value = adCount.value + 1;
        if (adCount.value == int.parse('2')) {
          adCount.value = 0;
          return true;
        }
      }
    } else {
      if (setting.iosClickControl != 'off') {
        adCount.value = adCount.value + 1;
        if (adCount.value == int.parse('2')) {
          adCount.value = 0;
          return true;
        } else {}
      }
    }
    return false;
  }
}
