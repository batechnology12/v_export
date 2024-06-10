import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/cancel_booking.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_container_widget.dart';

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
              child:
               Container(
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
                        GestureDetector(
                          onTap: () {
                            popUp();
                          },
                          child: Icon(
                            Icons.help_outline_outlined,
                            color: AppColors.kwhite,
                            size: 30,
                          ),
                        )
                      ]),
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
                  padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: DriverContainerWidget(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  popUp() {
    bool isEditDetailsChecked = false;
    bool isCancelBookingChecked = false;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
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
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ))
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                side: BorderSide(width: 1, color: Colors.black),
                activeColor: Colors.grey.withOpacity(.50),
                checkColor: AppColors.kblue,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'Edit Details?',
                  style: primaryfont.copyWith(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                value: isEditDetailsChecked,
                onChanged: (value) {
                  setState(() {
                    isEditDetailsChecked = value ?? false;
                    if (isEditDetailsChecked) {
                      isCancelBookingChecked =
                          false; // Uncheck cancel booking if edit details is checked
                    }
                  });
                },
              ),
              CheckboxListTile(
                  side: BorderSide(width: 1, color: Colors.black),
                  checkColor: AppColors.kblue,
                  activeColor: Colors.grey.withOpacity(.50),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'Cancel Booking',
                    style: primaryfont.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  value: isCancelBookingChecked,
                  onChanged: (value) {
                    setState(() {
                      isCancelBookingChecked = value ?? false;
                      if (isCancelBookingChecked) {
                        isEditDetailsChecked =
                            false; // Uncheck edit details if cancel booking is checked
                      }
                    });
                  }),
            ],
          ),
          actions: [
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
                    borderRadius: BorderRadius.circular(20)),
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
        );
      },
    );
  }
}
