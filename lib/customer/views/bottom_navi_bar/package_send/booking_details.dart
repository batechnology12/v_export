import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';
import 'package:v_export/customer/model/booking_review_detalis_model.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';
import 'package:intl/intl.dart';
import '../../../../constant/app_font.dart';

class BookingDetailsScreen extends StatefulWidget {
  BookingData bookingdatalist;
  BookingDetailsScreen({super.key, required this.bookingdatalist});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  var couponController = TextEditingController();

  final easebuzzController = Get.find<EasebuszzController>();

  List paymentDetails = [
    "Delivery Fees",
    "Additional Surcharge",
    "Additional Surcharge",
    "Post Invoice",
    "Fragil Item",
    "GST"
  ];

  final formKey = GlobalKey<FormState>();

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }
  //   String formatTime(TimeOfDay time) {
  //   final now = DateTime.now();
  //   final formattedTime = DateFormat('h:mm a').format(DateTime(
  //     now.year,
  //     now.month,
  //     now.day,
  //     time.hour,
  //     time.minute,
  //   ));
  //   return formattedTime;
  // }

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
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.kwhite,
            ),
          ),
        ),
        title: Text(
          'Booking Details',
          style: primaryfont.copyWith(
              fontSize: 21.sp,
              color: Color(0xffF4F8FF),
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
                          // for (var booking in widget.bookingdatalist)
                          //   for (var bookingaddress
                          //       in booking.bookingDeliveryAddresses)
                          //     for (var bookingproject
                          //         in booking.bookingProducts)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: Column(children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.kwhite,
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          offset: Offset(0.0, 0.75),
                                          blurRadius: 3,
                                          color: AppColors.kgrey)
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Booking Details',
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff1E1E1E),
                                                fontSize: 19.sp),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Pickup details',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            formatDate(
                                                DateTime.parse(widget
                                                    .bookingdatalist.bookingDate
                                                    .toString()),
                                                [dd, '-', mm, '-', yyyy]),
                                            style: primaryfont.copyWith(
                                                color: Color(0xff455A64),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${formatTime(widget.bookingdatalist.bookingProducts.first.pickuptimeFrom)} to ${formatTime(widget.bookingdatalist.bookingProducts.first.pickuptimeTo)}",
                                            style: primaryfont.copyWith(
                                                color: Color(0xff455A64),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          width: size.width,
                                          child: Text(
                                            // bookingaddress.address,
                                            widget
                                                .bookingdatalist.pickupAddreess,
                                            style: primaryfont.copyWith(
                                                fontSize: 14.sp,
                                                color: Color(0xff1E1E1E),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      ksizedbox15,
                                      Divider(),
                                      ksizedbox10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Delivery details',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            formatDate(
                                                DateTime.parse(widget
                                                    .bookingdatalist
                                                    .bookingProducts
                                                    .first
                                                    .deliveryDate
                                                    .toString()),
                                                [dd, '-', mm, '-', yyyy]),
                                            style: primaryfont.copyWith(
                                                color: Color(0xff455A64),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${formatTime(widget.bookingdatalist.bookingProducts.first.deliverytimeFrom)} to ${formatTime(widget.bookingdatalist.bookingProducts.first.deliverytimeTo)}",
                                            style: primaryfont.copyWith(
                                                color: Color(0xff455A64),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          width: size.width,
                                          child: Text(
                                            widget
                                                .bookingdatalist
                                                .bookingDeliveryAddresses
                                                .first
                                                .address,
                                            style: primaryfont.copyWith(
                                                fontSize: 14.sp,
                                                color: Color(0xff1E1E1E),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      ksizedbox10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Delivery Type :',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            widget.bookingdatalist
                                                .deliveryTypeName,
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Parcel Item:',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${widget.bookingdatalist.bookingProducts.first.parcelItems}",
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Parcel Length :',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${widget.bookingdatalist.bookingProducts.first.length} L",
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Parcel Width :',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${widget.bookingdatalist.bookingProducts.first.bookingProductWith} W",
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Parcel Height :',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${widget.bookingdatalist.bookingProducts.first.height} H",
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Parcel Weight :',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${widget.bookingdatalist.bookingProducts.first.kg} Kg",
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Parcel Quantity :',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${widget.bookingdatalist.bookingProducts.first.qty} Qty",
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox15,
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Additional Services :',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            widget.bookingdatalist
                                                .additionalServices.first.name,
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox5,
                                      Divider(),
                                      ksizedbox5,
                                      Text(
                                        'Driver Notes',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          'Call me before reaching and wait at lobby 6B',
                                          style: primaryfont.copyWith(
                                              fontSize: 15.sp,
                                              color: Color(0xff1E1E1E),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      ksizedbox20,
                                    ],
                                  ),
                                ),
                              ),
                              ksizedbox20,
                              Container(
                                height: 120,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.kwhite,
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          offset: Offset(0.0, 0.75),
                                          blurRadius: 2,
                                          color: AppColors.kgrey)
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Apply Coupon',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp),
                                      ),
                                      ksizedbox15,
                                      Container(
                                        height: 50.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextField(
                                          controller: couponController,
                                          decoration: InputDecoration(
                                              suffix: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 9),
                                                child: Container(
                                                  height: 38.h,
                                                  width: 80.w,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.kblue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: Text(
                                                      'Apply',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: AppColors
                                                                  .kwhite,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5))),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ksizedbox20,
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.kwhite,
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          offset: Offset(0.0, 0.75),
                                          blurRadius: 2,
                                          color: AppColors.kgrey)
                                    ],
                                    borderRadius: BorderRadius.circular(17)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Payment Details',
                                            style: primaryfont.copyWith(
                                                fontSize: 19.sp,
                                                color: Color(0xff1E1E1E),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      ksizedbox5,
                                      Divider(),
                                      ksizedbox10,
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: paymentDetails.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${paymentDetails[index]}",
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff455A64)),
                                                ),
                                                Text(
                                                  '+22.00',
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff455A64)),
                                                )
                                              ],
                                            );
                                          }),
                                      ksizedbox20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Amount',
                                            style: primaryfont.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            '+65.0',
                                            style: primaryfont.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                          ),
                          ksizedbox40,
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: InkWell(
                                onTap: () {
                                  easebuzzController
                                      .tablepayUseingEaseBuzzSubs();
                                },
                                child: CommonContainer(
                                  name: "Confirm Payment",
                                )),
                          ),
                          ksizedbox20,
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
    );
  }
}
