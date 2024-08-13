import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/home_screen_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/notification/shimmer.dart';
import 'package:intl/intl.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeScreenController.getNotification();
      homeScreenController.update();
    });
  }

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  String formateDate = "";

  String dateShowing(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final today = DateTime.now().toLocal();
    final tomorrow = today.add(Duration(days: 1)).toLocal();

    final todayDateOnly = DateTime(today.year, today.month, today.day);
    final dateTimeDateOnly =
        DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateTimeDateOnly.isAtSameMomentAs(todayDateOnly)) {
      return "Today";
    } else if (dateTimeDateOnly.isAtSameMomentAs(tomorrow)) {
      return "Tomorrow";
    } else {
      return formatter.format(dateTime);
    }
  }

  String formatElapsedTime(DateTime createdAt) {
    DateTime now = DateTime.now();

    Duration difference = now.difference(createdAt);

    int hours = difference.inHours;

    if (hours < 1) {
      // For minutes
      int minutes = difference.inMinutes;
      return minutes == 0
          ? 'Just now'
          : '$minutes min${minutes > 1 ? 's' : ''}';
    } else if (hours == 1) {
      return '1 hr';
    } else {
      return '$hours hrs';
    }
  }

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
            Get.to(BottomNavigationScreen());
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              size: 18,
              color: AppColors.kwhite,
            ),
          ),
        ),
        title: Text(
          'Notification',
          style: primaryfont.copyWith(
              fontSize: 18.sp,
              color: Color(0xffF4F8FF),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
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
                height: size.height,
                decoration: const BoxDecoration(
                    color: AppColors.kwhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17))),
                child: Obx(() {
                  return homeScreenController.notificationLoading.isTrue
                      ? const Shimmering()
                      : Padding(
                          padding: EdgeInsets.only(right: 15, left: 15, top: 1),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetBuilder<HomeScreenController>(builder: (_) {
                                  return homeScreenController
                                          .notificationList.isEmpty
                                      ? Center(
                                          child: Text("Nodata"),
                                        )
                                      : ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: homeScreenController
                                              .notificationList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          dateShowing(
                                                            homeScreenController
                                                                .notificationList[
                                                                    index]
                                                                .createdAt,
                                                          ),
                                                          style: primaryfont
                                                              .copyWith(
                                                                  color: Color(
                                                                      0xff263238),
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        Text(
                                                          'Mark all as read',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: AppColors
                                                                      .kblue),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 40.h,
                                                              width: 40.w,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200),
                                                              child: Center(
                                                                child: Image.asset(
                                                                    "assets/images/notifi_profile1.png"),
                                                              ),
                                                            ),
                                                            Ksizedboxw10,
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 7,
                                                                      top: 7),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    homeScreenController
                                                                        .notificationList[
                                                                            index]
                                                                        .title,
                                                                    style: primaryfont.copyWith(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        color: const Color(
                                                                            0xff263238),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 5),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          200.w,
                                                                      child:
                                                                          Text(
                                                                        homeScreenController
                                                                            .notificationList[index]
                                                                            .description,
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: primaryfont.copyWith(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          // formateTime = formatDate(
                                                          //     homeScreenController
                                                          //         .notificationList[
                                                          //             index]
                                                          //         .createdAt,
                                                          //     [HH, ':', nn, " ", am]),
                                                          formatElapsedTime(
                                                              homeScreenController
                                                                  .notificationList[
                                                                      index]
                                                                  .createdAt),
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                }),
                              ],
                            ),
                          ),
                        );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
