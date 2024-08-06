import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';

import '../views/auth/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    toHomePage();
  }

  bool isLoading = false;

  toHomePage() async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authtoken = prefs.getString('auth_token');
    print("token in here");
    print(authtoken);
    if (authtoken == "null" || authtoken == null) {
      Get.offAll(LoginScreen());
    } else {
      Get.offAll(BottomNavigationScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: Center(
        child: Container(
          height: 100,
          width: 200,
          child: SvgPicture.asset(
            'assets/images/VEELGO (1).svg',
          ),
        ),
      ),
      // Image.asset('assets/icons/veelgo.png')
      // .animate().fade().slide(
      //       begin: Offset(0, 0),
      //       end: Offset(0, -0.5),
      //       duration: Duration(milliseconds: 1800),
      //     )
    );
  }
}
