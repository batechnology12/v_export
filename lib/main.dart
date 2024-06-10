import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:v_export/customer/controller/auth_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/splash/splash_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_about_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_details_screen.dart';

import 'customer/controller/easebuzz_controller.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  //runApp(const MyApp());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
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
        392,
        850,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'V Export',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
