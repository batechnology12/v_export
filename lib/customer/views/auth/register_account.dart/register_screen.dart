import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/auth_controller.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';
import 'accounts/business_account_container.dart';
import 'accounts/personal_account_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authController = Get.find<AuthController>();
  bool ischeck = false;

  bool ishide = false;
  bool confirnhide = false;
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kblue,
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  offset: Offset(0.0, 0.75),
                                  blurRadius: 5,
                                  color: AppColors.kgrey)
                            ],
                            color: AppColors.kwhite,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(17),
                                topRight: Radius.circular(17))),
                      ))
                ],
              ),
              Positioned(
                  top: 40,
                  left: 15,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create account',
                          style: primaryfont.copyWith(
                              fontSize: 19.7.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.kwhite),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'Please create your account to register',
                            style: primaryfont.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.kwhite),
                          ),
                        ),
                      ],
                    ),
                  )),
              if (authController.containerindex.value == 0)
                Positioned(
                    top: 180,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 600,
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ksizedbox30,
                              PersonalAccount(),
                            ],
                          ),
                        ],
                      ),
                    )),
              if (authController.containerindex.value == 1)
                Positioned(
                    top: 180,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 600,
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ksizedbox30,
                              BusinessAccount(),
                              // ksizedbox10,
                            ],
                          ),
                        ],
                      ),
                    )),
              Positioned(
                top: size.height * .15,
                left: 10,
                right: 10,
                child: Container(
                  height: 60.h,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(35)),
                  child: Center(
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              authController.containerindex(0);
                              authController.update();
                            },
                            child: Container(
                              height: 48.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  color:
                                      authController.containerindex.value == 0
                                          ? AppColors.kblue
                                          : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                'Personal Account',
                                style: primaryfont.copyWith(
                                    color:
                                        authController.containerindex.value == 0
                                            ? AppColors.kwhite
                                            : Colors.black,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              authController.containerindex(1);
                              authController.update();
                            },
                            child: Container(
                              height: 48.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                  color:
                                      authController.containerindex.value == 1
                                          ? AppColors.kblue
                                          : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                'Business Account',
                                style: primaryfont.copyWith(
                                    color:
                                        authController.containerindex.value == 1
                                            ? AppColors.kwhite
                                            : Colors.black,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
