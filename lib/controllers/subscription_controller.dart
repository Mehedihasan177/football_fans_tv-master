import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import '/services/api_services.dart';
import '/services/inapp_purchase_service.dart';
import '/services/vpnService.dart';
import '/models/subscription.dart';
import '/controllers/auth_controller.dart';
import '/models/payment.dart' as p;
import '/models/user.dart';
import '/utils/helpers.dart';
import '/views/screens/parent_screen.dart';
import 'package:get/get.dart';

import 'setting _controller.dart';

class SubscriptionController extends GetxController {
  SettingController settingController = Get.find();
  AuthController authController = Get.find();
  int numLoadAttempts = 5;
  RxBool isLoading = false.obs;
  RxBool isLoading2 = false.obs;
  RxBool isLoading3 = false.obs;
  RxList<Data> subscriptions = <Data>[].obs;
  RxList<IAPItem> products = <IAPItem>[].obs;
  RxList<PurchasedItem> restoreProducts = <PurchasedItem>[].obs;
  Rx<p.Payment> payment = p.Payment().obs;

  loadSubscriptions() async {
    isLoading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadSubscriptions();
        if (response.status == true) {
          subscriptions.value = response.data!;
          if (subscriptions.isEmpty && numLoadAttempts <= 5) {
            loadSubscriptions();
            numLoadAttempts--;
          }
          if (subscriptions.isNotEmpty) {
            List<String> productIds =
                subscriptions.map((e) => e.productId!).toList();
            InAppPurchaseService.getProducts(productIds);
          }
        }
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, () {});
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, () {});
    }
  }

  subscriptionUpdate(PurchasedItem purchasedItem) async {
    isLoading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        Data item = subscriptions.firstWhere(
            (element) => element.productId == purchasedItem.productId);
        IAPItem product = products.firstWhere(
            (element) => element.productId == purchasedItem.productId);
        Map data = {
          'subscription_id': item.id.toString(),
          'amount': product.localizedPrice,
          'platform': Platform.isIOS ? 'ios' : 'android',
        };
        var response = await ApiService.subscriptionUpdate(data);
        if (response != {} && response['status'] == true) {
          authController.user.value =
              User.fromJson(response['data'] ?? response['user']);
          settingController.isSubscribed.value = true;
          writeStorage('isRestore', false);
          writeStorage('isCheckRequired', true);
          showToast('Purchase Successfull.');
          Get.offAll(() => const ParentScreen(0));
        } else {
          showToast(response['message'] ?? 'Unknown error.');
        }
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, () {});
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, () {});
    }
  }

  subscriptionExpired() async {
    isLoading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.subscriptionExpired();
        if (response != {} && response['status'] == true) {}
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, () {});
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, () {});
    }
  }

  subscriptionRestore(String productId) async {
    isLoading.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        Map data = {
          'product_id': productId,
        };
        var response = await ApiService.subscriptionRestore(data);
        if (response != {} && response['status'] == true) {
          authController.user.value =
              User.fromJson(response['data'] ?? response['user']);
          settingController.isSubscribed.value = true;
          writeStorage('isRestore', false);
          writeStorage('isCheckRequired', true);
          showToast('Subscription restore successfully.');
          Get.offAll(() => const ParentScreen(0));
        }
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, () {});
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, () {});
    }
  }

  loadPayments() async {
    isLoading3.value = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadPayments();
        if (response.status == true) {
          payment.value = response;
        }
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr, () {});
      } finally {
        isLoading3.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr, () {});
    }
  }

  requestPurchase(IAPItem item) {
    isLoading.value = true;
    InAppPurchaseService.requestPurchase(item);
  }

  requestRestore() async {
    isLoading2.value = true;
    await InAppPurchaseService.requestRestore();
  }

  // @override
  // void onInit() {
  //   super.onInit();

  //   //loadSubscriptions();
  // }
}
