import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:v_export/customer/controller/auth_controller.dart';

import '../../../../../constant/app_colors.dart';
import '../../../../../constant/app_font.dart';

class RegisterPersonalOtpScreen extends StatefulWidget {
  String mobile;
  RegisterPersonalOtpScreen({super.key, required this.mobile});

  @override
  State<RegisterPersonalOtpScreen> createState() =>
      _VerifiedPasswordScreenState();
}

class _VerifiedPasswordScreenState extends State<RegisterPersonalOtpScreen> {
  var mobileController = TextEditingController();
  final authController = Get.find<AuthController>();
  TextEditingController otpController = TextEditingController();

  String currentText = "";
  bool hasError = false;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 19,
          ),
        ),
        title: Text(
          'Verification',
          style: primaryfont.copyWith(
              color: Colors.black,
              fontSize: 19.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ksizedbox40,
                  Text(
                    'Phone Verification',
                    style: primaryfont.copyWith(
                        fontSize: 28.sp, fontWeight: FontWeight.w600),
                  ),
                  ksizedbox5,
                  RichText(
                    text: TextSpan(
                      text: 'Code is send to ',
                      style: primaryfont.copyWith(
                          fontSize: 15.sp,
                          color: Color(0xff7C86A2),
                          fontWeight:
                              FontWeight.w500), // inherit default text style
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.mobile,
                          style: primaryfont.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.kblue,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  ksizedbox40,
                  ksizedbox40,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: primaryfont.copyWith(
                        color: Color(0xffF8F8F8),
                        // color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: false,
                      obscuringCharacter: '*',
                      animationType: AnimationType.fade,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        if (v!.length < 4) {
                          hasError = true;

                          return "";
                        } else {
                          hasError = false;

                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        selectedFillColor: Color(0xffF8F8F8),
                        activeColor: AppColors.kblue,
                        inactiveColor: Color(0xffF8F8F8),
                        selectedColor: Color(0xffF8F8F8),
                        inactiveFillColor: Colors.grey[200],
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(9),
                        fieldHeight: 60,
                        fieldWidth: 60,
                        activeFillColor:
                            hasError ? Color(0xffF8F8F8) : Color(0xffF8F8F8),
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: primaryfont.copyWith(
                        color: Colors.black,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      enableActiveFill: true,
                      //    errorAnimationController: errorController,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                          hasError = false;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't receive code?",
                        style: primaryfont.copyWith(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(' Request again',
                          style: primaryfont.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kblue))
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 70.h,
                child: Column(
                  children: [
                    Obx(() {
                      return Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        child: authController.personalOtpLoading.isTrue
                            ? Container(
                                height: 50.h,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.kblue,
                                )),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.resgisterPersonalOtpUser(
                                        widget.mobile, otpController.text);
                                  }
                                },
                                child: Container(
                                  height: 50.h,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.kblue,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      'Verify',
                                      style: primaryfont.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.kwhite),
                                    ),
                                  ),
                                ),
                              ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 15, right: 15),
      //   child: Container(
      //     height: 70.h,
      //     child: Column(
      //       children: [
      //         Obx(() {
      //           return Container(
      //             height: 50.h,
      //             width: MediaQuery.of(context).size.width,
      //             child: authController.personalOtpLoading.isTrue
      //                 ? Container(
      //                     height: 50.h,
      //                     width: size.width,
      //                     decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(30)),
      //                     child: Center(
      //                         child: CircularProgressIndicator(
      //                       color: AppColors.kblue,
      //                     )),
      //                   )
      //                 : GestureDetector(
      //                     onTap: () {
      //                       if (formKey.currentState!.validate()) {
      //                         authController.resgisterPersonalOtpUser(
      //                             widget.mobile, otpController.text);
      //                       }
      //                     },
      //                     child: Container(
      //                       height: 50.h,
      //                       width: size.width,
      //                       decoration: BoxDecoration(
      //                           color: AppColors.kblue,
      //                           borderRadius: BorderRadius.circular(30)),
      //                       child: Center(
      //                         child: Text(
      //                           'Verify',
      //                           style: primaryfont.copyWith(
      //                               fontSize: 18.sp,
      //                               fontWeight: FontWeight.w500,
      //                               color: AppColors.kwhite),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //           );
      //         }),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
