import 'package:connectivity/connectivity.dart';

import 'package:get/get.dart';

import '../models/standings.dart';

import '../services/vpnService.dart';
import '../services/api_services.dart';
import '../utils/widgets.dart';

class StandingsController extends GetxController {
  RxBool isLoading = true.obs;
  var leaguenames = LeagueModel().obs;
  RxString query = ''.obs;
  var searchResult = <League>[].obs;
  onSearchTextChanged(String text) async {
    query.value = text;
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    for (var data in leaguenames.value.league!) {
      if (data.name!.toLowerCase().contains(text) ||
          data.name!.toUpperCase().contains(text)) searchResult.add(data);
    }
    // print(jsonEncode(searchResult));
  }

  loadLeagues() async {
    isLoading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadStandings();
      try {
        if (response != LeagueModel()) {
          leaguenames.value = response;

          //  log(jsonEncode(leaguenames));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            loadLeagues();
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
}
