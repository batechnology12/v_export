import 'dart:async';

import 'package:flutter/material.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_details_screen.dart';

class SearchingRideScreen extends StatefulWidget {
  const SearchingRideScreen({super.key});

  @override
  State<SearchingRideScreen> createState() => _SearchingRideScreenState();
}

class _SearchingRideScreenState extends State<SearchingRideScreen> {

  @override
  void initState() {
    super.initState();
    // Start a timer that will navigate to the second page after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>DriverDetailsScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/Truck.gif',
            fit: BoxFit.fitHeight,
            height: 120,),

            Text('Searching Ride...',
            style: secondoryfont.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18
            ),),
            Text('This my take a few seconds...',
            style: thirdsfont.copyWith(
              fontWeight: FontWeight.w400,

            ),)
          ],
        ),
      ),
    );
  }
}