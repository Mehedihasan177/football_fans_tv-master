import 'package:connectivity/connectivity.dart';

import '/models/fixtures.dart';
import '/models/squads.dart';
import '/models/team_stats.dart';
import 'package:get/get.dart';

import '../models/main_news.dart';
import '../models/team_transfer.dart';
import '../services/VpnService.dart';
import '../services/api_services.dart';
import '../utils/widgets.dart';

class TeamController extends GetxController {
  var allnews = <MainNews>[].obs;
  var fixtures = Fixtures().obs;
  var squad = SquadList().obs;
  var stats = TeamStats().obs;
  var tranfers = TeamTransfers().obs;
  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;
  RxBool isLoading3 = true.obs;
  RxBool isLoading4 = true.obs;
  RxBool isLoading5 = true.obs;

  loadTeamFixtures(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadfixtures(url);
      try {
        if (response != Fixtures()) {
          fixtures.value = response;
          //  log(jsonEncode(fixtures));
        } else {
          showSnackBar('Server error! Please try again1.', 2, () {
            loadTeamFixtures(url);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2, () {});
      } finally {
        isLoading2.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {});
    }
  }

  loadteamTransfer(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadTeamTransfers(url);
      try {
        if (response != TeamTransfers()) {
          tranfers.value = response;
          // log(jsonEncode(tranfers));
        } else {
          showSnackBar('Server error! Please try again1.', 2, () {
            loadteamTransfer(url);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2, () {});
      } finally {
        isLoading5.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {});
    }
  }

  loadTeamStats(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadteamstats(url);
      // print(1);
      try {
        if (response != TeamStats()) {
          stats.value = response;
          //  log(jsonEncode(stats));
        } else {
          showSnackBar('Server error! Please try again1.', 2, () {
            loadTeamStats(url);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2, () {});
      } finally {
        isLoading4.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {});
    }
  }

  loadTeamSquads(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadSquads(url);
      try {
        if (response != SquadList()) {
          squad.value = response;
          //    log(jsonEncode(squad));
        } else {
          showSnackBar('Server error! Please try again1.', 2, () {
            loadTeamSquads(url);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2, () {});
      } finally {
        isLoading3.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {});
    }
  }

  loadTeamNews(String name) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadMainNews(name);
      try {
        if (response != <MainNews>[]) {
          allnews.value = response;
        } else {
          showSnackBar('Server error! Please try again1.', 2, () {
            loadTeamNews(name);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2, () {});
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {});
    }
  }
}
