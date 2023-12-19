import 'package:flutter/material.dart';
import '/consts/app_sizes.dart';
import 'package:get/get.dart';

noRestoreProductsDialog() {
  Future.delayed(Duration.zero, () {
    BuildContext context = Get.context!;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              width: Get.size.width - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.blueGrey,
                                width: 0.3,
                              ),
                            ),
                          ),
                          child: Text(
                            'Purchase Status'.tr,
                            style: TextStyle(
                              fontSize: AppSizes.size18,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            'There are no restorable purchases. Only previously bought non-consumable products and auto-renewable subscriptions Can be restored.'
                                .tr,
                            style: TextStyle(
                              fontSize: AppSizes.size15,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                color: Colors.blueGrey,
                                width: 0.3,
                              ),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              'OK, Got It'.tr,
                              style: TextStyle(
                                fontSize: AppSizes.size18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  });
}
