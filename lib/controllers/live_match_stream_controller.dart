import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../models/live_stream_model.dart';
import '../services/VpnService.dart';
import '../services/api_services.dart';
import '../utils/widgets.dart';

class LiveMatchStreamController extends GetxController {
  final isloading = true.obs;
  var liveMatchStramingIndex = 0.obs;
  final liveMatch = LiveStreamModel().obs;

  cdispose() {
    isloading.value = true;
  }

  loadLiveMatchList(matchid) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadLiveMatchesStraming(matchid);
        if (response != LiveStreamModel()) {
          liveMatch.value = response;

          // log(jsonEncode(response));
          isloading.value = false;
        } else {
          showSnackBar('Server error! Please try again.', 2, () {});
        }
      } catch (e) {
        showSnackBar('Server Error! Please Try again.222', 2, () {});
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {});
    }
  }
}
