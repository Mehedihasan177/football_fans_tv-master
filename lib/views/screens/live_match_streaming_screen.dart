import 'package:flutter/material.dart';
import '/consts/app_assets.dart';
import '/models/live_matches.dart';
import 'package:get/get.dart';

import '../../consts/app_colors.dart';
import '../../controllers/live_match_stream_controller.dart';
import '../widgets/home_live_match_streaming_widget.dart';

class LiveMatchStreamingScreen extends StatefulWidget {
  final Data liveMatchs;
  const LiveMatchStreamingScreen(this.liveMatchs, {Key? key}) : super(key: key);

  @override
  State<LiveMatchStreamingScreen> createState() =>
      _LiveMatchStreamingScreenState();
}

class _LiveMatchStreamingScreenState extends State<LiveMatchStreamingScreen> {
  LiveMatchStreamController liveMatchStreamController = Get.find();
  @override
  void initState() {
    liveMatchStreamController.loadLiveMatchList(widget.liveMatchs.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    liveMatchStreamController.cdispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.appColor,
          elevation: 0,
          title: Text("Live Stream".tr),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppAssets.backgroundImage))),
          child: Obx(() => !liveMatchStreamController.isloading.value &&
                  liveMatchStreamController.liveMatch.value.data!.isNotEmpty
              ? ListView.builder(
                  itemCount:
                      liveMatchStreamController.liveMatch.value.data?.length ??
                          0,
                  itemBuilder: (context, index) {
                    var data =
                        liveMatchStreamController.liveMatch.value.data![index];
                    return HomeLiveMatchStreaming(data, widget.liveMatchs);
                  })
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.bottomNavBlueColor,
                  ),
                )),
        ));
  }
}
