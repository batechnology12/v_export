import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_rating.dart';

class CancelBooking extends StatefulWidget {
  String bookingCancelId;
  CancelBooking({super.key, required this.bookingCancelId});

  @override
  State<CancelBooking> createState() => _CancelBookingState();
}

class _CancelBookingState extends State<CancelBooking> {
  ParcelController parcelController = Get.put(ParcelController());
  TextEditingController reasonController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<bool> checkboxValues = [false, false, false, false, false];

  List<String> cancelBookingList = [
    "Parcel Not Ready",
    "Waiting Long Time",
    "Unable to contact driver",
    "Driver cancel Job",
    "Others"
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

  bool isSelected = false;

  bool others = false;

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
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.kwhite,
              size: 19,
            ),
          ),
        ),
        title: Text(
          'Cancel Booking',
          style: primaryfont.copyWith(
              fontSize: 18.sp,
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
                  height: size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Color(0xffF4F8FF),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                                        fontSize: 15.sp,
                                        color: Color(0xff455A64),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  ksizedbox20,
                                  Column(
                                    children: List.generate(
                                        cancelBookingList.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, bottom: 15),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              for (var i = 0;
                                                  i < checkboxValues.length;
                                                  i++) {
                                                checkboxValues[i] = false;
                                              }
                                              checkboxValues[index] = true;
                                              isSelected = true;

                                              if (cancelBookingList[index] ==
                                                  "Others") {
                                                others = true;
                                              } else {
                                                Get.snackbar("Alert",
                                                    "Please give reason for cancellation",
                                                    colorText: AppColors.kwhite,
                                                    backgroundColor: Colors.red,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM);
                                              }
                                            });
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      for (var i = 0;
                                                          i <
                                                              checkboxValues
                                                                  .length;
                                                          i++) {
                                                        checkboxValues[i] =
                                                            false;
                                                      }
                                                      checkboxValues[index] =
                                                          true;
                                                      isSelected = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 20.h,
                                                    width: 20.w,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .kblue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: checkboxValues[
                                                                index] ==
                                                            true
                                                        ? Image.asset(
                                                            "assets/icons/7-Check.png")
                                                        : Text(""),
                                                  ),
                                                ),
                                                Ksizedboxw10,
                                                Text(
                                                  cancelBookingList[index],
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  ksizedbox20,
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    height: 100.h,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF8F8F8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 100,
                                      controller: reasonController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 10, top: 10),
                                        hintText: 'Type here reason...',
                                        hintStyle: primaryfont.copyWith(
                                            color: Color(0xff455A64),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (isSelected == true ||
              others == true && reasonController.text.isNotEmpty) {
            print(" cancelled");
            popUp();
            //  parcelController.cancelBooking(widget.bookingCancelId);
            // if (others == true && reasonController.text.isNotEmpty) {
            //   // parcelController.cancelBooking(widget.bookingCancelId);
            // } else {
            //   Get.snackbar("Alert", "Please enter the reason for cancellation",
            //       colorText: AppColors.kwhite,
            //       backgroundColor: Colors.red,
            //       snackPosition: SnackPosition.BOTTOM);
            //    }
          } else {
            Get.snackbar("Please try again!",
                "Please select the above reason for cancellation",
                colorText: AppColors.kwhite,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM);
          }

          //  popUp();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CommonContainer(
            name: "Confirm Cancel",
          ),
        ),
      ),
    );
  }

  popUp() {
    var size1 = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            // height: 470.h,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  ksizedbox10,
                  Image.asset("assets/icons/cancel.png"),
                  ksizedbox10,
                  Text(
                    "Booking Cancelled",
                    textAlign: TextAlign.center,
                    style: primaryfont.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2A2A2A)),
                  ),
                  Text(
                    "Successfully!",
                    textAlign: TextAlign.center,
                    style: primaryfont.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2A2A2A)),
                  ),
                  ksizedbox10,
                  Text(
                    "We will continue to improve our service &",
                    textAlign: TextAlign.center,
                    style: primaryfont.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff898989)),
                  ),
                  Text(
                    "satify you on the next trip.",
                    textAlign: TextAlign.center,
                    style: primaryfont.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff898989)),
                  ),
                  ksizedbox20,
                  GestureDetector(
                    onTap: () {
                      parcelController.cancelBooking(widget.bookingCancelId);
                    },
                    child: CommonContainer(
                      name: "Go It",
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
