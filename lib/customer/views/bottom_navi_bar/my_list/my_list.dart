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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: Container(
                height: 50.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        'My Order',
                        style: primaryfont.copyWith(
                            fontSize: 21.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w600),
                      ),
                      Image.asset(
                        "assets/icons/notification_icon.png",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
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
                                    margin: EdgeInsets.only(top: 10),
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: AppColors.kwhite,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              offset: Offset(0.0, 0.95),
                                              blurRadius: 4,
                                              color: AppColors.kgrey)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
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
                                                  decoration: BoxDecoration(
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xff038484),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Pickup Address',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      Text(
                                                        '338C Anchorvale Cresent',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    15.sp),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 11,
                                                            bottom: 13),
                                                    child: Text('2PM to 5PM'),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11),
                                                child: Dash(
                                                    direction: Axis.vertical,
                                                    length: 50,
                                                    dashLength: 5,
                                                    dashColor: AppColors.kgrey),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xffF74354),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Delivery Address',
                                                            style: primaryfont.copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        '338 Serangoon North ave 6',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    15.sp),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1,
                                                            bottom: 13),
                                                    child: Text('3PM to 6PM'),
                                                  ),
                                                ],
                                              ),
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
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      '25/04/2024',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      '25/04/2024',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      'Assigned',
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .kblue),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          ksizedbox10,
                                        ],
                                      ),
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
                                    margin: EdgeInsets.only(top: 10),
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: AppColors.kwhite,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              offset: Offset(0.0, 0.95),
                                              blurRadius: 4,
                                              color: AppColors.kgrey)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
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
                                                  decoration: BoxDecoration(
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xff038484),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Pickup Address',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      Text(
                                                        '338C Anchorvale Cresent',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    15.sp),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 11,
                                                            bottom: 13),
                                                    child: Text('2PM to 5PM'),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11),
                                                child: Dash(
                                                    direction: Axis.vertical,
                                                    length: 50,
                                                    dashLength: 5,
                                                    dashColor: AppColors.kgrey),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xffF74354),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Delivery Address',
                                                            style: primaryfont.copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        '338 Serangoon North ave 6',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    15.sp),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1,
                                                            bottom: 13),
                                                    child: Text('3PM to 6PM'),
                                                  ),
                                                ],
                                              ),
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
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      '25/04/2024',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      '25/04/2024',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      'Delivered',
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff009200)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          ksizedbox10,
                                        ],
                                      ),
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
                                    margin: EdgeInsets.only(top: 10),
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: AppColors.kwhite,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              offset: Offset(0.0, 0.95),
                                              blurRadius: 4,
                                              color: AppColors.kgrey)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
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
                                                  decoration: BoxDecoration(
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xff038484),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Pickup Address',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      Text(
                                                        '338C Anchorvale Cresent',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    15.sp),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 11,
                                                            bottom: 13),
                                                    child: Text('2PM to 5PM'),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 11),
                                                child: Dash(
                                                    direction: Axis.vertical,
                                                    length: 50,
                                                    dashLength: 5,
                                                    dashColor: AppColors.kgrey),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xffF74354),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Delivery Address',
                                                            style: primaryfont.copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        '338 Serangoon North ave 6',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    15.sp),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1,
                                                            bottom: 13),
                                                    child: Text('3PM to 6PM'),
                                                  ),
                                                ],
                                              ),
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
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      '25/04/2024',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      '25/04/2024',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 65,
                                                width: 100,
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
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      'Cancelled',
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          ksizedbox10,
                                        ],
                                      ),
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
