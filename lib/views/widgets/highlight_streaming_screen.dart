import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/consts/app_assets.dart';
import 'package:get/get.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../consts/style.dart';
import '../../controllers/live_match_stream_controller.dart';
import '../../models/highlight_model.dart';
import '../screens/watch_screen.dart';

class HighlightStreamingScreen extends StatefulWidget {
  final HighLight highLightData;
  const HighlightStreamingScreen(this.highLightData, {Key? key})
      : super(key: key);

  @override
  State<HighlightStreamingScreen> createState() =>
      _HighlightStreamingScreenState();
}

class _HighlightStreamingScreenState extends State<HighlightStreamingScreen> {
  LiveMatchStreamController liveMatchStreamController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.league.withOpacity(0.5),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.transparent.withOpacity(0.9), BlendMode.dstATop),
          image: const AssetImage(AppAssets.backgroundImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: AppSizes.newSize(7),
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          title: Text("HIGHLIGHTS".tr),
          centerTitle: true,
        ),
        body: Container(
          padding: PaddingStyle.containerpadding,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 2),
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  // log(streamingSources[index].streamUrl.toString());
                  var arguments = {
                    'data': widget.highLightData,
                    'source': widget.highLightData.streamingSources,
                    'title': widget
                        .highLightData.streamingSources![index].streamTitle,
                    'stream_url':
                        widget.highLightData.streamingSources![0].streamUrl,
                    'stream': false,
                  };
                  Get.to(() => WatchScreen(arguments));
                },
                child: Card(
                  color: AppColors.league.withOpacity(0.45),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                widget.highLightData.streamingSources![index]
                                    .streamTitle
                                    .toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppSizes.size15),
                                // style: AppStyles.matchtext,
                              ),
                              Text(
                                '${widget.highLightData.teamOneName} VS  ${widget.highLightData.teamTwoName}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppSizes.size13),
                              ),
                              const SizedBox(height: 4)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: AppColors.appColor,
                            ),
                            child: Center(
                              child: Text('Watch Highlights'.tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            itemCount: widget.highLightData.streamingSources?.length ?? 0,
          ),
        ),
      ),
    );
  }
}
