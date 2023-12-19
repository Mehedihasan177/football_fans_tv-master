import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/consts/app_sizes.dart';
import '/consts/textstyle.dart';
import '/controllers/auth_controller.dart';
import '/services/google_auth_service.dart';
import '/utils/helpers.dart';
import '/views/screens/auth/register_screen.dart';
import '../../../consts/app_assets.dart';
import '../../../consts/app_colors.dart';
import 'textbox_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.find();
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
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizes.newSize(10)),
                  Center(
                    child: Image.asset(
                      AppAssets.textlogo,
                      width: AppSizes.newSize(30),
                    ),
                  ),
                  SizedBox(height: AppSizes.newSize(2)),
                  Center(
                      child: Text(
                    "Sign in".tr.toUpperCase(),
                    style: TextStyle(
                        fontSize: AppSizes.size18,
                        color: Colors.white.withOpacity(.8)),
                  )),
                  SizedBox(height: AppSizes.newSize(4)),
                  TextboxWidget(
                    title: 'Email'.tr,
                    controller: mailController,
                    hintText: 'Enter your email address.'.tr,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: AppSizes.newSize(1)),
                  TextboxWidget(
                    title: "Password".tr,
                    controller: passwordController,
                    hintText: "Enter your password".tr,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  SizedBox(height: AppSizes.newSize(0.75)),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot Password'.tr,
                        style: TextStyle(
                          fontSize: AppSizes.size14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.newSize(2)),
                  InkWell(
                    onTap: () {
                      if (mailController.text.isEmail &&
                          passwordController.text.isNotEmpty) {
                        Map data = {
                          'email': mailController.text,
                          'password': passwordController.text,
                          'provider': 'email',
                        };

                        authController.signIn(data);
                      } else {
                        showToast("Please enter valid Email and Password".tr);
                      }
                    },
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: AppColors.bottomNavBlueColor.withOpacity(.3),
                      ),
                      child: Obx(() {
                        return authController.isLoading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.textfieldColor,
                                ),
                              )
                            : Text(
                                'Login'.tr,
                                style: TextStyle(
                                  fontSize: AppSizes.size18,
                                  color: Colors.white,
                                ),
                              );
                      }),
                    ),
                  ),
                  SizedBox(height: AppSizes.newSize(2.5)),
                  Center(
                    child: Text(
                      'or'.tr,
                      style: TextStyle(
                        fontSize: AppSizes.size14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.newSize(2.5)),
                  Container(
                    height: AppSizes.newSize(5),
                    margin: const EdgeInsets.only(top: 10, bottom: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade800,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'G',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              GoogleAuthService().signIn();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade600,
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Login with Google'.tr,
                                style: TextStyle(
                                  fontSize: AppSizes.size15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.newSize(1)),
                  if (Platform.isIOS)
                    Container(
                      height: AppSizes.newSize(5),
                      margin: const EdgeInsets.only(top: 5, bottom: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'A',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Login with Apple'.tr,
                                  style: TextStyle(
                                    fontSize: AppSizes.size15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: AppSizes.newSize(2.5)),
                  InkWell(
                    onTap: () {
                      Get.to(() => const RegisterScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Don\'t have an account ?'.tr,
                            style: CustomtextStyle.maintext2,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Register'.tr,
                            style: CustomtextStyle.maintext2.copyWith(
                              fontSize: AppSizes.size14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
