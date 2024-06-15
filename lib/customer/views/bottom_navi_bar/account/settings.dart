import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/password_manager.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isCheck = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: AppColors.kblue,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Settings',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: const BoxDecoration(
          color: AppColors.kblue,
          gradient: LinearGradient(
            colors: [
              AppColors.kblue,
              AppColors.kwhite,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  //  color: Color.fromARGB(255, 235, 232, 232),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(PasswordManager());
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/icons/key.png"),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Password Manager",
                                          style: primaryfont.copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff212121)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                            color: Color(0XFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ksizedbox10,
                                Container(
                                  height: 2,
                                  width: size.width,
                                  color: Color(0xff000000).withOpacity(.20),
                                )
                              ],
                            ),
                          ),
                        ),
                        ksizedbox20,
                        GestureDetector(
                          onTap: () {
                           
                         
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/icons/delete.png"),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Delete Account",
                                          style: primaryfont.copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff212121)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                            color: Color(0XFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ksizedbox10,
                                Container(
                                  height: 2,
                                  width: size.width,
                                  color: Color(0xff000000).withOpacity(.20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  popUp() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: 170.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Delete Account",
                      style: primaryfont.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    ksizedbox10,
                    Text(
                      "Are you sure you want to Delete Account?",
                      style: primaryfont.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff949599)),
                    ),
                    ksizedbox10,
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                              height: 50.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 1, color: Color(0xff0072E8)),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: primaryfont.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff0072E8)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                              height: 50.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue),
                              child: Center(
                                child: Text(
                                  "Yes, Delete",
                                  style: primaryfont.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffFFFFFF)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
