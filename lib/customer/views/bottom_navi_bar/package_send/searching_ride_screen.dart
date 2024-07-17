import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  ParcelController parcelController = Get.find<ParcelController>();
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Timer(Duration(seconds: 5), () async {
      if (parcelController.status.isTrue) {
        await parcelController
            .getAcceptBooking(parcelController.driverbookingid);
        parcelController.update();
        print("--1234---------- driver booking id");
        print(parcelController.driverbookingid);
      } else {
        print("Waiting for Driver Accept");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(BottomNavigationScreen());
        return false;
      },
      child: Scaffold(
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
      ),
    );
  }
}
