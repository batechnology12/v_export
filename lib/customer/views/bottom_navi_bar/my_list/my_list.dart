import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/model/get_ongoing_orders_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/booking_status.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/cancel_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/complete_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/get_canceled_orders_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/get_completed_orders_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/get_ongoing_orders_screen.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyListState();
}

class _MyListState extends State<MyOrder> {
  MyListController myListController = Get.find<MyListController>();
  @override
  void initState() {
    super.initState();
    // getData();
  }

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }

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
                    GetOngoingScreenData(),
                    GetCompletedScreenData(),
                    GetCancelledScreenData(),
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
