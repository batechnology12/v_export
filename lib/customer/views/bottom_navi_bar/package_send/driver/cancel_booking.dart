import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_rating.dart';

class CancelBooking extends StatefulWidget {
  const CancelBooking({super.key});

  @override
  State<CancelBooking> createState() => _CancelBookingState();
}

class _CancelBookingState extends State<CancelBooking> {
  TextEditingController reasonController = TextEditingController();

  List<bool> checkboxValues = [false, false, false, false, false];
  List<String> cancelBookingList = [
    "Parcel Not Ready",
    "Waiting Long Time",
    "Unable to contact driver",
    "Unable to contact driver",
    "Unable to contact driver"
  ];
  updateCheckbox(int index, bool? value) {
    setState(() {
      for (var i = 0; i < checkboxValues.length; i++) {
        if (i == index) {
          checkboxValues[i] = value ?? false;
        } else {
          checkboxValues[i] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: const BoxDecoration(
          color: AppColors.kblue,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: AppColors.kwhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.25),
                      child: Text(
                        'Cancel Booking',
                        style: primaryfont.copyWith(
                            fontSize: 19.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: AppColors.kwhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17))),
                  child: Column(
                    children: [
                      ksizedbox30,
                      Text(
                        'Please select the reason for cancellations:',
                        style: primaryfont.copyWith(
                            fontSize: 16.sp,
                            color: Color(0xff455A64),
                            fontWeight: FontWeight.w600),
                      ),
                      ksizedbox20,
                      Column(
                        children:
                            List.generate(cancelBookingList.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                // Container(
                                //   decoration: BoxDecoration(
                                //     border: Border.all(
                                //       color: Colors.black,
                                //       width: 2.0,
                                //     ),
                                //     borderRadius: BorderRadius.circular(4.0),
                                //   ),
                                //   child:
                                Checkbox(
                                  value: checkboxValues[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      updateCheckbox(index, value);
                                    });
                                  },
                                ),
                                // ),
                                Ksizedboxw10,
                                Text(
                                  cancelBookingList[index],
                                  style: primaryfont.copyWith(
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      ksizedbox20,
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        height: 100.h,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Color(0xffF8F8F8),
                            borderRadius: BorderRadius.circular(12)),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          maxLines: 100,
                          controller: reasonController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10, top: 10),
                            hintText: 'Type here reason...',
                            hintStyle: primaryfont.copyWith(
                                color: Color(0xff455A64),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      ksizedbox30,
                      GestureDetector(
                        onTap: () {
                          Get.to(DriverRating());
                        },
                        child: CommonContainer(
                          name: "Confirm Cancel",
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

  