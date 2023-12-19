import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/controllers/setting%20_controller.dart';
import '/utils/widgets.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';

class NewsDetailsWebview extends StatefulWidget {
  final Map arguments;
  const NewsDetailsWebview(this.arguments, {Key? key}) : super(key: key);

  @override
  State<NewsDetailsWebview> createState() => _NewsDetailsWebviewState();
}

class _NewsDetailsWebviewState extends State<NewsDetailsWebview> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  SettingController settingController = Get.find();

  //--------Banner Ads Imp---------//

  //--------Banner Ads End---------//

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    settingController.isLoading2.value = true;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  ColorController colorController = Get.find();
  @override
  Widget build(BuildContext context) {
    // if (!_loadingAnchoredBanner) {
    //   _loadingAnchoredBanner = true;
    //   _createAnchoredBanner(context);
    // }
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: AppColors.appColor.withOpacity(0.95),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: Text(
          'News Details'.tr,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.size18),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.arguments['webview'],
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              if (kDebugMode) {
                print("WebView is loading (progress : $progress%)");
              }
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              if (kDebugMode) {
                print('allowing navigation to $request');
              }
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              settingController.isLoading2.value = true;
              if (kDebugMode) {
                print('Page started loading: $url');
              }
            },
            onPageFinished: (String url) {
              settingController.isLoading2.value = false;
              if (kDebugMode) {
                print('Page finished loading: $url');
              }
            },
            gestureNavigationEnabled: true,
          ),
          Obx(() {
            return settingController.isLoading2.value == true
                ? const Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox();
          })
        ],
      ),
      // bottomNavigationBar: const CustomBannerAd(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          showSnackBar(message.message);
        });
  }
}
