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

  int selectedIndex = 0;
  String selectedValues = "+65";

  int selectedIndexes = 0;
  String selectedValuess = "+65";

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

  String? selectedValue;
  bool isTextFormFieldVisible = false;

  List<String> pacerList = [
    "1-100",
    "101-200",
    "201-300",
    "301-400",
    "401-500",
    "500 above"
  ];

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
                      SizedBox(
                        height: 25,
                      ),
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
                                EdgeInsets.only(left: 15, top: 15, right: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ksizedbox30,
                                  Text(
                                    'Name (NRIC Full Name)*',
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
                                      selectedValues == "+65"
                                          ? LengthLimitingTextInputFormatter(8)
                                          : LengthLimitingTextInputFormatter(
                                              10),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: selectedValues == "+65"
                                        ? (value) {
                                            if (value!.length < 8 ||
                                                value.length > 8) {
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
                                    controller: mobileController,
                                    decoration: InputDecoration(
                                      prefixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          PopupMenuButton<int>(
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                              height: 30,
                                              width: 50,
                                              alignment: Alignment.center,
                                              child: Text(
                                                selectedValues,
                                                style: primaryfont.copyWith(
                                                  fontSize:
                                                      14, // Adjust font size
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
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
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "+65",
                                                    style: primaryfont.copyWith(
                                                      fontSize:
                                                          14, // Adjust font size
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem<int>(
                                                value: 1,
                                                child: Container(
                                                  height: 30,
                                                  width: 50,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "+91",
                                                    style: primaryfont.copyWith(
                                                      fontSize:
                                                          14, // Adjust font size
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(left: 5, top: 13),
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
                                  ksizedbox10,
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
                                                'Sign Up',
                                                style: primaryfont.copyWith(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.kwhite),
                                              ),
                                            ),
                                          ),
                                        ),
                                  ksizedbox20,
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
                                  ksizedbox20,
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
                                EdgeInsets.only(left: 15, top: 15, right: 15),
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
                                    textCapitalization:
                                        TextCapitalization.words,
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
                                      selectedValues == "+65"
                                          ? LengthLimitingTextInputFormatter(8)
                                          : LengthLimitingTextInputFormatter(
                                              10),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: selectedValues == "+65"
                                        ? (value) {
                                            if (value!.length < 8 ||
                                                value.length > 8) {
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
                                    controller: businessphoneController,
                                    decoration: InputDecoration(
                                      prefixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          PopupMenuButton<int>(
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                              height: 30,
                                              width: 50,
                                              alignment: Alignment.center,
                                              child: Text(
                                                selectedValues,
                                                style: primaryfont.copyWith(
                                                  fontSize:
                                                      14, // Adjust font size
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
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
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "+65",
                                                    style: primaryfont.copyWith(
                                                      fontSize:
                                                          14, // Adjust font size
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem<int>(
                                                value: 1,
                                                child: Container(
                                                  height: 30,
                                                  width: 50,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "+91",
                                                    style: primaryfont.copyWith(
                                                      fontSize:
                                                          14, // Adjust font size
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(left: 5, top: 13),
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
                                  // TextFormField(
                                  //   keyboardType: TextInputType.phone,
                                  //   inputFormatters: [
                                  //     selectedValuess == "+65"
                                  //         ? LengthLimitingTextInputFormatter(8)
                                  //         : LengthLimitingTextInputFormatter(
                                  //             10),
                                  //     FilteringTextInputFormatter.digitsOnly,
                                  //   ],
                                  //   validator: selectedValuess == "+65"
                                  //       ? (value) {
                                  //           if (value!.length < 8 ||
                                  //               value.length > 8) {
                                  //             return 'Mobile number should be in 8 digits';
                                  //           } else {
                                  //             return null;
                                  //           }
                                  //         }
                                  //       : (value) {
                                  //           if (value!.length < 10 ||
                                  //               value.length > 10) {
                                  //             return 'Mobile number should be in 10 digits';
                                  //           } else {
                                  //             return null;
                                  //           }
                                  //         },
                                  //   controller: businessphoneController,
                                  //   decoration: InputDecoration(
                                  //     prefixIcon: Padding(
                                  //         padding: const EdgeInsets.only(
                                  //             left: 10, top: 13),
                                  //         child: PopupMenuButton(
                                  //           child: Container(
                                  //               height: 30,
                                  //               width: 50,
                                  //               child: Text(selectedValues)),
                                  //           onSelected: (value) {
                                  //             setState(() {
                                  //               selectedIndexes = value;
                                  //               selectedValuess =
                                  //                   value == 0 ? "+65" : "+91";
                                  //             });
                                  //           },
                                  //           itemBuilder: (context) => [
                                  //             PopupMenuItem<int>(
                                  //               value: 0,
                                  //               child: Container(
                                  //                 height: 30,
                                  //                 width: 50,
                                  //                 child: Text("+65"),
                                  //               ),
                                  //             ),
                                  //             PopupMenuItem<int>(
                                  //               value: 1,
                                  //               child: Container(
                                  //                 height: 30,
                                  //                 width: 50,
                                  //                 child: Text("+91"),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         )),
                                  //     contentPadding:
                                  //         EdgeInsets.only(bottom: 5, left: 20),
                                  //     fillColor: Color(0xffF8F8F8),
                                  //     filled: true,
                                  //     border: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //     ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //     ),
                                  //     errorBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius: BorderRadius.circular(25),
                                  //     ),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //     ),
                                  //     focusedErrorBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //     ),
                                  //   ),
                                  // ),
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
                                    'Contact Person Name (NRIC Full Name)**',
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
                                    'Number of parcel delivery per month? * ',
                                    style: primaryfont.copyWith(
                                        color: Color(0xff7C86A2)),
                                  ),
                                  ksizedbox5,
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      isExpanded: true,
                                      value: selectedValue,
                                      hint: Text('Select no of parcels'),
                                      items: pacerList
                                          .map((pacer) => DropdownMenuItem(
                                                value: pacer,
                                                child: Text(pacer),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value!;
                                        });
                                      },
                                    ),
                                  ),

                                  // TextFormField(
                                  //   validator: (value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the number of delivery parcels';
                                  //     } else {
                                  //       return null;
                                  //     }
                                  //   },
                                  //   controller: parcelController,
                                  //   keyboardType: TextInputType.number,
                                  //   decoration: InputDecoration(
                                  //     contentPadding:
                                  //         EdgeInsets.only(bottom: 5, left: 20),
                                  //     fillColor: Color(0xffF8F8F8),
                                  //     filled: true,
                                  //     border: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //     ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //     ),
                                  //     errorBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius: BorderRadius.circular(25),
                                  //     ),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //     ),
                                  //     focusedErrorBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius:
                                  //           BorderRadius.circular(25.0),
                                  //     ),
                                  //   ),
                                  // ),
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
                                  ksizedbox10,
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
                                                          selectedValue,
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
                                                'Sign Up',
                                                style: primaryfont.copyWith(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.kwhite),
                                              ),
                                            ),
                                          ),
                                        ),
                                  ksizedbox20,
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
                                  ksizedbox20,
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
