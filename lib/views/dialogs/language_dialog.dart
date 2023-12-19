import 'package:flutter/material.dart';
import '/consts/app_colors.dart';
import '/controllers/setting%20_controller.dart';
import '/services/localization_service.dart';
import 'package:get/get.dart';

import '/consts/app_sizes.dart';

languageDialog(context) async {
  // bool checkedValue;
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  SettingController settingController = Get.find();
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => true,
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
                      'Change Language'.tr.toUpperCase(),
                      style: TextStyle(
                        fontSize: AppSizes.size16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ...LocalizationService.langs.map((e) => LanguageWidget(
                              isSelected:
                                  e == settingController.currentLanguage.value,
                              name: e,
                              callback: () {
                                //   dd(e);

                                settingController.currentLanguage.value = e;
                                LocalizationService().changeLocale(e);
                                settingController.storeValue(e);
                              },
                            ))
                      ],
                    ),
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
                                'CLOSE'.tr,
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

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    Key? key,
    required this.isSelected,
    required this.name,
    this.callback,
  }) : super(key: key);

  final bool isSelected;
  final String name;
  // ignore: prefer_typing_uninitialized_variables
  final callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ).copyWith(right: 15, left: 5),
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              width: 0.2,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: AppSizes.size16,
                color: Colors.white,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
