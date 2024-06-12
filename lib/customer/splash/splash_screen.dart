import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/bottom_navigation.dart';

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
      const Duration(seconds: 2),
    );

    if (isLoading == false) {
      Get.offAll(
        () => LoginScreen(),
      );
    } else {
      Get.offAll(BottomNaviBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.kblue,
        child: Image.asset('assets/icons/veelgo.png').animate().fade().slide(
            begin: Offset(0, 0.5),
            end: Offset(0, 0),
            duration: Duration(seconds: 2)));
  }
}
