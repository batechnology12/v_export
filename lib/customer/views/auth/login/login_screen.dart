import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
  bool ischeck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ishide = true;
  }

  var mobileController = TextEditingController();
  var passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                height: size.height * 0.15,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Image.asset('assets/icons/veelgo.png'),
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
                    padding: const EdgeInsets.only(right: 15, left: 15),
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
                                fontSize: 21.sp, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'Please enter your Mobile Number \nto sign in',
                            style: primaryfont.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Mobile Number*',
                            style: primaryfont.copyWith(
                                color: Color(0xff7C86A2), fontSize: 14.sp),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the mobile number';
                                }
                                return null;
                              },
                              controller: mobileController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Password',
                            style: primaryfont.copyWith(
                                color: Color(0xff7C86A2), fontSize: 14.sp),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              obscureText: ishide,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 10),
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
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          ksizedbox5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: ischeck,
                                      onChanged: (value) {
                                        setState(() {
                                          ischeck = value!;
                                        });
                                      }),
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
                          InkWell(
                            onTap: () {
                              Get.to(BottomNavigationScreen());
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
