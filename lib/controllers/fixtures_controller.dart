// import 'dart:convert';
// import 'dart:developer';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../models/live_matches.dart';
// import '../models/match_schedule.dart';
// import '../services/VpnService.dart';
// import '../services/api_services.dart';
// import '../utils/widgets.dart';

// class FixturesController extends GetxController {
//   Rx<DateTime> selectedValue = DateTime.now().obs;
//   RxList<RexFix> schedule = <RexFix>[].obs;
//   RxBool isLoading = true.obs;

//   loadLeagues() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     var vpnResult = await CheckVpnConnection.isVpnActive();
//     if (connectivityResult != ConnectivityResult.none && !vpnResult) {
//       try {
//         String date = DateFormat('yyyyMMdd').format(selectedValue.value);
//         var response = await ApiService.loadFootballSchedule(date);

//         schedule.value = response.rexFix!;
//         log(jsonEncode(response.rexFix!));

//         isLoading.value = false;
//       } catch (e) {
//         // print(e);

//         showSnackBar(
//           'Server error! Please try again.111qq',
//           2,
//           () {
//             loadLeagues();
//           },
//         );
//       }
//     } else {
//       showSnackBar(
//         'No internet connection please try again!',
//         2,
//         () {
//           loadLeagues();
//         },
//       );
//     }
//   }
// }
