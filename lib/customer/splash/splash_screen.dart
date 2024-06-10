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

    // final prefs = await SharedPreferences.getInstance();
    // String? authtoken = prefs.getString("auth_token");
    // String? role = prefs.getString("role");
    // print("Token is here");
    // print(authtoken);
    // if (authtoken == "null" || authtoken == null) {
    //   Get.offAll(
    //     () => Onbording(),
    //   );
    // } else {
    //   Get.offAll(BottomNaviBar());
    // }

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
      child: Animate(
        child: Image.asset('assets/icons/veelgo.png'),
      ),
    );
  }
}
