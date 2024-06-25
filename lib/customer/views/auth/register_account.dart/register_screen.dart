import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/auth_controller.dart';
import 'package:v_export/customer/model/register_person_business_account_model.dart';
import 'package:v_export/customer/views/auth/login/login_screen.dart';
import 'package:v_export/customer/views/auth/register_account.dart/register_personal_otp.dart';
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
  bool isCheck = false;
  bool isBusiness = false;
  bool ischeck = false;
  bool isPerosnal = false;
  bool isClicked = false;
  bool personalCheck = false;

  bool ishide = true;
  bool confirnhide = true;
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var emailController = TextEditingController();

  bool ischecked = false;

  bool ishiding = true;
  bool confirmhide = true;

  var companynameController = TextEditingController();
  var businessphoneController = TextEditingController();
  var businessemailidController = TextEditingController();
  var contactPersonController = TextEditingController();
  var industryController = TextEditingController();
  var parcelController = TextEditingController();
  var businnesspasswordsController = TextEditingController();
  var bussinessConfirmpasswordsController = TextEditingController();

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  bool isPersonal = true;
  bool isPersonalAccount = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 25, left: 16),
                  height: 140.h,
                  width: size.width,
                  color: AppColors.kblue,
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create account",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "Please create your account to register",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                if (authController.containerindex.value == 0)
                  Expanded(
                    child: Form(
                      key: formKey1,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.kblue,
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          decoration: const BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 15, right: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ksizedbox30,
                                  Text(
                                    'Name*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the name';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: nameController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5, left: 20),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Phone Number*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the mobile number';
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
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Email Id*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the email ID';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5, left: 20),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Password*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    obscureText: ishide,
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the password ';
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
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Confirm Password*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    obscureText: confirnhide,
                                    controller: confirmpasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the confirm password ';
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
                                          icon: confirnhide
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              confirnhide = !confirnhide;
                                            });
                                          },
                                        ),
                                      ),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                ischeck = !ischeck;
                                                if (ischeck == true) {
                                                  isPerosnal = false;
                                                }
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 22.h,
                                            width: 21.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.kblue),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: ischeck == true
                                                ? Image.asset(
                                                    "assets/icons/7-Check.png")
                                                : Text(""),
                                          ),
                                        ),
                                      ),
                                      Ksizedboxw10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(' and ',
                                                  style: thirdsfont.copyWith(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text('Privacy Policy',
                                                  style: thirdsfont.copyWith(
                                                      fontSize: 13.sp,
                                                      color: AppColors.kblue,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: Visibility(
                                              visible: isPerosnal == true,
                                              child: Text(
                                                "Please agree terms and Conditiions",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  ksizedbox20,
                                  authController.isLoading.isTrue
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
                                          onTap: () {
                                            setState(() {
                                              if (formKey1.currentState!
                                                      .validate() &&
                                                  ischeck) {
                                                RegisterPersonalAccount
                                                    registerPersonalAccount =
                                                    RegisterPersonalAccount(
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text,
                                                        phone: mobileController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        confirmPassword:
                                                            confirmpasswordController
                                                                .text);
                                                authController.registerPersonal(
                                                    registerPersonalAccount);
                                              } else {
                                                setState(() {
                                                  isPerosnal = !ischeck;
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 50.h,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                color: AppColors.kblue,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 15.sp,
                                                  color: AppColors.kblue,
                                                  fontWeight: FontWeight.w500)),
                                        )
                                      ]),
                                  ksizedbox10,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (authController.containerindex.value == 1)
                  Expanded(
                    child: Form(
                      key: formKey2,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.kblue,
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          decoration: const BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 15, right: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ksizedbox30,
                                  Text(
                                    'Company Name *',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the company name';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: companynameController,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 5, left: 20),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Phone Number*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: (value) {
                                      if (value!.length < 10 ||
                                          value.length > 10) {
                                        return 'Mobile number should be in 10 digits';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: businessphoneController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5, left: 20),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Business Email Id * ',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the company name';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: businessemailidController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5, left: 20),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Contact Person Name * ',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the contact person name';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: contactPersonController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5, left: 20),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Industry*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the industry';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: industryController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5, left: 20),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Number of parcel delivery per month? * ',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the number of delivery parcels';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: parcelController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5, left: 20),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Password*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    obscureText: ishiding,
                                    controller: businnesspasswordsController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the businness password ';
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
                                          icon: ishiding
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              ishiding = !ishiding;
                                            });
                                          },
                                        ),
                                      ),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Confirm Password*',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  TextFormField(
                                    obscureText: confirmhide,
                                    controller:
                                        bussinessConfirmpasswordsController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the businness confirm password ';
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
                                          icon: confirmhide
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              confirmhide = !confirmhide;
                                            });
                                          },
                                        ),
                                      ),
                                      fillColor: Color(0xffF8F8F8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                isCheck = !isCheck;
                                                if (isCheck == true) {
                                                  isBusiness = false;
                                                }
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 22.h,
                                            width: 21.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.kblue),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: isCheck == true
                                                ? Image.asset(
                                                    "assets/icons/7-Check.png")
                                                : Text(""),
                                          ),
                                        ),
                                      ),
                                      Ksizedboxw10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(' and ',
                                                  style: thirdsfont.copyWith(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text('Privacy Policy',
                                                  style: thirdsfont.copyWith(
                                                      fontSize: 13.sp,
                                                      color: AppColors.kblue,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: Visibility(
                                              visible: isBusiness == true,
                                              child: const Text(
                                                "Please agree terms and Conditiions",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  ksizedbox20,
                                  authController.businessLoading.isTrue
                                      ? Container(
                                          height: 50.h,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: const Center(
                                              child: CircularProgressIndicator(
                                            color: AppColors.kblue,
                                          )),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            if (formKey2.currentState!
                                                    .validate() &&
                                                isCheck == true) {
                                              RegisterBusinessAccount
                                                  registerBusinessAccount =
                                                  RegisterBusinessAccount(
                                                      companyName:
                                                          companynameController
                                                              .text,
                                                      mobile:
                                                          businessphoneController
                                                              .text,
                                                      emailId:
                                                          businessemailidController
                                                              .text,
                                                      contactPerson:
                                                          contactPersonController
                                                              .text,
                                                      industry:
                                                          industryController
                                                              .text,
                                                      noofPersonal:
                                                          parcelController.text,
                                                      businessPassword:
                                                          businnesspasswordsController
                                                              .text,
                                                      businessConfirmPassword:
                                                          bussinessConfirmpasswordsController
                                                              .text);
                                              authController.registerBusiness(
                                                  registerBusinessAccount);
                                            } else {
                                              setState(() {
                                                isBusiness = !isCheck;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 50.h,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                color: AppColors.kblue,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 16.sp,
                                                  color: AppColors.kblue,
                                                  fontWeight: FontWeight.w500)),
                                        )
                                      ]),
                                  ksizedbox10,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
                    child: Row(
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
                  )),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:v_export/customer/controller/auth_controller.dart';
// import 'package:v_export/customer/model/register_person_business_account_model.dart';
// import 'package:v_export/customer/views/auth/login/login_screen.dart';
// import 'package:v_export/customer/views/auth/register_account.dart/register_personal_otp.dart';
// import 'package:v_export/customer/views/auth/register_account.dart/verification_screen.dart';

// import '../../../../constant/app_colors.dart';
// import '../../../../constant/app_font.dart';
// import 'accounts/business_account_container.dart';
// import 'accounts/personal_account_container.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final authController = Get.find<AuthController>();
//   bool isCheck = false;
//   bool isBusiness = false;
//   bool ischeck = false;
//   bool isPerosnal = false;
//   bool isClicked = false;
//   bool personalCheck = false;

//   bool ishide = true;
//   bool confirnhide = true;
//   var nameController = TextEditingController();
//   var mobileController = TextEditingController();
//   var passwordController = TextEditingController();
//   var confirmpasswordController = TextEditingController();
//   var emailController = TextEditingController();

//   bool ischecked = false;

//   bool ishiding = true;
//   bool confirmhide = true;

//   var companynameController = TextEditingController();
//   var businessphoneController = TextEditingController();
//   var businessemailidController = TextEditingController();
//   var contactPersonController = TextEditingController();
//   var industryController = TextEditingController();
//   var parcelController = TextEditingController();
//   var businnesspasswordsController = TextEditingController();
//   var bussinessConfirmpasswordsController = TextEditingController();

//   final formKey1 = GlobalKey<FormState>();
//   final formKey2 = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColors.kblue,
//        resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: size.height,
//                 decoration: const BoxDecoration(
//                   color: AppColors.kblue,
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.kblue,
//                       AppColors.kwhite,
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//                 child: Obx(
//                   () => Stack(
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                             height: size.height * 0.15,
//                             decoration: BoxDecoration(
//                               color: AppColors.kblue,
//                             ),
//                           ),
//                           Expanded(
//                               //  flex: 4,
//                               child: Container(
//                             decoration: const BoxDecoration(
//                                 boxShadow: <BoxShadow>[
//                                   BoxShadow(
//                                       offset: Offset(0.0, 0.75),
//                                       blurRadius: 5,
//                                       color: AppColors.kgrey)
//                                 ],
//                                 color: AppColors.kwhite,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(17),
//                                     topRight: Radius.circular(17))),
//                           ))
//                         ],
//                       ),
//                       Positioned(
//                           top: 35.h,
//                           left: 15,
//                           child: Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Create account',
//                                   style: primaryfont.copyWith(
//                                       fontSize: 17.sp,
//                                       fontWeight: FontWeight.w700,
//                                       color: AppColors.kwhite),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 2),
//                                   child: Text(
//                                     'Please create your account to register',
//                                     style: primaryfont.copyWith(
//                                         fontSize: 15.sp,
//                                         fontWeight: FontWeight.w500,
//                                         color: AppColors.kwhite),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )),
//                       if (authController.containerindex.value == 0)
//                         Form(
//                           key: formKey1,
//                           child: Positioned(
//                               top: 180.h,
//                               left: 10,
//                               right: 10,
//                               child: Container(
//                                 height: size.height - 180,
//                                 child: SingleChildScrollView(
//                                   physics: AlwaysScrollableScrollPhysics(),
//                                   child: 
//                                     Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Name*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the name';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: nameController,
//                                         textCapitalization: TextCapitalization.words,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Phone Number*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         keyboardType: TextInputType.phone,
//                                         inputFormatters: [
//                                           LengthLimitingTextInputFormatter(10),
//                                           FilteringTextInputFormatter.digitsOnly,
//                                         ],
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the mobile number';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: mobileController,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Email Id*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the email ID';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: emailController,
//                                         keyboardType: TextInputType.emailAddress,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Password*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         obscureText: ishide,
//                                         controller: passwordController,
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the password ';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           suffixIcon: Padding(
//                                             padding: const EdgeInsets.only(top: 3),
//                                             child: IconButton(
//                                               icon: ishide
//                                                   ? Icon(Icons.visibility_off)
//                                                   : Icon(Icons.visibility),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   ishide = !ishide;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Confirm Password*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         obscureText: confirnhide,
//                                         controller: confirmpasswordController,
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the confirm password ';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           suffixIcon: Padding(
//                                             padding: const EdgeInsets.only(top: 3),
//                                             child: IconButton(
//                                               icon: confirnhide
//                                                   ? Icon(Icons.visibility_off)
//                                                   : Icon(Icons.visibility),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   confirnhide = !confirnhide;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(bottom: 12),
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 setState(
//                                                   () {
//                                                     ischeck = !ischeck;
//                                                     if (ischeck == true) {
//                                                       isPerosnal = false;
//                                                     }
//                                                   },
//                                                 );
//                                               },
//                                               child: Container(
//                                                 height: 22.h,
//                                                 width: 21.w,
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         width: 1,
//                                                         color: AppColors.kblue),
//                                                     borderRadius:
//                                                         BorderRadius.circular(5)),
//                                                 child: ischeck == true
//                                                     ? Image.asset(
//                                                         "assets/icons/7-Check.png")
//                                                     : Text(""),
//                                               ),
//                                             ),
//                                           ),
//                                           Ksizedboxw10,
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'I have read and agree to the',
//                                                 style: thirdsfont.copyWith(
//                                                     fontSize: 13.sp,
//                                                     fontWeight: FontWeight.w500),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text('Terms & Condition',
//                                                       style: thirdsfont.copyWith(
//                                                           fontSize: 13.sp,
//                                                           color: AppColors.kblue,
//                                                           fontWeight: FontWeight.w500)),
//                                                   Text(' and ',
//                                                       style: thirdsfont.copyWith(
//                                                           fontSize: 13.sp,
//                                                           fontWeight: FontWeight.w500)),
//                                                   Text('Privacy Policy',
//                                                       style: thirdsfont.copyWith(
//                                                           fontSize: 13.sp,
//                                                           color: AppColors.kblue,
//                                                           fontWeight: FontWeight.w500))
//                                                 ],
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(top: 12),
//                                                 child: Visibility(
//                                                   visible: isPerosnal == true,
//                                                   child: Text(
//                                                     "Please agree terms and Conditiions",
//                                                     style: TextStyle(color: Colors.red),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                       ksizedbox20,
//                                       authController.isLoading.isTrue
//                                           ? Container(
//                                               height: 50.h,
//                                               width: size.width,
//                                               decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.circular(30)),
//                                               child: Center(
//                                                   child: CircularProgressIndicator(
//                                                 color: AppColors.kblue,
//                                               )),
//                                             )
//                                           : GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   if (formKey1.currentState!
//                                                           .validate() &&
//                                                       ischeck) {
//                                                     RegisterPersonalAccount
//                                                         registerPersonalAccount =
//                                                         RegisterPersonalAccount(
//                                                             name: nameController.text,
//                                                             email: emailController.text,
//                                                             phone:
//                                                                 mobileController.text,
//                                                             password:
//                                                                 passwordController.text,
//                                                             confirmPassword:
//                                                                 confirmpasswordController
//                                                                     .text);
//                                                     authController.registerPersonal(
//                                                         registerPersonalAccount);
//                                                   } else {
//                                                     setState(() {
//                                                       isPerosnal = !ischeck;
//                                                     });
//                                                   }
//                                                 });
//                                               },
//                                               child: Container(
//                                                 height: 50.h,
//                                                 width: size.width,
//                                                 decoration: BoxDecoration(
//                                                     color: AppColors.kblue,
//                                                     borderRadius:
//                                                         BorderRadius.circular(30)),
//                                                 child: Center(
//                                                   child: Text(
//                                                     'Sign In',
//                                                     style: primaryfont.copyWith(
//                                                         fontSize: 17.sp,
//                                                         fontWeight: FontWeight.w500,
//                                                         color: AppColors.kwhite),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                       ksizedbox10,
//                                       Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Text('Already have an account ?',
//                                                 style: secondoryfont.copyWith(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 15.sp)),
//                                             InkWell(
//                                               onTap: () {
//                                                 Get.to(LoginScreen());
//                                               },
//                                               child: Text(' Sign In',
//                                                   style: secondoryfont.copyWith(
//                                                       decoration:
//                                                           TextDecoration.underline,
//                                                       fontSize: 15.sp,
//                                                       color: AppColors.kblue,
//                                                       fontWeight: FontWeight.w500)),
//                                             )
//                                           ]),
//                                       ksizedbox10,
//                                     ],
//                                   ),
//                                 ),
//                               )),
//                         ),
//                       if (authController.containerindex.value == 1)
//                         Form(
//                           key: formKey2,
//                           child: Positioned(
//                               top: 180.h,
//                               left: 10,
//                               right: 10,
//                               child: Container(
//                                 height: size.height - 180,
//                                 child: SingleChildScrollView(
//                                   physics: AlwaysScrollableScrollPhysics(),
//                                   child: 
//                                 Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Company Name *',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the company name';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: companynameController,
//                                         decoration: InputDecoration(
//                                           contentPadding: const EdgeInsets.only(
//                                               bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Phone Number*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         keyboardType: TextInputType.phone,
//                                         inputFormatters: [
//                                           LengthLimitingTextInputFormatter(10),
//                                           FilteringTextInputFormatter.digitsOnly,
//                                         ],
//                                         validator: (value) {
//                                           if (value!.length < 10 || value.length > 10) {
//                                             return 'Mobile number should be in 10 digits';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: businessphoneController,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Business Email Id * ',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the company name';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: businessemailidController,
//                                         keyboardType: TextInputType.emailAddress,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Contact Person Name * ',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the contact person name';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: contactPersonController,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Industry*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the industry';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: industryController,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Number of parcel delivery per month? * ',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the number of delivery parcels';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: parcelController,
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Password*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         obscureText: ishiding,
//                                         controller: businnesspasswordsController,
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the businness password ';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           suffixIcon: Padding(
//                                             padding: const EdgeInsets.only(top: 3),
//                                             child: IconButton(
//                                               icon: ishiding
//                                                   ? Icon(Icons.visibility_off)
//                                                   : Icon(Icons.visibility),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   ishiding = !ishiding;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Text(
//                                         'Confirm Password*',
//                                         style: primaryfont.copyWith(
//                                             color: Color(0xff7C86A2)),
//                                       ),
//                                       ksizedbox5,
//                                       TextFormField(
//                                         obscureText: confirmhide,
//                                         controller: bussinessConfirmpasswordsController,
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter the businness confirm password ';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         decoration: InputDecoration(
//                                           contentPadding:
//                                               EdgeInsets.only(bottom: 5, left: 20),
//                                           suffixIcon: Padding(
//                                             padding: const EdgeInsets.only(top: 3),
//                                             child: IconButton(
//                                               icon: confirmhide
//                                                   ? Icon(Icons.visibility_off)
//                                                   : Icon(Icons.visibility),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   confirmhide = !confirmhide;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           fillColor: Color(0xffF8F8F8),
//                                           filled: true,
//                                           border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           errorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                           focusedErrorBorder: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius: BorderRadius.circular(25.0),
//                                           ),
//                                         ),
//                                       ),
//                                       ksizedbox20,
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(bottom: 12),
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 setState(
//                                                   () {
//                                                     isCheck = !isCheck;
//                                                     if (isCheck == true) {
//                                                       isBusiness = false;
//                                                     }
//                                                   },
//                                                 );
//                                               },
//                                               child: Container(
//                                                 height: 22.h,
//                                                 width: 21.w,
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         width: 1,
//                                                         color: AppColors.kblue),
//                                                     borderRadius:
//                                                         BorderRadius.circular(5)),
//                                                 child: isCheck == true
//                                                     ? Image.asset(
//                                                         "assets/icons/7-Check.png")
//                                                     : Text(""),
//                                               ),
//                                             ),
//                                           ),
//                                           Ksizedboxw10,
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'I have read and agree to the',
//                                                 style: thirdsfont.copyWith(
//                                                     fontSize: 13.sp,
//                                                     fontWeight: FontWeight.w500),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text('Terms & Condition',
//                                                       style: thirdsfont.copyWith(
//                                                           fontSize: 13.sp,
//                                                           color: AppColors.kblue,
//                                                           fontWeight: FontWeight.w500)),
//                                                   Text(' and ',
//                                                       style: thirdsfont.copyWith(
//                                                           fontSize: 13.sp,
//                                                           fontWeight: FontWeight.w500)),
//                                                   Text('Privacy Policy',
//                                                       style: thirdsfont.copyWith(
//                                                           fontSize: 13.sp,
//                                                           color: AppColors.kblue,
//                                                           fontWeight: FontWeight.w500))
//                                                 ],
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(top: 12),
//                                                 child: Visibility(
//                                                   visible: isBusiness == true,
//                                                   child: const Text(
//                                                     "Please agree terms and Conditiions",
//                                                     style: TextStyle(color: Colors.red),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                       ksizedbox20,
//                                       authController.businessLoading.isTrue
//                                           ? Container(
//                                               height: 50.h,
//                                               width: size.width,
//                                               decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.circular(30)),
//                                               child: const Center(
//                                                   child: CircularProgressIndicator(
//                                                 color: AppColors.kblue,
//                                               )),
//                                             )
//                                           : GestureDetector(
//                                               onTap: () {
//                                                 if (formKey2.currentState!.validate() &&
//                                                     isCheck == true) {
//                                                   RegisterBusinessAccount
//                                                       registerBusinessAccount =
//                                                       RegisterBusinessAccount(
//                                                           companyName:
//                                                               companynameController
//                                                                   .text,
//                                                           mobile: businessphoneController
//                                                               .text,
//                                                           emailId:
//                                                               businessemailidController
//                                                                   .text,
//                                                           contactPerson:
//                                                               contactPersonController
//                                                                   .text,
//                                                           industry:
//                                                               industryController.text,
//                                                           noofPersonal:
//                                                               parcelController.text,
//                                                           businessPassword:
//                                                               businnesspasswordsController
//                                                                   .text,
//                                                           businessConfirmPassword:
//                                                               bussinessConfirmpasswordsController
//                                                                   .text);
//                                                   authController.registerBusiness(
//                                                       registerBusinessAccount);
//                                                 } else {
//                                                   setState(() {
//                                                     isBusiness = !isCheck;
//                                                   });
//                                                 }
//                                               },
//                                               child: Container(
//                                                 height: 50.h,
//                                                 width: size.width,
//                                                 decoration: BoxDecoration(
//                                                     color: AppColors.kblue,
//                                                     borderRadius:
//                                                         BorderRadius.circular(30)),
//                                                 child: Center(
//                                                   child: Text(
//                                                     'Sign In',
//                                                     style: primaryfont.copyWith(
//                                                         fontSize: 17.sp,
//                                                         fontWeight: FontWeight.w500,
//                                                         color: AppColors.kwhite),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                       ksizedbox10,
//                                       Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Text('Already have an account ?',
//                                                 style: secondoryfont.copyWith(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 16.sp)),
//                                             InkWell(
//                                               onTap: () {
//                                                 Get.to(LoginScreen());
//                                               },
//                                               child: Text(' Sign In',
//                                                   style: secondoryfont.copyWith(
//                                                       decoration:
//                                                           TextDecoration.underline,
//                                                       fontSize: 16.sp,
//                                                       color: AppColors.kblue,
//                                                       fontWeight: FontWeight.w500)),
//                                             )
//                                           ]),
//                                       ksizedbox10,
//                                     ],
//                                   ),
//                                 ),
//                               )),
//                         ),
//                       Positioned(
//                         top: size.height * .12,
//                         left: 10,
//                         right: 10,
//                         child: Container(
//                           height: 60.h,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                               color: Colors.grey.shade100,
//                               borderRadius: BorderRadius.circular(35)),
//                           child: Center(
//                             child: Obx(
//                               () => Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       authController.containerindex(0);
//                                       authController.update();
//                                     },
//                                     child: Container(
//                                       height: 48.h,
//                                       width: 200.w,
//                                       decoration: BoxDecoration(
//                                           color:
//                                               authController.containerindex.value == 0
//                                                   ? AppColors.kblue
//                                                   : Colors.grey.shade100,
//                                           borderRadius: BorderRadius.circular(30)),
//                                       child: Center(
//                                           child: Text(
//                                         'Personal Account',
//                                         style: primaryfont.copyWith(
//                                             color:
//                                                 authController.containerindex.value == 0
//                                                     ? AppColors.kwhite
//                                                     : Colors.black,
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14.sp),
//                                       )),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       authController.containerindex(1);
//                                       authController.update();
//                                     },
//                                     child: Container(
//                                       height: 48.h,
//                                       width: 160.w,
//                                       decoration: BoxDecoration(
//                                           color:
//                                               authController.containerindex.value == 1
//                                                   ? AppColors.kblue
//                                                   : Colors.grey.shade100,
//                                           borderRadius: BorderRadius.circular(30)),
//                                       child: Center(
//                                           child: Text(
//                                         'Business Account',
//                                         style: primaryfont.copyWith(
//                                             color:
//                                                 authController.containerindex.value == 1
//                                                     ? AppColors.kwhite
//                                                     : Colors.black,
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14.sp),
//                                       )),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
