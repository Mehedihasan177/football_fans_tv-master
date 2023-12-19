import 'package:flutter/material.dart';
import '/consts/app_colors.dart';
import 'package:get/get.dart';

import '/consts/app_sizes.dart';
import '../../models/live_matches.dart';
import '../screens/watch_screen.dart';

watchDialog(context, List<StreamingSources>? streamingSources) async {
  // bool checkedValue;
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();

  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.appColor,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Streaming Sources'.toUpperCase(),
                      style: TextStyle(
                        fontSize: AppSizes.size16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: AppSizes.newSize(25),
                      child: ListView.builder(
                          itemCount: streamingSources?.length ?? 0,
                          itemBuilder: (context, index) =>
                              streamRows(streamingSources![index])),
                    ),
                    // Column(
                    //   children: [
                    //     ...streamingSources!.map((e) => streamRows(e)),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.red.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'CLOSE',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: AppSizes.size16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}

streamRows(StreamingSources e) {
  return InkWell(
    onTap: () {
      var arguments = {
        'source': e,
        'stream_url': e.streamUrl,
        'title': "Live Video",
        'stream': true,
      };
      Get.back();
      Get.to(() => WatchScreen(arguments));
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(.3), width: .5),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding:
                const EdgeInsets.only(top: 2, bottom: 2, left: 4, right: 4),
            child: const Icon(
              Icons.play_circle_filled,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            e.streamTitle ?? "",
            style: TextStyle(
                fontSize: AppSizes.size14,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    ),
  );
}
