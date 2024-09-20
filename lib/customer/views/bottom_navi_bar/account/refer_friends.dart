import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:svg_flutter/svg.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';

class ReferFriends extends StatefulWidget {
  const ReferFriends({super.key});

  @override
  State<ReferFriends> createState() => _ReferFriendsState();
}

class _ReferFriendsState extends State<ReferFriends> {
  AccountController accountController = Get.put(AccountController());

  ShareeCode() {
    String referralCode = accountController.getUserData!.data.referralCode;
    String message = "Use this code and get discount: $referralCode";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Refer Friends',
          style: primaryfont.copyWith(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
            size: 17.h,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Text(
            'Skip',
            style: primaryfont.copyWith(
                fontSize: 14.sp,
                color: AppColors.kblue,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          children: [
            Text(
              'Share your code with your friends and earn cash and points.',
              textAlign: TextAlign.center,
              style: primaryfont.copyWith(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            ksizedbox40,
            SvgPicture.asset("assets/icons/friend.svg"),
            ksizedbox20,
            Text(
              'Just share this code with your friends and ask then to signup and add this code. Both of you will get earn cah and poits',
              textAlign: TextAlign.center,
              style: primaryfont.copyWith(
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            ksizedbox40,
            Container(
              padding: EdgeInsets.only(left: 15, right: 5),
              height: 50.h,
              width: size.width,
              decoration: BoxDecoration(
                color: Color(0xffF1F8FF),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    accountController.getUserData!.data.referralCode,
                    textAlign: TextAlign.center,
                    style: primaryfont.copyWith(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ShareeCode();
                      });
                    },
                    child: Container(
                      height: 40.h,
                      width: 145.w,
                      decoration: BoxDecoration(
                        color: AppColors.kblue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Share Code",
                        style: primaryfont.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ksizedbox30,
          ],
        ),
      ),
    );
  }
}
