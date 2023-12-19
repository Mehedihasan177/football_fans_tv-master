import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller.dart';
import '/utils/helpers.dart';
import '/views/screens/auth/textbox_widget.dart';
import '../../../consts/app_assets.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_sizes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController authController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  _register() {
    if ((passwordController.text != confirmPasswordController.text) ||
        (passwordController.text.length < 6 ||
            confirmPasswordController.text.length < 6)) {
      showToast("Please match your password and confirm password".tr);
    } else if (nameController.text.isEmpty) {
      showToast("Enter a valid name".tr);
    } else if (!mailController.text.isEmail) {
      showToast("Enter a valid Mail address".tr);
    } else {
      Map data = {
        'name': nameController.text,
        'email': mailController.text,
        'password': passwordController.text,
        'password_confirmation': passwordController.text,
        'provider': 'email',
      };

      authController.signUp(data);
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
                    "Register".tr.toUpperCase(),
                    style: TextStyle(
                        fontSize: AppSizes.size18,
                        color: Colors.white.withOpacity(.8)),
                  )),
                  SizedBox(height: AppSizes.newSize(4)),
                  TextboxWidget(
                    title: 'Name'.tr,
                    controller: nameController,
                    hintText: 'Enter your Name.'.tr,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: AppSizes.newSize(1)),
                  TextboxWidget(
                    title: 'Email'.tr,
                    controller: mailController,
                    hintText: 'Enter your email address.'.tr,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: AppSizes.newSize(1)),
                  TextboxWidget(
                    title: "Phone Number".tr,
                    controller: phoneController,
                    hintText: "Enter your phone Number".tr,
                    keyboardType: TextInputType.phone,
                    isPassword: false,
                  ),
                  SizedBox(height: AppSizes.newSize(1)),
                  TextboxWidget(
                    title: "Password".tr,
                    controller: passwordController,
                    hintText: "Enter your password".tr,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  SizedBox(height: AppSizes.newSize(1)),
                  TextboxWidget(
                    title: "Confirm Password".tr,
                    controller: confirmPasswordController,
                    hintText: "Enter your password".tr,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  SizedBox(height: AppSizes.newSize(2)),
                  InkWell(
                    onTap: () {
                      _register();
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
                      child: Text(
                        'Register'.tr,
                        style: TextStyle(
                          fontSize: AppSizes.size18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.newSize(2.5)),
                ]),
          ),
        ),
      ),
    );
  }
}
