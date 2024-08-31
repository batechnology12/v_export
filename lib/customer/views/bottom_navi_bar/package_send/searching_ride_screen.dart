import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_details_screen.dart';

class SearchingRideScreen extends StatefulWidget {
  const SearchingRideScreen({super.key});

  @override
  State<SearchingRideScreen> createState() => _SearchingRideScreenState();
}

class _SearchingRideScreenState extends State<SearchingRideScreen> {
  Timer? _timer;
  ParcelController parcelController = Get.put(ParcelController());
  @override
  void initState() {
    super.initState();
    // parcelController.getAcceptBooking(parcelController.driverbookingid);
    _startPolling();
    // getData();
  }

  void _startPolling() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      //  await parcelController.getAcceptBooking(parcelController.driverbookingid);
      // if (parcelController.status == true) {
      // } else {

      //   Get.snackbar("Waiting", "Please wait for driver acceptance",
      //       colorText: Colors.white,
      //       backgroundColor: Colors.yellow,
      //       snackPosition: SnackPosition.BOTTOM);
      // }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // getData() async {
  //   Timer(Duration(seconds: 5), () async {
  //     if (parcelController.status == true) {
  //       parcelController.getAcceptBooking(parcelController.driverbookingid);
  //       parcelController.update();
  //       print("--1234---------- driver booking id");
  //       print(parcelController.driverbookingid);
  //     } else {
  //       Get.snackbar("Waiting", "Please Wait for Driver Accept",
  //           colorText: AppColors.kwhite,
  //           backgroundColor: Colors.yellow,
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/Truck.gif',
              fit: BoxFit.fitHeight,
              height: 120,
            ),
            Text(
              'Searching Ride...',
              style: secondoryfont.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 18),
            ),
            Text(
              'This my take a few seconds...',
              style: thirdsfont.copyWith(
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
