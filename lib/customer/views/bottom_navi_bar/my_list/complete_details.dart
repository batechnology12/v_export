import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/get_booking_details_model.dart';
import 'package:v_export/customer/model/get_completed_orders_model.dart';
import 'package:intl/intl.dart';

class CompleteDetails extends StatefulWidget {
  GetCompletedOrdersModelData getCompletedData;

  CompleteDetails({super.key, required this.getCompletedData});

  @override
  State<CompleteDetails> createState() => _CompleteDetailsState();
}

class _CompleteDetailsState extends State<CompleteDetails> {
  final ParcelController parcelController = Get.put(ParcelController());
  final MyListController myListController = Get.put(MyListController());

  @override
  void initState() {
    super.initState();
    parcelController.paymentshow(widget.getCompletedData.id.toString());
    finalTotal;
  }

  double finalTotal = 0;
  String formatTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);

      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.kblue,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Deliver Details',
          style: primaryfont.copyWith(
              fontSize: 18.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: GetBuilder<ParcelController>(builder: (_) {
        return parcelController.paymentdata.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      height: size.height,
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffF4F8FF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 15, right: 10),
                        child: SingleChildScrollView(
                          child: parcelController.paymentdata.isEmpty
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 5),
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          color: AppColors.kwhite,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: Container(
                                                  // color: Colors.amber,
                                                  height: 60.h,
                                                  width: 60.w,
                                                  child: Image.network(
                                                    widget.getCompletedData
                                                        .driver.imageUrl,
                                                    fit: BoxFit.cover,
                                                    // height: 50,
                                                    // width: 50,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.h,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.getCompletedData
                                                        .driver.firstName,
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 17.sp),
                                                  ),
                                                  Text(
                                                    "Vehicle Driver",
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff455A64),
                                                        fontSize: 13.sp),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      ),
                                                      Ksizedboxw10,
                                                      Text(
                                                        widget.getCompletedData
                                                            .ratings.rating
                                                            .toString(),
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    16.sp),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                height: 35.h,
                                                width: 100.w,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffBFFFC1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  'Delivered',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                      color: Color(0xff009200)),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    ksizedbox10,
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: AppColors.kwhite,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Booking ID : ${widget.getCompletedData.bookingId}',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14.sp),
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xffF5F5F5),
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          ksizedbox10,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 0),
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color:
                                                              Color(0xff038484),
                                                        ),
                                                        Dash(
                                                            direction:
                                                                Axis.vertical,
                                                            length: 55,
                                                            dashLength: 5,
                                                            dashColor: AppColors
                                                                .kgrey),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
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
                                                      Container(
                                                        width: 300.w,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 225.h,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${widget.getCompletedData.pickupAddreess}",
                                                                    style: primaryfont.copyWith(
                                                                        color: const Color(
                                                                            0xff1E1E1E),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            12.sp),
                                                                  ),
                                                                  Text(
                                                                    "${widget.getCompletedData.senderUnitnoBlockno}, UnitNo: ${widget.getCompletedData.unitno}",
                                                                    style: primaryfont.copyWith(
                                                                        color: const Color(
                                                                            0xff1E1E1E),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            12.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                              //   ExpandableText(
                                                              // "${widget.getCompletedData.senderUnitnoBlockno}, ${widget.getCompletedData.pickupAddreess}, ${widget.getCompletedData.unitno}",
                                                              // expandText:
                                                              //     'show more',
                                                              // collapseText:
                                                              //     'show less',
                                                              // maxLines: 2,
                                                              // linkColor:
                                                              //     Colors.blue,
                                                              // style: primaryfont.copyWith(
                                                              //     color: const Color(
                                                              //         0xff1E1E1E),
                                                              //     fontWeight:
                                                              //         FontWeight
                                                              //             .w600,
                                                              //     fontSize:
                                                              //         12.sp),
                                                              //   ),
                                                            ),
                                                            Text(
                                                              widget.getCompletedData
                                                                          .payable ==
                                                                      "sender"
                                                                  ? "Cash on \nDelivery"
                                                                  : "",
                                                              style: primaryfont.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      ksizedbox5,
                                                      widget.getCompletedData
                                                                  .pickupedAt ==
                                                              ""
                                                          ? Text(
                                                              "",
                                                              style: primaryfont.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                            )
                                                          : RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Picked At: ",
                                                                    style: primaryfont
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colors
                                                                              .green[
                                                                          400],
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: formatTime(widget
                                                                        .getCompletedData
                                                                        .pickupedAt),
                                                                    style: primaryfont
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Color(
                                                                          0xff455A64),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                      ksizedbox5,
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: widget
                                                  .getCompletedData
                                                  .bookingDeliveryAddresses
                                                  .length,
                                              itemBuilder: ((context, index) {
                                                BookingCompletedDeliveryAddress
                                                    bookingcompleteddeliveryDatalist =
                                                    widget.getCompletedData
                                                            .bookingDeliveryAddresses[
                                                        index];
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color: Color(
                                                                  0xffF74354),
                                                            ),
                                                            if (index !=
                                                                widget
                                                                        .getCompletedData
                                                                        .bookingDeliveryAddresses
                                                                        .length -
                                                                    1)
                                                              Dash(
                                                                  direction: Axis
                                                                      .vertical,
                                                                  length: 50,
                                                                  dashLength: 5,
                                                                  dashColor:
                                                                      AppColors
                                                                          .kgrey),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Delivery Address',
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                            ),
                                                            Container(
                                                              width: 300.w,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        230.h,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "${bookingcompleteddeliveryDatalist.address}",
                                                                          style: primaryfont.copyWith(
                                                                              color: const Color(0xff1E1E1E),
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12.sp),
                                                                        ),
                                                                        Text(
                                                                          "${bookingcompleteddeliveryDatalist.unitnoBlockno}, UnitNo: ${bookingcompleteddeliveryDatalist.unitno}",
                                                                          style: primaryfont.copyWith(
                                                                              color: const Color(0xff1E1E1E),
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12.sp),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    //     ExpandableText(
                                                                    //   "${bookingcompleteddeliveryDatalist.unitnoBlockno}, ${bookingcompleteddeliveryDatalist.address}, ${bookingcompleteddeliveryDatalist.unitno}",
                                                                    //   expandText:
                                                                    //       'show more',
                                                                    //   collapseText:
                                                                    //       'show less',
                                                                    //   maxLines:
                                                                    //       2,
                                                                    //   linkColor:
                                                                    //       Colors
                                                                    //           .blue,
                                                                    //   style: primaryfont.copyWith(
                                                                    //       color: const Color(
                                                                    //           0xff1E1E1E),
                                                                    //       fontWeight: FontWeight
                                                                    //           .w600,
                                                                    //       fontSize:
                                                                    //           12.sp),
                                                                    // ),
                                                                  ),
                                                                  if (index ==
                                                                      widget.getCompletedData.bookingDeliveryAddresses
                                                                              .length -
                                                                          1)
                                                                    Text(
                                                                      widget.getCompletedData.payable ==
                                                                              "receiver"
                                                                          ? "Cash on \nDelivery"
                                                                          : "",
                                                                      style: primaryfont.copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize: 11
                                                                              .sp,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    )
                                                                ],
                                                              ),
                                                            ),
                                                            ksizedbox5,
                                                            widget
                                                                        .getCompletedData
                                                                        .bookingDeliveryAddresses[
                                                                            index]
                                                                        .deliveryAt ==
                                                                    ""
                                                                ? Text(
                                                                    "",
                                                                    style: primaryfont.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize: 10
                                                                            .sp,
                                                                        color: Color(
                                                                            0xff455A64)),
                                                                  )
                                                                : RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              "Delivered At: ",
                                                                          style:
                                                                              primaryfont.copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontSize:
                                                                                12.sp,
                                                                            color:
                                                                                Colors.red[400],
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text: formatTime(widget
                                                                              .getCompletedData
                                                                              .bookingDeliveryAddresses[index]
                                                                              .deliveryAt),
                                                                          style:
                                                                              primaryfont.copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontSize:
                                                                                12.sp,
                                                                            color:
                                                                                Color(0xff455A64),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),

                                                            //  Text(
                                                            //     "Delivered: ${formatTime(widget.getCompletedData.bookingDeliveryAddresses[index].deliveryAt)}",
                                                            //     style: primaryfont.copyWith(
                                                            //         fontWeight:
                                                            //             FontWeight
                                                            //                 .w700,
                                                            //         fontSize: 12
                                                            //             .sp,
                                                            //         color: Color(
                                                            //             0xff455A64)),
                                                            //   ),
                                                            // Text(
                                                            //   formatTime(widget
                                                            //       .getCompletedData
                                                            //       .bookingDeliveryAddresses[
                                                            //           index]
                                                            //       .deliveryAt),
                                                            //   style: primaryfont.copyWith(
                                                            //       fontWeight:
                                                            //           FontWeight
                                                            //               .w700,
                                                            //       fontSize:
                                                            //           12.sp,
                                                            //       color: Color(
                                                            //           0xff455A64)),
                                                            // )
                                                            // : Container(),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              })),
                                        ],
                                      ),
                                    ),
                                    ksizedbox10,
                                    // // //
                                    Container(
                                      width: size.width,
                                      padding: EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                          color: AppColors.kwhite,
                                          borderRadius:
                                              BorderRadius.circular(17)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Bill Details',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ],
                                                  ),
                                                  ksizedbox5,
                                                  Divider(),
                                                  ksizedbox10,
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Delivery Fees',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        ),
                                                        Text(
                                                          "\$${parcelController.paymentdata.first.paymentDetails.deliveryfees}",
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  GetBuilder<ParcelController>(
                                                      builder: (context) {
                                                    return Column(
                                                      children: [
                                                        parcelController
                                                                .paymentdata
                                                                .first
                                                                .paymentDetails
                                                                .additionalServices
                                                                .isEmpty
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 5,
                                                                        right:
                                                                            20),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Additonal Service",
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                                    Text(
                                                                      "-",
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount: parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .additionalServices
                                                                    .length,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  PaymentDetailsAdditionalService
                                                                      addAdditionalservicelists =
                                                                      parcelController
                                                                          .paymentdata
                                                                          .first
                                                                          .paymentDetails
                                                                          .additionalServices[index];
                                                                  return Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          addAdditionalservicelists
                                                                              .name,
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                        Text(
                                                                          "\$${double.tryParse(addAdditionalservicelists.value)?.toStringAsFixed(2) ?? '0.00'}",
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                        parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .additionalStopCount ==
                                                                "0.00"
                                                            ? Container()
                                                            : parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .additionalStopCount
                                                                    .isEmpty
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Additional Stop',
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                        Text(
                                                                          "\$${parcelController.paymentdata.first.paymentDetails.additionalStopCount}",
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                        parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .roundtripCost ==
                                                                "0.00"
                                                            ? Container()
                                                            : parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .roundtripCost
                                                                    .isEmpty
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Round Trip cost',
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                        Text(
                                                                          "\$${parcelController.paymentdata.first.paymentDetails.roundtripCost}",
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                        parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .weekend ==
                                                                "0.00"
                                                            ? Container()
                                                            : parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .weekend
                                                                    .isEmpty
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Weekend Cost',
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                        Text(
                                                                          "\$${parcelController.paymentdata.first.paymentDetails.weekend}",
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                        parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .driverHelpCost ==
                                                                "0.00"
                                                            ? Container()
                                                            : parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .driverHelpCost
                                                                    .isEmpty
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Driver Help Stop',
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                        Text(
                                                                          "\$${parcelController.paymentdata.first.paymentDetails.driverHelpCost}",
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                        parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .helperCost ==
                                                                "0.00"
                                                            ? Container()
                                                            : parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .helperCost
                                                                    .isEmpty
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Helper Cost',
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                        Text(
                                                                          "\$${parcelController.paymentdata.first.paymentDetails.helperCost}",
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                        parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .discount ==
                                                                "0.00"
                                                            ? Container()
                                                            : parcelController
                                                                    .paymentdata
                                                                    .first
                                                                    .paymentDetails
                                                                    .discount
                                                                    .isEmpty
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Discount',
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                        Text(
                                                                          "${parcelController.paymentdata.first.paymentDetails.discount}",
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 5,
                                                                  vertical: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Total Amount',
                                                                style: primaryfont
                                                                    .copyWith(
                                                                  fontSize:
                                                                      16.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                "\$${parcelController.paymentdata.first.paymentDetails.total}",
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: const Color(
                                                                        0xff455A64)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ksizedbox10,
                                    Container(
                                      padding: EdgeInsets.only(bottom: 15),
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          color: AppColors.kwhite,
                                          // boxShadow: <BoxShadow>[
                                          //   BoxShadow(
                                          //       offset: Offset(0.0, 0.95),
                                          //       blurRadius: 4,
                                          //       color: AppColors.kgrey)
                                          // ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Payment Method',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xff1E1E1E),
                                                      fontSize: 16.sp),
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            ksizedbox10,
                                            GetBuilder<ParcelController>(
                                                builder: (context) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    widget.getCompletedData
                                                        .paymentMode,
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 15.sp),
                                                  ),
                                                  Text(
                                                    "\$${parcelController.paymentdata.first.paymentDetails.total}",
                                                    style: primaryfont.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 16.sp),
                                                  ),
                                                ],
                                              );
                                            }),
                                            ksizedbox10,
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(5),
                                              dashPattern: [6, 6],
                                              color: AppColors.kblue,
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  height: 45.h,
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffE5F2FF),
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Get Invoice Copy',
                                                          style: primaryfont
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 17,
                                                            color: Color(
                                                                0xff1204D4),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          color:
                                                              Color(0xff1204D4),
                                                        ),
                                                      ])),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ksizedbox30,
                                  ],
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              );
      }),
    );
  }
}
