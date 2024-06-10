import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

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

  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
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
              fontSize: 17.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          Column(
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
                    ksizedbox10,
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        obscureText: passvisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter the new password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passvisible = !passvisible;
                                  });
                                },
                                icon: passvisible == true
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    ksizedbox30,
                    Text(
                      'confirm Password',
                      style: primaryfont.copyWith(color: Color(0xff7C86A2)),
                    ),
                    ksizedbox10,
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        obscureText: confirmvisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter the confirm password';
                          }
                          return null;
                        },
                        controller: confirmpasswordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: confirmvisible == true
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  confirmvisible = !confirmvisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          height: 70.h,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(LoginScreen());
                },
                child: Container(
                  height: 50.h,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: AppColors.kblue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Change Password',
                      style: primaryfont.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kwhite),
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
