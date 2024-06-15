import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/chat.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/corporate_account.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/edit_profile.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/settings.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: Container(),
        title: Text(
          'Account',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.to(NotificationView());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/icons/notification_icon.png',
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 80.h),
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xffF4F8FF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 160, right: 10),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(EditProfile());
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
                                            Image.asset(
                                                "assets/icons/profile1.png"),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Your Profile",
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
                                                color: Color(0XFF0072E8),
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
                            ksizedbox10,
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset("assets/icons/map.png"),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Booking History",
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
                                                color: Color(0XFF0072E8),
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
                            ksizedbox10,
                            GestureDetector(
                              onTap: () {
                                Get.to(CorporateAccount());
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
                                            Image.asset("assets/icons/acc.png"),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Corporate account",
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
                                                color: Color(0XFF0072E8),
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
                            ksizedbox10,
                            GestureDetector(
                              onTap: () {
                                Get.to(Settings());
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
                                            Image.asset(
                                                "assets/icons/settings.png"),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Settings",
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
                                                color: Color(0XFF0072E8),
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
                            ksizedbox10,
                            GestureDetector(
                              onTap: () {
                                Get.to(ChatScreen());
                              },
                              child: Container(
                                // color: Colors.amber,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                "assets/icons/chat.png"),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Chat",
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
                                                color: Color(0XFF0072E8),
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
                            ksizedbox10,
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset("assets/icons/refer.png"),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Refer Friends",
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
                                              color: Color(0XFF0072E8),
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
                            ksizedbox10,
                            GestureDetector(
                              onTap: () {
                                ratingPopup();
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
                                            Image.asset(
                                                "assets/icons/rating.png"),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Rate Review",
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
                                                color: Color(0XFF0072E8),
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
                            ksizedbox10,
                            GestureDetector(
                              onTap: () {
                                popUp();
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
                                            Image.asset("assets/icons/log.png"),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Log Out",
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
                                                color: Color(0XFF0072E8),
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
                    )),
              )
            ],
          ),
          Positioned(
            top: 5.h,
            left: 120.w,
            child: SvgPicture.asset(
              "assets/images/profile.svg",
            ),
          ),
          Positioned(
            top: 115.h,
            left: 170.w,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColors.kblue,
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Image.asset(
                    "assets/icons/pen.png",
                    height: 150,
                    width: 150,
                  ),
                ),
                ksizedbox10,
                Text(
                  'Jhon',
                  style: fifthfont.copyWith(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ratingPopup() {
    double _rating = 0.0;
    UpateValues(
      double rating,
    ) {
      setState(() {
        _rating = rating;
      });
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              "Rate us experience",
              textAlign: TextAlign.center,
              style: primaryfont.copyWith(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please let us know how do you \nfeel about this app",
                  textAlign: TextAlign.center,
                  style: primaryfont.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff949599)),
                ),
                ksizedbox10,
                RatingBar.builder(
                  glowColor: Color(0xffFFAB18),
                  initialRating: _rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) {
                    if (index < _rating) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: Color(0xffFFAB18),
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.star_border_outlined,
                          size: 40,
                          color: Color(0xffFFAB18),
                        ),
                      );
                    }
                  },
                  onRatingUpdate: (
                    double rating,
                  ) {
                    setState(() {
                      UpateValues(
                        rating,
                      );
                    });
                  },
                ),
                ksizedbox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(width: 1, color: Color(0xff0072E8)),
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
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: primaryfont.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  popUp() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            height: 180.h,
            decoration: const BoxDecoration(
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
                      "Logout",
                      style: primaryfont.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff212121)),
                    ),
                    ksizedbox5,
                    Text(
                      "Are you sure you want to Logout?",
                      style: primaryfont.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff949599)),
                    ),
                    ksizedbox20,
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
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
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue),
                              child: Center(
                                child: Text(
                                  "Yes, Logout",
                                  style: primaryfont.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffFFFFFF)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
