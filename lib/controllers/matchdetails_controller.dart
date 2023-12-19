import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../models/commentary.dart';
import '../models/header.dart' as head;
import '../models/lineups.dart';
import '../models/statistics.dart';
import '../services/api_services.dart';
import '../services/vpnService.dart';
import '../utils/widgets.dart';

class MatchDetailsController extends GetxController {
  RxBool ismatchStatsLoading = true.obs;
  RxBool ismatchLineUpsLoading = true.obs;
  RxBool ismatchCommentaryLoading = true.obs;
  RxBool ismatchHeaderLoading = true.obs;
  var commentary = CommentaryList().obs;
  var stats = Statistics().obs;
  var header = head.Header().obs;
  var lineups = LineUps().obs;
  var lineupsB = LineUps().obs;
  var team1form = <List<PlayerList>>[].obs;
  var team2form = <List<PlayerList>>[].obs;

  playerListMaker() {
    if (lineups.value.header1?.t1Text == "" &&
        lineupsB.value.header2?.t1Text == "") {
      lineups.value.header1?.t1Text = "4-3-3";
      lineupsB.value.header2?.t1Text = "4-3-3";
    }

    List<String> formatTeam1 =
        ("1-${lineups.value.header1!.t1Text!}").split('-');
    List<int> team1Formation = formatTeam1.map(int.parse).toList();

    List<String> formatTeam2 =
        ("1-${lineupsB.value.header2!.t1Text!}").split('-');
    List<int> team2Formation = formatTeam2.map(int.parse).toList();

    List<List<PlayerList>> team1final = [];
    List<List<PlayerList>> team2final = [];

    for (int chunk in team1Formation) {
      team1final.add(lineups.value.playerList!.sublist(0, chunk));
      lineups.value.playerList!.removeRange(0, chunk);
    }

    for (int chunk in team2Formation) {
      team2final.add(lineupsB.value.playerList!.sublist(0, chunk));
      lineupsB.value.playerList!.removeRange(0, chunk);
    }
    team1form.value = team1final;
    team2form.value = team2final;
  }

  loadStatistics(String id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();

    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadstats(id);

      try {
        if (response != Statistics()) {
          stats.value = response;
          //  log(stats.value.team?.awayTimg ?? "s");
          // log(jsonEncode(response));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadStatistics(id);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
      } finally {
        ismatchStatsLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadHeader(String id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();

    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadheader(id);

      try {
        if (response != head.Header()) {
          header.value = response;
          //  log(jsonEncode(response));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadStatistics(id);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
      } finally {
        ismatchHeaderLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadlineup(String id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();

    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadlineups(id, 0);
      var responseB = await ApiService.loadlineups(id, 1);

      try {
        if (response != LineUps()) {
          lineups.value = response;
          lineupsB.value = responseB;

          if ((lineups.value.playerList?.length ?? 0) > 0 &&
              (lineupsB.value.playerList?.length ?? 0) > 0) {
            playerListMaker();
          }
        } else {
          // showSnackBar('Server error! Please try again.'.tr, 2, () {
          //   loadlineup(id);
          // });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
        //log(e.toString());
      } finally {
        ismatchLineUpsLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadCommentary(String id) async {
    log(id);
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();

    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadcommentary(id);

      try {
        if (response != CommentaryList()) {
          commentary.value = response;
          //    log(jsonEncode(commentary));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadCommentary(id);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
      } finally {
        ismatchCommentaryLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  cdispose() {
    ismatchStatsLoading.value = true;
    ismatchLineUpsLoading.value = true;
    ismatchCommentaryLoading.value = true;
    ismatchHeaderLoading.value = true;
    commentary.value = CommentaryList();
    stats.value = Statistics();
    header.value = head.Header();
    lineups.value = LineUps();
    lineupsB.value = LineUps();
    team1form.value = <List<PlayerList>>[];
    team2form.value = <List<PlayerList>>[];
  }
}
