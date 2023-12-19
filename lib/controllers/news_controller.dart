import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

import '../models/home_news_details.dart';
import '../models/newslist.dart';
import '../services/api_services.dart';
import '../services/vpnService.dart';
import '../utils/widgets.dart';

class NewsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingOne = true.obs;

  var news = NewsModel().obs;

  var homenewsdetail = HomeNewsDetails().obs;
  RxBool isLoadingnews = true.obs;
  RxBool isLoading2 = true.obs;
  loadNews() async {
    isLoading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      var response = await ApiService.loadnews();

      try {
        news.value = response;
      } catch (e) {
        showSnackBar('Server error! Please try againdd.'.tr, 2, () {});
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, 2, () {});
    }
  }

  loadhomenewsdetail(String url) async {
    homenewsdetail.value = HomeNewsDetails();
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadhomenewsDetails(url);

        homenewsdetail.value = response;
        //log(jsonEncode(response));

        isLoading2.value = false;
      } catch (e) {
        showSnackBar('Server Error! Please Try again.222', 2, () {});
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {});
    }
  }
}
