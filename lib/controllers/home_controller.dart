import 'dart:convert';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import '/models/completed_matches.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/home_details.dart';
import '../models/home_live_matches.dart';
import '../models/home_news_details.dart';
import '../models/live_matches.dart';
import '../models/match_schedule.dart';
import '../models/prediction.dart';
import '../services/vpnService.dart';
import '../services/api_services.dart';
import '../utils/widgets.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class HomeController extends GetxController {
  var isloadinghome = true.obs;
  var isloadinglive = true.obs;
  var isloadingdet = true.obs;
  var isloadingmatches = true.obs;
  var leagueAndTeamIndex = 0.obs;
  var liveMatchIndex = 0.obs;
  var homelivematches = HomeLiveMatches().obs;
  var homeDetails = HomeDetails().obs;
  var livematches = LiveMatches().obs;
  var homenewsdetail = HomeNewsDetails().obs;
  var completedMatches = CompletedMatches().obs;

  RxBool isLoading = true.obs;
  Rx<Prediction> prediction = Prediction().obs;
  RxList<RexFix> schedule = <RexFix>[].obs;
  RxBool isLoadingRex = true.obs;
  RxString type = 'ALL'.obs;

  RxList<Matches> todaysmatches = <Matches>[].obs;
  var notificationscontroller = true.obs;
  loadhomedetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadHome();

        homeDetails.value = response;
        //log(jsonEncode(response));

        isloadinghome.value = false;
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, 2, () {});
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadhomeMatches() async {
    isloadingmatches.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadHomeMatches();

        homelivematches.value = response;
        log(jsonEncode(response));

        isloadingmatches.value = false;
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, 2, () {});
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadLeagues() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        String date = DateFormat('yyyyMMdd').format(DateTime.now());
        var response = await ApiService.loadFootballSchedule(date, type.value);

        schedule.value = response.rexFix!;
        // log(jsonEncode(schedule.value));
        isLoadingRex.value = false;
      } catch (e) {
        showSnackBar(
          'Server error! Please try again.'.tr,
          2,
          () {
            loadLeagues();
          },
        );
      }
    } else {
      showSnackBar(
        'No internet connection please try again!',
        2,
        () {
          loadLeagues();
        },
      );
    }
  }

  loadPrediction() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.laodPrediction();

        prediction.value = response;
        // log(jsonEncode(prediction));
        isLoading.value = false;
      } catch (e) {
        showSnackBar(
          'Server error! Please try again.'.tr,
          2,
          () {
            loadPrediction();
          },
        );
      }
    } else {
      showSnackBar(
        'No internet connection please try again!'.tr,
        2,
        () {
          loadPrediction();
        },
      );
    }
  }

  loadhomelive() async {
    isloadinglive.value = true;

    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadLiveMatches();

        livematches.value = response;
        //   log(jsonEncode(response));

        isloadinglive.value = false;
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, 2, () {});
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadcompletedmatches() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadcompletedmatches();

        completedMatches.value = response;
        //   log(jsonEncode(response));

        isloadingmatches.value = false;
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, 2, () {});
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  storeprefs(val) async {
    final SharedPreferences preferences = await _prefs;
    notificationscontroller.value = val;
    // print(notificationscontroller.value);
    preferences.setBool("notifications", notificationscontroller.value);
  }
}
