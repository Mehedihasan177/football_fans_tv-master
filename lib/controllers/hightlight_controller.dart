import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../models/highlight_model.dart';
import '../services/VpnService.dart';
import '../services/api_services.dart';
import '../utils/widgets.dart';

class HighlightController extends GetxController {
  var isLoading = false.obs;
  var highlight = HighlightModel().obs;

  loadHighlight() async {
    isLoading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadHighlight();
      try {
        if (response != HighlightModel()) {
          highlight.value = response;

          //  log(jsonEncode(highlight.value));
        } else {
          showSnackBar('Server error! Please try again.'.tr, 2, () {
            HighlightModel();
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
