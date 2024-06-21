import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/address_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_booking_details.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';
import 'vehicle_booking_container.dart';

class BookVehicleScreen extends StatefulWidget {
  const BookVehicleScreen({super.key});

  @override
  State<BookVehicleScreen> createState() => _BookVehicleScreenState();
}

class _BookVehicleScreenState extends State<BookVehicleScreen> {
  bool ischeck = false;

  bool _isLoading = false;
  final HomeController homeController = Get.find<HomeController>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.kwhite,
            ),
          ),
        ),
        title: Text(
          'Book Vehicles',
          style: primaryfont.copyWith(
              fontSize: 21.sp,
              color: Color(0xffF4F8FF),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          height: size.height,
          decoration: const BoxDecoration(
            color: AppColors.kblue,
            gradient: LinearGradient(
              colors: [
                AppColors.kblue,
                AppColors.kwhite,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
                    ),
                    color: AppColors.kwhite,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                  top: 5,
                                ),
                                child: AnimatedContainer(
                                  padding: const EdgeInsets.only(
                                    top: 7,
                                  ),
                                  duration: const Duration(milliseconds: 300),
                                  height: 180.0 *
                                      homeController.vehicalEntries.length,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.kwhite,
                                      boxShadow: const <BoxShadow>[
                                        BoxShadow(
                                            offset: Offset(0.0, 0.75),
                                            blurRadius: 1,
                                            color: AppColors.kgrey)
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        homeController.vehicalEntries.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          // SizedBox(height: 20),
                                          if (index == 0)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 10,
                                                left: 10,
                                              ),
                                              child: Container(
                                                height: 50.h,
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(.32),
                                                      width: 1),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.location_on,
                                                      color: Color(0xffF74354),
                                                    ),
                                                    const VerticalDivider(
                                                      indent: 10,
                                                      thickness: 1,
                                                      width: 5,
                                                      color: Color(0xff455A64),
                                                      endIndent: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              AddressDetails());
                                                        },
                                                        child: Text(
                                                          'Enter Pickup here...',
                                                          style: primaryfont
                                                              .copyWith(
                                                            fontSize: 13.sp,
                                                            color: Color(
                                                                0xff455A64),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Container(
                                              height: 50.h,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(.32),
                                                    width: 1),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: Color(0xff038484),
                                                  ),
                                                  const VerticalDivider(
                                                    indent: 10,
                                                    thickness: 1,
                                                    width: 5,
                                                    color: Color(0xff455A64),
                                                    endIndent: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(
                                                            AddressDetails());
                                                      },
                                                      child: Text(
                                                        'Enter Drop here...',
                                                        style: primaryfont
                                                            .copyWith(
                                                          fontSize: 13.sp,
                                                          color:
                                                              Color(0xff455A64),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: homeController
                                                          .vehicalCheck.value,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          homeController
                                                              .roundCheck(
                                                                  value!);
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      'Round Trip',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontSize: 17.sp,
                                                        color:
                                                            Color(0xff455A64),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                index ==
                                                        homeController
                                                                .vehicalEntries
                                                                .length -
                                                            1
                                                    ? // Only show on last item
                                                    Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                homeController
                                                                    .addVehicalEntry(); // Add new entry
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.blue,
                                                              size: 19,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                homeController
                                                                    .addVehicalEntry();
                                                              });
                                                            },
                                                            child: Text(
                                                              'Add Location',
                                                              style: primaryfont
                                                                  .copyWith(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: const Color(
                                                                    0xff0072E8),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  homeController
                                                                      .removeVehicalEntry(
                                                                          index);
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ))
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              ksizedbox30,
                              VehicleBookingContainerWidget(),
                            ],
                          ),
                        ),
                        ksizedbox20,
                        InkWell(
                          onTap: () {
                            Get.to(DriverBookingDetails());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: AppColors.kblue,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                'Next',
                                style: primaryfont.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kwhite),
                              ),
                            ),
                          ),
                        ),
                        ksizedbox10,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
