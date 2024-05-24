import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/home/package_send/driver/driver_container_widget.dart';

class DriverDetailsScreen extends StatefulWidget {
  const DriverDetailsScreen({super.key});

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: SafeArea(
        child: Column(
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
                          'Driver Details',
                          style: primaryfont.copyWith(
                              fontSize: 18.sp,
                              color: AppColors.kwhite,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.help_outline_outlined,
                        color: AppColors.kwhite,
                        size: 30,)
                      ]
                    ),
                  ),
                 ),
               ),
               Expanded(
                flex: 7,
                 child: Container(
              
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                     color: AppColors.kwhite,
                  ),
                 child: Padding(
                   padding: const EdgeInsets.only(top: 15,left: 5,right: 5),
                   child: DriverContainerWidget(),
                 ),
                 ),
               )
          ],
        ),
      ),
    );
  }
}