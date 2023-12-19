import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../models/league_fixtures.dart';
import '../models/league_table.dart';
import '../models/league_teams.dart';
import '../models/league_transfer.dart';
import '../models/main_news.dart';
import '../models/team_stats.dart';
import '../services/api_services.dart';
import '../services/vpnService.dart';
import '../utils/widgets.dart';

class LeagueController extends GetxController {
  var allnews = <MainNews>[].obs;
  var fixtures = LeagueFixtureList().obs;
  var table = LeagueTable().obs;
  var stats = TeamStats().obs;
  var transfer = LeagueTransfers().obs;
  var teams = LeagueTeams().obs;
  RxBool isLoading6 = true.obs;
  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;
  RxBool isLoading3 = true.obs;
  RxBool isLoading4 = true.obs;
  RxBool isLoading5 = true.obs;

  cdispose() {
    isLoading6.value = true;
    isLoading.value = true;
    isLoading2.value = true;
    isLoading3.value = true;
    isLoading4.value = true;
    isLoading5.value = true;
  }

  loadLeagueFixtures(String url) async {
    isLoading2.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();

    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadfixturesLeague(url);

      try {
        if (response != LeagueFixtureList()) {
          fixtures.value = response;
          //log(jsonEncode(fixtures));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadLeagueFixtures(url);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
      } finally {
        isLoading2.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadLeagueTable(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadTableLeague(url);

      try {
        if (response != LeagueTable()) {
          table.value = response;
          // log(jsonEncode(table));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadLeagueFixtures(url);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
      } finally {
        isLoading3.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadLeagueStats(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadLeagueStats(url);
      // print(1);
      try {
        if (response != TeamStats()) {
          stats.value = response;
          // log(jsonEncode(stats));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadLeagueStats(url);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
      } finally {
        isLoading4.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadLeagueTransfer(String name) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadLeagueTransfer(name);
      try {
        if (response != LeagueTransfers()) {
          transfer.value = response;
          // log(jsonEncode(transfer));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadLeagueTransfer(name);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
      } finally {
        isLoading5.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadMainNews(String name) async {
    isLoading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadMainNews(name);
      try {
        if (response != <MainNews>[]) {
          allnews.value = response;
          //  log(jsonEncode(allnews));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadMainNews(name);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.'.tr, 2, () {});
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadLeagueTeams(String name) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadLeagueTeams(name);
      try {
        if (response != LeagueTeams()) {
          teams.value = response;
          //  log(jsonEncode(teams));
        } else {
          showSnackBar('Server error! Please try again1.', 2, () {
            loadLeagueTeams(name);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2, () {});
      } finally {
        isLoading6.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {});
    }
  }
}
