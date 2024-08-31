import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';

class PlacedOrder extends StatefulWidget {
  const PlacedOrder({super.key});

  @override
  State<PlacedOrder> createState() => _PlacedOrderState();
}

class _PlacedOrderState extends State<PlacedOrder> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(
          seconds: 3,
        ), () {
      Get.offAll(BottomNavigationScreen(indexes: 0,));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/sucess.json'),
            Text(
              'Your Order has been Placed \nsuccessfully',
              textAlign: TextAlign.center,
              style: primaryfont.copyWith(
                  fontSize: 18.sp, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
