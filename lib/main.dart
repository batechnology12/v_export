import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:v_export/customer/controller/auth_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/splash/splash_screen.dart';

import 'customer/controller/easebuzz_controller.dart';


void main() {
  runApp(const MyApp());
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(EasebuszzController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        360,
        690,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'V Export',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}


