import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/customer/views/auth/login/forgot/forgot_password.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';

import '../../../../constant/app_font.dart';
import '../../../../constant/common_container.dart';
import '../../bottom_navi_bar/home_screen.dart';
import '../register_account.dart/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool ishide = false;
  bool isCheck = false;

  var mobileController = TextEditingController();
  var passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formkey,
        child: Container(
          width: double.infinity,
          height: size.height,
          decoration: const BoxDecoration(
            color: AppColors.kblue,
          ),
          child: Column(
            children: [
              Container(
                height: size.height * 0.25,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: SvgPicture.asset(
                      'assets/icons/VEELGO.svg',
                      height: 35.h,
                      width: 35.w,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: size.height,
                  decoration: const BoxDecoration(
                      color: AppColors.kwhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17))),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Welcome Back',
                            style: primaryfont.copyWith(
                                color: Color(0XFF0E0E2C),
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'Please enter your Mobile Number \nto sign in',
                            style: primaryfont.copyWith(
                                color: Color(0XFF0E0E2C),
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Mobile Number*',
                            style: primaryfont.copyWith(
                                color: Color(0xff7C86A2), fontSize: 15.sp),
                          ),
                          ksizedbox5,
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value!.length < 8 || value.length > 8) {
                                return 'Mobile number should be in 8 digits';
                              } else {
                                return null;
                              }
                            },
                            controller: mobileController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 5, left: 20),
                              fillColor: Color(0xffF8F8F8),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Password',
                            style: primaryfont.copyWith(
                                color: Color(0xff7C86A2), fontSize: 15.sp),
                          ),
                          ksizedbox5,
                          TextFormField(
                            obscureText: ishide,
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the valid password for login';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 5, left: 20),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: IconButton(
                                  icon: ishide
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      ishide = !ishide;
                                    });
                                  },
                                ),
                              ),
                              fillColor: Color(0xffF8F8F8),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          ksizedbox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          isCheck = !isCheck;
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 21.h,
                                      width: 21.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: AppColors.kblue),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: isCheck == true
                                          ? Image.asset(
                                              "assets/icons/7-Check.png")
                                          : Text(""),
                                    ),
                                  ),
                                  Ksizedboxw10,
                                  Text(
                                    'Remember me',
                                    style:
                                        primaryfont.copyWith(fontSize: 12.5.sp),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(ForgotPasswordScreen());
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: primaryfont.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.kblue),
                                ),
                              )
                            ],
                          ),
                          ksizedbox40,
                          ksizedbox20,
                          InkWell(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                Get.to(BottomNavigationScreen());
                              }
                            },
                            child: Container(
                              height: 50,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.kblue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: primaryfont.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kwhite),
                                ),
                              ),
                            ),
                          ),
                          ksizedbox20,
                          Center(
                            child: InkWell(
                              onTap: () {
                                Get.to(RegisterScreen());
                              },
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Don't have an account? ",
                                      style: secondoryfont.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.sp)),
                                  TextSpan(
                                      text: 'Sign Up',
                                      style: secondoryfont.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 15.sp,
                                          color: AppColors.kblue,
                                          fontWeight: FontWeight.w500))
                                ]),
                              ),
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
