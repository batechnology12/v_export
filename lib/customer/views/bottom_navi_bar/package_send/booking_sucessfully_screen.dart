import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/searching_ride_screen.dart';

class BookingSucessfullyScreen extends StatefulWidget {
  const BookingSucessfullyScreen({super.key});

  @override
  State<BookingSucessfullyScreen> createState() =>
      _BookingSucessfullyScreenState();
}

class _BookingSucessfullyScreenState extends State<BookingSucessfullyScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer that will navigate to the second page after 5 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SearchingRideScreen()),
      );
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
              'Your Amount has been Payed \nsuccessfully',
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
