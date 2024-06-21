import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/booking_status.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/cancel_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/complete_details.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyListState();
}

class _MyListState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.kblue,
        appBar: AppBar(
          backgroundColor: AppColors.kblue,
          centerTitle: true,
          leading: Container(),
          title: Text(
            'My Order',
            style: primaryfont.copyWith(
                fontSize: 21.sp,
                color: AppColors.kwhite,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Get.to(NotificationView());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/icons/notification_icon.png',
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Color(0xff9E9E9E),
                indicatorColor: AppColors.kblue,
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 4.0,
                      color: AppColors.kblue,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 90.0)),
                tabs: [
                  Tab(
                    child: Text(
                      "Ongoing",
                      style: primaryfont.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Completed",
                      style: primaryfont.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Cancelled",
                      style: primaryfont.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 4,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.09),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(bottom: 10, top: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Booking ID : #ZAG01',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.5),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(BookingStatus());
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        ksizedbox10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Color(0xff038484),
                                                    ),
                                                    Dash(
                                                        direction:
                                                            Axis.vertical,
                                                        length: 60,
                                                        dashLength: 5,
                                                        dashColor:
                                                            AppColors.kgrey),
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Color(0xffF74354),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Pickup Details',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        ),
                                                        Container(
                                                          width: 250.h,
                                                          child: Text(
                                                            '338 Serangoon North',
                                                            style: primaryfont.copyWith(
                                                                color: Color(
                                                                    0xff1E1E1E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 40.h,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Delivery details',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        ),
                                                        Container(
                                                          width: 250.h,
                                                          child: Text(
                                                            '338 Serangoon North ave 6',
                                                            style: primaryfont.copyWith(
                                                                color: Color(
                                                                    0xff1E1E1E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: size.height * .12,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '2PM to 5PM',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      Text(
                                                        '3PM to 6PM',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        ksizedbox10,
                                        Divider(),
                                        ksizedbox10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Pickup Date',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    '25/04/2024',
                                                    style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Delivery Date',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    '25/04/2024',
                                                    style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Status',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff455A64)),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    'Assigned',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors.kblue),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 4,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.09),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(bottom: 10, top: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Booking ID : #ZAG01',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.5),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(CompleteDetails());
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        ksizedbox10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Color(0xff038484),
                                                    ),
                                                    Dash(
                                                        direction:
                                                            Axis.vertical,
                                                        length: 60,
                                                        dashLength: 5,
                                                        dashColor:
                                                            AppColors.kgrey),
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Color(0xffF74354),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Pickup Details',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        ),
                                                        Container(
                                                          width: 250.h,
                                                          child: Text(
                                                            '338 Serangoon North',
                                                            style: primaryfont.copyWith(
                                                                color: Color(
                                                                    0xff1E1E1E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 40.h,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Delivery details',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        ),
                                                        Container(
                                                          width: 250.h,
                                                          child: Text(
                                                            '338 Serangoon North ave 6',
                                                            style: primaryfont.copyWith(
                                                                color: Color(
                                                                    0xff1E1E1E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: size.height * .12,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '2PM to 5PM',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      Text(
                                                        '3PM to 6PM',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        ksizedbox10,
                                        Divider(),
                                        ksizedbox10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Pickup Date',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    '25/04/2024',
                                                    style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Delivery Date',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    '25/04/2024',
                                                    style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Status',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff455A64)),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    'Delivered',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff009200)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 4,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.09),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(bottom: 10, top: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Booking ID : #ZAG01',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.5),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(CancelDetals());
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffF5F5F5),
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        ksizedbox10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Color(0xff038484),
                                                    ),
                                                    Dash(
                                                        direction:
                                                            Axis.vertical,
                                                        length: 60,
                                                        dashLength: 5,
                                                        dashColor:
                                                            AppColors.kgrey),
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Color(0xffF74354),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Pickup Details',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        ),
                                                        Container(
                                                          width: 250.h,
                                                          child: Text(
                                                            '338 Serangoon North',
                                                            style: primaryfont.copyWith(
                                                                color: Color(
                                                                    0xff1E1E1E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 40.h,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Delivery details',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        ),
                                                        Container(
                                                          width: 250.h,
                                                          child: Text(
                                                            '338 Serangoon North ave 6',
                                                            style: primaryfont.copyWith(
                                                                color: Color(
                                                                    0xff1E1E1E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    15.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: size.height * .12,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '2PM to 5PM',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      Text(
                                                        '3PM to 6PM',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        ksizedbox10,
                                        Divider(),
                                        ksizedbox10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Pickup Date',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    '25/04/2024',
                                                    style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Delivery Date',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    '25/04/2024',
                                                    style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 65.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Status',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff455A64)),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    'Cancelled',
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.red),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
