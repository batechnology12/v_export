import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/customer/views/home/package_send/booking_details_container_widget.dart';

import '../../../../constant/app_font.dart';


class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: SafeArea(child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.kblue,
              child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: AppColors.kwhite,
                          ),
                        ),
                        Text(
                          'Booking Details',
                          style: primaryfont.copyWith(
                              fontSize: 18.sp,
                              color: AppColors.kwhite,
                              fontWeight: FontWeight.w600),
                        ),
                           Image.asset('assets/icons/notification_icon.png',
                    color: AppColors.kwhite,)
                      ],
                    ),
                  ),
            ),

          ),
           Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                   color: AppColors.kwhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                topRight: Radius.circular(17))
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                child: 
                    BookingDetailsContainerWidget(),
                 
                 
              )
            ),
          )
        ],
      )),
    );
  }
}