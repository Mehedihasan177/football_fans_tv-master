// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/models/live_stream_model.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../services/VpnService.dart';

class WatchScreen extends StatefulWidget {
  static const String route = '/watch_screen';

  final arguments;
  const WatchScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BetterPlayerController? _betterPlayerController;
  // SettingController settingsController = Get.find();

  @override
  void initState() {
    Wakelock.enable();

    load();
    //log(jsonEncode(widget.arguments['source']));
    //print("url ${widget.arguments['stream_url']}");
    super.initState();
  }

  load() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      BetterPlayerConfiguration betterPlayerConfiguration =
          BetterPlayerConfiguration(
        errorBuilder: (BuildContext context, e) {
          Fluttertoast.showToast(
            msg: "This link is not playable, Try another one".tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
            // Do something
          });
          return const SizedBox();
        },
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        looping: true,
        allowedScreenSleep: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSkips: false,
          loadingWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.mloader,
                width: 50,
                height: 50,
              )
            ],
          ),
          enableOverflowMenu: false,
        ),
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ],
        fullScreenAspectRatio: 16 / 9,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        systemOverlaysAfterFullScreen: SystemUiOverlay.values,
      );
      log(widget.arguments['stream_url']);
      if (widget.arguments['stream']) {
        BetterPlayerDataSource dataSource;

        Data source = widget.arguments['data'];
        if (source.streamType == 'root_stream') {
          dataSource = BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            source.streamUrl!,
            liveStream: true,
          );
        } else if (source.streamType == 'm3u8') {
          dataSource = BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            source.streamUrl!,
            liveStream: true,
          );
        } else {
          dataSource = BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            source.streamUrl!,
            liveStream: true,
            headers: source.headers,
          );
        }
        _betterPlayerController =
            BetterPlayerController(betterPlayerConfiguration);
        _betterPlayerController!.setupDataSource(dataSource);
      } else {
        BetterPlayerDataSource dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          widget.arguments['stream_url'],
          liveStream: widget.arguments['stream'],
        );

        _betterPlayerController =
            BetterPlayerController(betterPlayerConfiguration);
        _betterPlayerController!.setupDataSource(dataSource);
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.league.withOpacity(0.5),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.transparent.withOpacity(0.9), BlendMode.dstATop),
          image: const AssetImage('assets/images/backgroundImage.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            widget.arguments['title'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              child: Row(
                children: [
                  const BackButton(
                    color: Colors.white,
                  ),
                  const SizedBox(width: 50),
                  Text(
                    widget.arguments['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: _betterPlayerController != null
                          ? BetterPlayer(controller: _betterPlayerController!)
                          : Image.asset(
                              AppAssets.mloader,
                              width: 20,
                              height: 20,
                            ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.red,
                            ),
                            child: Text(
                              widget.arguments['stream']
                                  ? "LIVE"
                                  : "HIGHLIGHTS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                fontSize: AppSizes.size12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // bottomNavigationBar: const CustomBannerAd(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController?.dispose();
    //_anchoredBanner!.dispose();
    Wakelock.disable();
  }
}
