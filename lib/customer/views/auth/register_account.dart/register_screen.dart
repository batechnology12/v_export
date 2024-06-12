import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/auth_controller.dart';
import 'package:v_export/customer/views/auth/login/login_screen.dart';
import 'package:v_export/customer/views/auth/register_account.dart/verification_screen.dart';

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

  bool ischecked = false;

  bool ishiding = false;
  bool confirmhide = false;
  var companynameController = TextEditingController();
  var businessphoneController = TextEditingController();
  var businessemailidController = TextEditingController();
  var contactPersonController = TextEditingController();
  var industryController = TextEditingController();
  var parcelController = TextEditingController();
  var businnesspasswordsController = TextEditingController();
  var bussinessConfirmpasswordsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                Container(
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.kblue,
                  ),
                ),
                Expanded(
                    //  flex: 4,
                    child: Container(
                  decoration: const BoxDecoration(
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
                top: 30.h,
                left: 15,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create account',
                        style: primaryfont.copyWith(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.kwhite),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Please create your account to register',
                          style: primaryfont.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kwhite),
                        ),
                      ),
                    ],
                  ),
                )),
            if (authController.containerindex.value == 0)
              Positioned(
                  top: 180.h,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: size.height - 180,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the name';
                                }
                                return null;
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Phone Number*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the mobile number';
                                }
                                return null;
                              },
                              controller: mobileController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Email Id*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the email id';
                                }
                                return null;
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Password*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the password';
                                }
                                return null;
                              },
                              obscureText: ishide,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  suffixIcon: IconButton(
                                    icon: ishide
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        ishide = !ishide;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Confirm Password*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the confirm password';
                                }
                                return null;
                              },
                              obscureText: confirnhide,
                              controller: confirmpasswordController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  suffixIcon: IconButton(
                                    icon: confirnhide
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        confirnhide = !confirnhide;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          ksizedbox10,
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Checkbox(
                                    value: ischeck,
                                    onChanged: (value) {
                                      setState(() {
                                        ischeck = value!;
                                      });
                                    }),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'I have read and agree to the',
                                    style: thirdsfont.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text('Terms & Condition',
                                          style: thirdsfont.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColors.kblue,
                                              fontWeight: FontWeight.w500)),
                                      Text(' and ',
                                          style: thirdsfont.copyWith(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500)),
                                      Text('Privacy Policy',
                                          style: thirdsfont.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColors.kblue,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          ksizedbox10,
                          InkWell(
                            onTap: () {
                              Get.to(RegisterVerificationScreen());
                            },
                            child: Container(
                              height: 50.h,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.kblue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: primaryfont.copyWith(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kwhite),
                                ),
                              ),
                            ),
                          ),
                          ksizedbox10,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account ?',
                                    style: secondoryfont.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp)),
                                InkWell(
                                  onTap: () {
                                    Get.to(LoginScreen());
                                  },
                                  child: Text(' Sign In',
                                      style: secondoryfont.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 15.sp,
                                          color: AppColors.kblue,
                                          fontWeight: FontWeight.w500)),
                                )
                              ]),
                          ksizedbox10,
                          //    PersonalAccount(),
                        ],
                      ),
                    ),
                  )),
            if (authController.containerindex.value == 1)
              Positioned(
                  top: 180.h,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: size.height - 180,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //   BusinessAccount(),
                          Text(
                            'Company Name *',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the name';
                                }
                                return null;
                              },
                              controller: companynameController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Phone Number*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the mobile number';
                                }
                                return null;
                              },
                              controller: businessphoneController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Business Email Id * ',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the email id';
                                }
                                return null;
                              },
                              controller: businessemailidController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Contact Person Name * ',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the campany name';
                                }
                                return null;
                              },
                              controller: contactPersonController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Industry*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the industry name';
                                }
                                return null;
                              },
                              controller: industryController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Number of parcel delivery per month? * ',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the industry name';
                                }
                                return null;
                              },
                              controller: parcelController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Password*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter the password';
                                }
                                return null;
                              },
                              obscureText: ishiding,
                              controller: businnesspasswordsController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  suffixIcon: IconButton(
                                    icon: ishiding
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        ishiding = !ishiding;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Confirm Password*',
                            style:
                                primaryfont.copyWith(color: Color(0xff7C86A2)),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter the confirm password';
                                }
                                return null;
                              },
                              obscureText: confirmhide,
                              controller: bussinessConfirmpasswordsController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 10),
                                  suffixIcon: IconButton(
                                    icon: confirmhide
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        confirmhide = !confirmhide;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          ksizedbox10,
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Checkbox(
                                    value: ischecked,
                                    onChanged: (value) {
                                      setState(() {
                                        ischecked = value!;
                                      });
                                    }),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'I have read and agree to the',
                                    style: thirdsfont.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text('Terms & Condition',
                                          style: thirdsfont.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColors.kblue,
                                              fontWeight: FontWeight.w500)),
                                      Text(' and ',
                                          style: thirdsfont.copyWith(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500)),
                                      Text('Privacy Policy',
                                          style: thirdsfont.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColors.kblue,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          ksizedbox10,
                          InkWell(
                            onTap: () {
                              Get.to(RegisterVerificationScreen());
                            },
                            child: Container(
                              height: 50.h,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.kblue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: primaryfont.copyWith(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kwhite),
                                ),
                              ),
                            ),
                          ),
                          ksizedbox10,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account ?',
                                    style: secondoryfont.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp)),
                                InkWell(
                                  onTap: () {
                                    Get.to(LoginScreen());
                                  },
                                  child: Text(' Sign In',
                                      style: secondoryfont.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 16.sp,
                                          color: AppColors.kblue,
                                          fontWeight: FontWeight.w500)),
                                )
                              ]),
                          ksizedbox10,
                        ],
                      ),
                    ),
                  )),
            Positioned(
              top: size.height * .12,
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
                                color: authController.containerindex.value == 0
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
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp),
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
                                color: authController.containerindex.value == 1
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
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp),
                            )),
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
    );
  }
}
