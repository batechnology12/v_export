import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/customer/controller/auth_controller.dart';

import '../../../../../constant/app_colors.dart';
import '../../../../../constant/app_font.dart';
import '../login_screen.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool passvisible = false;
  bool confirmvisible = false;

  AuthController authController = Get.put(AuthController());
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();

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
          'Create New Password',
          style: primaryfont.copyWith(
              color: Colors.black,
              fontSize: 19.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ksizedbox40,
              Center(
                  child: SvgPicture.asset(
                      'assets/images/createpasswordimage.svg')),
              ksizedbox40,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Password',
                      style: primaryfont.copyWith(color: Color(0xff7C86A2)),
                    ),
                    ksizedbox5,
                    TextFormField(
                      obscureText: passvisible,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the new password';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5, left: 20),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: IconButton(
                            icon: passvisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                passvisible = !passvisible;
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
                    ksizedbox30,
                    Text(
                      'confirm Password',
                      style: primaryfont.copyWith(color: Color(0xff7C86A2)),
                    ),
                    ksizedbox5,
                    TextFormField(
                      obscureText: confirmvisible,
                      controller: confirmpasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the confirm password';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5, left: 20),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: IconButton(
                            icon: confirmvisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                confirmvisible = !confirmvisible;
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          height: 70.h,
          child: Column(
            children: [
              Obx(() {
                return Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  child: authController.newPasswordLoading.isTrue
                      ? Container(
                          height: 50.h,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.kblue,
                          )),
                        )
                      : InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              authController.newPassword(
                                  passwordController.text,
                                  confirmpasswordController.text);
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
                                'Change Password',
                                style: primaryfont.copyWith(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
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
    );
  }
}
