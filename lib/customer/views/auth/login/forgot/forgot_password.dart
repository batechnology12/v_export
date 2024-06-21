import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../constant/app_colors.dart';
import '../../../../../constant/app_font.dart';
import '../../register_account.dart/register_screen.dart';
import 'verified_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var mobileController = TextEditingController();

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
            size: 19.sp,
          ),
        ),
        title: Text(
          'Forget Password',
          style: primaryfont.copyWith(
              color: Colors.black,
              fontSize: 19.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ksizedbox30,
            Center(
                child:
                    SvgPicture.asset('assets/images/forgotpasswrdimage.svg')),
            ksizedbox10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'First, let"s find your account',
                  style: primaryfont.copyWith(
                      fontSize: 21.sp, fontWeight: FontWeight.w700),
                ),
                ksizedbox5,
                Text(
                  'Please enter your email or phone',
                  style: primaryfont.copyWith(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                ksizedbox40,
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the mobile number or Email ID';
                      } else {
                        return null;
                      }
                    },
                    controller: mobileController,
                    decoration: InputDecoration(
                      hintText: "Enter Mobile Number or Email ID",
                      hintStyle: primaryfont.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff7C86A2)),
                      contentPadding: EdgeInsets.only(bottom: 5, left: 10),
                      fillColor: Color(0xffF8F8F8),
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Container(
          height: 120.h,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Get.to(VerifiedPasswordScreen());
                  }
                },
                child: Container(
                  height: 50.h,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: AppColors.kblue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Reset Password',
                      style: fourthfont.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kwhite),
                    ),
                  ),
                ),
              ),
              ksizedbox10,
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Don't have an account? ",
                      style: primaryfont.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp)),
                  TextSpan(
                      text: 'Create Account',
                      style: primaryfont.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: 15.sp,
                          color: AppColors.kblue,
                          fontWeight: FontWeight.w500))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
