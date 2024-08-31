import 'dart:collection';
// import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/auth_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/home_screen_controller.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/controller/wallet_controller.dart';
import 'package:v_export/customer/splash/splash_screen.dart';
import 'package:v_export/customer/views/auth/login/login_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/account.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_sucessfully_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/arrived_destination.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_about_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_details_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/make_payment_screen.dart';

import 'customer/controller/easebuzz_controller.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());

  Get.put(AuthController());
  Get.put(HomeController());
  Get.put(AccountController());
  Get.put(HomeScreenController());
  Get.put(EasebuszzController());
  Get.put(ParcelController());
  Get.put(MyListController());
  Get.put(CarouselController());
  Get.put(WalletController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        392,
        850,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VEELGO BOOKING',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
