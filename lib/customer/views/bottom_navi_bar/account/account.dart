import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/auth/login/login_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/chat.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/corporate_account.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/edit_profile.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/refer_friends.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/settings.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List accountList = [
    {
      "accountNames": "Your Profile",
      "image": "assets/icons/profile1.png",
    },
    {
      "accountNames": "Booking History",
      "image": "assets/icons/map.png",
    },
    {
      "accountNames": "Corporate account",
      "image": "assets/icons/acc.png",
    },
    {
      "accountNames": "Settings",
      "image": "assets/icons/settings.png",
    },
    {
      "accountNames": "Chat",
      "image": "assets/icons/chat.png",
    },
    {
      "accountNames": "Refer Friends",
      "image": "assets/icons/refer.png",
    },
    {
      "accountNames": "Rate Review",
      "image": "assets/icons/rating.png",
    },
    {
      "accountNames": "Log Out",
      "image": "assets/icons/log.png",
    },
  ];

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
        alignment: Alignment.topCenter,
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
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: accountList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(EditProfile());
                                          break;
                                        case 1:
                                          break;
                                        case 2:
                                          Get.to(CorporateAccount());
                                          break;
                                        case 3:
                                          Get.to(Settings());
                                          break;
                                        case 4:
                                          Get.to(ChatScreen());
                                          break;
                                        case 5:
                                          Get.to(ReferFriends());
                                          break;
                                        case 6:
                                          ratingPopup();
                                          break;
                                        case 7:
                                          popUp();
                                          break;
                                      }
                                    },
                                    child: Container(
                                      color: Color(0xffF4F8FF),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(accountList[index]
                                                      ["image"]),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    accountList[index]
                                                        ["accountNames"],
                                                    style: primaryfont.copyWith(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff212121)),
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
                                            color: Color(0xff000000)
                                                .withOpacity(.20),
                                          ),
                                          ksizedbox15,
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Container(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage(
                        'assets/images/Ellipse 1.png'), // Replace with your image asset path
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit, color: Colors.blue, size: 22),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Jhon Doe',
                style: primaryfont.copyWith(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
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
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                        GestureDetector(
                          onTap: () {
                            Get.offAll(LoginScreen());
                          },
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
          );
        });
  }
}
