import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:svg_flutter/svg.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/arrived_destination.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/cancel_booking.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_about_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_message.dart';

class DriverDetailsScreen extends StatefulWidget {
  @override
  State<DriverDetailsScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DriverDetailsScreen> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  late LocationData _currentPosition;
  Location location = Location();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _initLocationAndRedirect();
  }

  void _initLocationAndRedirect() async {
    _getLocation();
    redirectToNextScreen();
  }

  redirectToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Get.to(ArrivedDestination());
  }

  void _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _currentPosition = currentLocation;
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(_currentPosition.latitude!, _currentPosition.longitude!),
          zoom: 14.0,
        ),
      ));
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition.latitude!, _currentPosition.longitude!),
          infoWindow: InfoWindow(title: 'Your Location'),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Driver Details',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              popUp(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  shape: BoxShape.circle),
              child: const Center(
                  child: Icon(
                Icons.question_mark_sharp,
                color: Colors.white,
                size: 20,
              )),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: size.height,
              width: size.width,
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                markers: _markers,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xffF4F8FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(DriverAboutDetails());
                            },
                            child: Container(
                              padding: EdgeInsets.all(7),
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.kwhite,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/driverprofile.png'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Lee Wong',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff000000),
                                                      fontSize: 17.sp),
                                                ),
                                                Text(
                                                  'Vechcle Driver',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.sp,
                                                      color: Color(0xff455A64)),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Phone Number:',
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13.sp,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    Text(
                                                      ' 9876543210',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: AppColors
                                                                  .kblue,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 40.h,
                                            width: 40.w,
                                            child: SvgPicture.asset(
                                              'assets/icons/08.whatsapp.svg',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(DriverMessage());
                                              },
                                              child: Container(
                                                height: 40.h,
                                                width: 40.w,
                                                child: SvgPicture.asset(
                                                  'assets/icons/Group 50.svg',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Divider(),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Rating Star',
                                            style: primaryfont.copyWith(
                                                fontSize: 14.sp,
                                                color: Color(0xff455A64),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFFAB18),
                                                ),
                                                Text(
                                                  '3.5',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff000000),
                                                      fontSize: 16.sp),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vechicle No',
                                            style: primaryfont.copyWith(
                                                fontSize: 14.sp,
                                                color: Color(0xff455A64),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: Text(
                                                'GBL3245N',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff000000),
                                                    fontSize: 16.sp),
                                              ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vechcle type',
                                            style: primaryfont.copyWith(
                                                fontSize: 14.sp,
                                                color: Color(0xff455A64),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: Text(
                                                '2.4 Van',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff000000),
                                                    fontSize: 15.sp),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                  ksizedbox20,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(DriverAboutDetails());
                                        },
                                        child: Text(
                                          'View Details',
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors.kblue),
                                        ),
                                      )
                                    ],
                                  ),
                                  ksizedbox10
                                ],
                              ),
                            ),
                          ),
                          ksizedbox10,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 1, bottom: 7, right: 1, left: 1),
                              width: size.width,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Booking ID : #ZAG01',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17.sp,
                                                  color: Color(0xff1E1E1E)),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          children: [
                                            const Column(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Color(0xff038484),
                                                ),
                                                Dash(
                                                    direction: Axis.vertical,
                                                    length: 65,
                                                    dashLength: 5,
                                                    dashColor: AppColors.kgrey),
                                                Icon(
                                                  Icons.location_on,
                                                  color: Color(0xffF74354),
                                                ),
                                              ],
                                            ),
                                            Ksizedboxw10,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pickup Address',
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xff455A64)),
                                                ),
                                                Container(
                                                  width: size.width * 0.60,
                                                  child: Text(
                                                    '338 Serangoon North ave 6',
                                                    style: primaryfont.copyWith(
                                                        color:
                                                            Color(0xff1E1E1E),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.sp),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40.h,
                                                ),
                                                Text(
                                                  'Delivery details',
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xff455A64)),
                                                ),
                                                Container(
                                                  width: size.width * 0.60,
                                                  child: Text(
                                                    '338 Serangoon North ave 6',
                                                    style: primaryfont.copyWith(
                                                        color:
                                                            Color(0xff1E1E1E),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 30),
                                                  child: Text(
                                                    '2PM to 5PM',
                                                    style: primaryfont.copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff455A64)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40.h,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Text(
                                                    '2PM to 5PM',
                                                    style: primaryfont.copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff455A64)),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    ksizedbox10,
                                    const Divider(),
                                    ksizedbox10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 75.h,
                                          width: 140.w,
                                          decoration: BoxDecoration(
                                              color: Color(0xffF5F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Pickup Date',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64),
                                                    fontSize: 14.sp),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                '25/04/2024',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 75.h,
                                          width: 140.w,
                                          decoration: BoxDecoration(
                                              color: Color(0xffF5F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Delivery Date',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64),
                                                    fontSize: 14.sp),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                '25/04/2024',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    ksizedbox20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Delivery Type:',
                                          style: primaryfont.copyWith(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp),
                                        ),
                                        Text(
                                          '3 hours Delivery',
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Color(0xff455A64)),
                                        )
                                      ],
                                    ),
                                    ksizedbox10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Vechicle Mode:',
                                          style: primaryfont.copyWith(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp),
                                        ),
                                        Text(
                                          'All',
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Color(0xff455A64)),
                                        )
                                      ],
                                    ),
                                    ksizedbox15,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Parcel Weight:',
                                          style: primaryfont.copyWith(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp),
                                        ),
                                        Text(
                                          '1kg',
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Color(0xff455A64)),
                                        )
                                      ],
                                    ),
                                    ksizedbox15,
                                    Divider(),
                                    ksizedbox15,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Additional Services:',
                                          style: primaryfont.copyWith(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp),
                                        ),
                                        Text(
                                          'No',
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Color(0xff455A64)),
                                        )
                                      ],
                                    ),
                                    ksizedbox10,
                                    Divider(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  popUp(BuildContext context) {
    bool isEditDetailsChecked = false;
    bool isCancelBookingChecked = false;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.9, // Set the desired width here
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Need Details?',
                        style: primaryfont.copyWith(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 30,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  ksizedbox20,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEditDetailsChecked = !isEditDetailsChecked;
                              });
                            },
                            child: Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.kblue),
                                  borderRadius: BorderRadius.circular(5)),
                              child: isEditDetailsChecked
                                  ? Image.asset("assets/icons/7-Check.png")
                                  : Text(""),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text("edit Details",
                              style: primaryfont.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                      ksizedbox20,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCancelBookingChecked =
                                    !isCancelBookingChecked;
                              });
                            },
                            child: Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.kblue),
                                  borderRadius: BorderRadius.circular(5)),
                              child: isCancelBookingChecked
                                  ? Image.asset("assets/icons/7-Check.png")
                                  : Text(""),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text("Cancel Booking",
                              style: primaryfont.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.to(CancelBooking());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.kblue,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'Confirm',
                        style: primaryfont.copyWith(
                            fontSize: 19.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
