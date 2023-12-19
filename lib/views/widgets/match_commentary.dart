import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/matchdetails_controller.dart';
import '../../models/commentary.dart';

class MatchCommentary extends StatefulWidget {
  const MatchCommentary({Key? key}) : super(key: key);

  @override
  State<MatchCommentary> createState() => _MatchCommentaryState();
}

class _MatchCommentaryState extends State<MatchCommentary> {
  MatchDetailsController matchDetailsController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(matchDetailsController.commentary.value.commentary?.length.toString() ??
    //     "");
    // log(matchDetailsController.commentary.value.keyCommentary?.length
    //         .toString() ??
    //     "");
    return Obx(
      () => Container(
        child: !matchDetailsController.ismatchCommentaryLoading.value
            ? ((matchDetailsController.commentary.value.commentary?.length ??
                        0) <
                    1)
                ? (matchDetailsController
                                .commentary.value.keyCommentary?.length ??
                            0) >
                        0
                    ? ListView(
                        children: [
                          const SizedBox(height: 10),
                          ...matchDetailsController
                              .commentary.value.keyCommentary!
                              .map((e) => CommentaryWidget(commentary: e))
                        ],
                      )
                    : SizedBox(
                        height: AppSizes.newSize(40),
                        child: Center(
                          child: Text(
                            'No Commentary Found'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.size14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                : ListView(
                    children: [
                      const SizedBox(height: 10),
                      ...matchDetailsController.commentary.value.commentary!
                          .map((e) => CommentaryWidget(commentary: e))
                    ],
                  )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
      ),
    );
  }
}

class CommentaryWidget extends StatelessWidget {
  const CommentaryWidget({
    Key? key,
    required this.commentary,
  }) : super(key: key);

  final Commentary commentary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Row(
            children: [
              Text(
                '${commentary.timeStamp!} | ',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppSizes.size13,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(width: 10),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  commentary.gameDetails!,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppSizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const Divider())
      ],
    );
  }
}
