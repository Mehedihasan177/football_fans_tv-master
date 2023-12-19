import 'dart:math';

import 'package:connectivity/connectivity.dart';
import '/models/promotion.dart';
import '/services/api_services.dart';
import '/services/vpnService.dart';
import '/utils/widgets.dart';
import 'package:get/get.dart';

class PromotionController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<PromotionData> promotions = <PromotionData>[].obs;

  PromotionData get promotion {
    final random = Random();
    return promotions[random.nextInt(promotions.length)];
  }

  loadPromotions() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadPromotions();

        promotions.value = response.data!;
        isLoading.value = false;
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, 2, () {});
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadPromotions();
  }
}
