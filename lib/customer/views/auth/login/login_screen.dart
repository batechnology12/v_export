import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:svg_flutter/svg_flutter.dart';

import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/customer/controller/auth_controller.dart';
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
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final RoundedLoadingButtonController _btnControllerSucess =
      RoundedLoadingButtonController();

  final authController = Get.find<AuthController>();
  bool ishide = true;
  bool isCheck = false;
  bool isRemember = false;

  var emailOrmobileController = TextEditingController();

  var passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  int selectedIndex = 0;
  String selectedValues = "+65";

  void _onLoginPressed() {
    if (formkey.currentState!.validate()) {
      _btnController.start();
      authController
          .loginApi(
        emailOrmobileNmuber: emailOrmobileController.text,
        password: passwordController.text,
      )
          .then((success) {
        if (success) {
          _btnController.success();
        } else {
          _btnController.error();
        }
      }).catchError((error) {
        _btnController.error();
      }).whenComplete(() {
        // Reset the button controller after some delay
        Future.delayed(Duration(seconds: 2), () {
          _btnController.reset();
        });
      });
    }
  }

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
                            'Mobile Number',
                            style: primaryfont.copyWith(
                                color: Color(0xff7C86A2), fontSize: 15.sp),
                          ),
                          ksizedbox5,
                          TextFormField(
                            keyboardType: TextInputType.phone,
                           
                            inputFormatters: [
                              selectedValues == "+65"
                                  ? LengthLimitingTextInputFormatter(8)
                                  : LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: selectedValues == "+65"
                                ? (value) {
                                    if (value!.length < 8 || value.length > 8) {
                                      return 'Mobile number should be in 8 digits';
                                    } else {
                                      return null;
                                    }
                                  }
                                : (value) {
                                    if (value!.length < 10 ||
                                        value.length > 10) {
                                      return 'Mobile number should be in 10 digits';
                                    } else {
                                      return null;
                                    }
                                  },
                            controller: emailOrmobileController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 13),
                                  child: PopupMenuButton(
                                    child: Container(
                                        height: 30,
                                        width: 50,
                                        child: Text(selectedValues)),
                                    onSelected: (value) {
                                      setState(() {
                                        selectedIndex = value;
                                        selectedValues =
                                            value == 0 ? "+65" : "+91";
                                      });
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem<int>(
                                        value: 0,
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          child: Text("+65"),
                                        ),
                                      ),
                                      PopupMenuItem<int>(
                                        value: 1,
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          child: Text("+91"),
                                        ),
                                      ),
                                    ],
                                  )),
                              contentPadding:
                                  EdgeInsets.only(bottom: 5, left: 20),
                              fillColor: Color(0xffF8F8F8),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
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
                              errorStyle:
                                  primaryfont.copyWith(color: Colors.red),
                              contentPadding:
                                  EdgeInsets.only(bottom: 5, left: 20),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: IconButton(
                                  icon: ishide
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      ishide = !ishide;
                                    });
                                  },
                                ),
                              ),
                              fillColor: Color(0xffF8F8F8),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0),
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
                                          if (isCheck == true) {
                                            isRemember = false;
                                          }
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
                          ksizedbox10,
                          // Visibility(
                          //   visible: isRemember == true,
                          //   child: const Text(
                          //     "Please agree the remember me",
                          //     style: TextStyle(color: Colors.red),
                          //   ),
                          // ),
                          ksizedbox40,
                          ksizedbox10,
                          Obx(() {
                            return authController.loginLoading.isTrue
                                ? Container(
                                    height: 50.h,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.kblue,
                                    )),
                                  )
                                : GestureDetector(
                                    onTap: _onLoginPressed,
                                    child: Container(
                                      height: 50,
                                      width:
                                          MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          }),

                          // ksizedbox20,
                          // RoundedLoadingButton(
                          //   child: Text('Press me',
                          //       style: TextStyle(color: Colors.white)),
                          //   controller: _btnController,
                          //   onPressed: _doSomething,
                          //   color: Colors.blue,
                          // ),
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
                          ),
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
