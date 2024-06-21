import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';

class ReferFriends extends StatefulWidget {
  const ReferFriends({super.key});

  @override
  State<ReferFriends> createState() => _ReferFriendsState();
}

class _ReferFriendsState extends State<ReferFriends> {
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
              fontSize: 22.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
            size: 19.h,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          children: [
            Text(
              'Share your code with your friends and earn cash and points.',
              textAlign: TextAlign.center,
              style: primaryfont.copyWith(
                  fontSize: 19.sp,
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
                  fontSize: 17.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            ksizedbox30,
            Container(
              padding: EdgeInsets.only(left: 15, right: 5),
              height: 50,
              width: size.width,
              decoration: BoxDecoration(
                color: Color(0xffF1F8FF),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'QRT67',
                    textAlign: TextAlign.center,
                    style: primaryfont.copyWith(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: 40,
                    width: 150,
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
                          fontSize: 16.sp),
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
