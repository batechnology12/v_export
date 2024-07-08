import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/home_screen_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/notification/shimmer.dart';

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
  String formateTime = "";

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
              size: 20,
              color: AppColors.kwhite,
            ),
          ),
        ),
        title: Text(
          'Notification',
          style: primaryfont.copyWith(
              fontSize: 22.sp,
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
                          padding:
                              EdgeInsets.only(right: 15, left: 15, top: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Today',
                                      style: primaryfont.copyWith(
                                          color: Color(0xff263238),
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Mark all as read',
                                      style: primaryfont.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.sp,
                                          color: AppColors.kblue),
                                    )
                                  ],
                                ),
                                GetBuilder<HomeScreenController>(builder: (_) {
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: homeScreenController
                                          .notificationList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 50.h,
                                                      width: 50.w,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors
                                                              .grey.shade200),
                                                      child: Center(
                                                        child: Image.asset(
                                                            "assets/images/notifi_profile1.png"),
                                                      ),
                                                    ),
                                                    Ksizedboxw10,
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 7, top: 7),
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
                                                                fontSize: 18.sp,
                                                                color: const Color(
                                                                    0xff263238),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5),
                                                            child: Container(
                                                              width: 210.w,
                                                              child: Text(
                                                                homeScreenController
                                                                    .notificationList[
                                                                        index]
                                                                    .description,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  formateTime = formatDate(
                                                      homeScreenController
                                                          .notificationList[
                                                              index]
                                                          .createdAt,
                                                      [HH, ':', nn, " ", am]),
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
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
