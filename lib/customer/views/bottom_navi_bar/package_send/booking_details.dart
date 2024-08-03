import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/booking_review_detalis_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/make_payment_screen.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';
import 'package:intl/intl.dart';
import '../../../../constant/app_font.dart';

class BookingDetailsScreen extends StatefulWidget {
  String additionalservicetotalAmount;
  String pickupADDRESS;
  String pickpLATITUDE;
  String pickupLOGITUDE;
  List<String> droppingLATITUDE;
  List<String> droppingLOGITUDE;
  List<String> droppingADDRESS;
  String distance;
  String bookingDATE;
  String deliveryTYPE;
  int deliveryTypeID;
  List<String> parcelLengtH;
  List<String> parcelWidth;
  List<String> parcelHeight;
  List<String> parcelKg;
  List<String> parcelQty;
  String parcelITEMS;
  List<String> unitIdBlockID;
  String? pickTimeFROM;
  String? pickTimeTO;
  List<String> pickTimeListFROM;
  List<String> pickTimeListTO;
  String senderNAME;
  String phoneNUMBER;
  List<String> arpinCODE;
  List<String> doorNAME;
  List<String> receiverNAME;
  List<String> receiverPHONE;
  String receiverUnitIdBlockID;
  String deliveyDate;
  String deliveryTimeFROM;
  String deliveryTimeTO;
  String imagePath;
  String notes;
  List<AdditionalServiceData> selectedParcelservice;
  String totalWeights;

  BookingDetailsScreen({
    super.key,
    required this.additionalservicetotalAmount,
    required this.pickupADDRESS,
    required this.pickpLATITUDE,
    required this.pickupLOGITUDE,
    required this.droppingLATITUDE,
    required this.droppingLOGITUDE,
    required this.droppingADDRESS,
    required this.bookingDATE,
    required this.deliveryTYPE,
    required this.deliveryTypeID,
    required this.distance,
    required this.parcelLengtH,
    required this.parcelWidth,
    required this.parcelHeight,
    required this.parcelKg,
    required this.parcelQty,
    required this.parcelITEMS,
    required this.unitIdBlockID,
    required this.pickTimeFROM,
    required this.pickTimeTO,
    required this.pickTimeListFROM,
    required this.pickTimeListTO,
    required this.senderNAME,
    required this.phoneNUMBER,
    required this.arpinCODE,
    required this.doorNAME,
    required this.receiverNAME,
    required this.receiverPHONE,
    required this.receiverUnitIdBlockID,
    required this.deliveyDate,
    required this.deliveryTimeFROM,
    required this.deliveryTimeTO,
    required this.imagePath,
    required this.notes,
    required this.selectedParcelservice,
    required this.totalWeights,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  var couponController = TextEditingController();

  ParcelController parcelController = Get.find<ParcelController>();

  final easebuzzController = Get.find<EasebuszzController>();

  List paymentDetails = [
    {
      "name": "Delivery Fees",
      "value": '\$${"10.00"}',
    },
    {"name": "Additional Surcharge", "value": "100"},
    {"name": "Fragil Item", "value": "100"},
    // {"name" :"GST", "value": "100"},
    // "Delivery Fees",

    // "Additional Surcharge",

    // "Fragil Item",
    //"GST"
  ];

  final formKey = GlobalKey<FormState>();

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }

  // Define a function that returns farePrice and perKm as a tuple
  Map<String, double> deliveryCost(String deliveryType) {
    double farePrice = 0.00;
    double perKm = 0.00;

    if (deliveryType == "4 Hours Delivery") {
      farePrice = 9.00;
      perKm = 0.40;
    } else if (deliveryType == "Express Delivery") {
      farePrice = 12.00;
      perKm = 0.50;
    } else if (deliveryType == "Same day delivery") {
      farePrice = 8.00;
      perKm = 0.30;
    } else if (deliveryType == "Specific Time") {
      farePrice = 11.00;
      perKm = 0.40;
    }

    return {'farePrice': farePrice, 'perKm': perKm};
  }

  @override
  Widget build(BuildContext context) {
    final double distance = double.tryParse(widget.distance) ?? 0.0;
    final double serviceAmount =
        double.tryParse(widget.additionalservicetotalAmount) ?? 0.0;
    final cost = deliveryCost(widget.deliveryTYPE);
    final farePrice = cost['farePrice']!;
    final perKm = cost['perKm']!;
    final amountValue = farePrice + (perKm * distance);
    final allTotalAmount = serviceAmount + farePrice + (perKm * distance);
    print("------3456---------");
    print(serviceAmount);
    print(distance);
    print(farePrice + (perKm * distance));
    print(amountValue.toStringAsFixed(2));
    print(allTotalAmount.toStringAsFixed(2));
    final size = MediaQuery.of(context).size;
    List<int> additionalServiceParcelIds =
        widget.selectedParcelservice.map((service) => service.id).toList();
    //  int deliveryTypeofOrder = int.parse(widget.deliveryTYPE);
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
                                    // boxShadow: const <BoxShadow>[
                                    //   BoxShadow(
                                    //       offset: Offset(0.0, 0.75),
                                    //       blurRadius: 3,
                                    //       color: AppColors.kgrey)
                                    // ],
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
                                                fontSize: 19.sp),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      ksizedbox5,
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Pickup details:',
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff000000),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.bookingDATE,
                                            style: primaryfont.copyWith(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${widget.pickTimeFROM} to ${widget.pickTimeTO}",
                                            style: primaryfont.copyWith(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     RichText(
                                      //       text: TextSpan(
                                      //         text: 'Date: ',
                                      //         style: primaryfont.copyWith(
                                      //             color: Colors.black,
                                      //             fontSize: 16.sp,
                                      //             fontWeight: FontWeight.bold),
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //             text: widget.bookingDATE,
                                      //             // '${formatDate(DateTime.parse(widget.bookingdatalist.bookingDate.toString()), [
                                      //             //   dd,
                                      //             //   '-',
                                      //             //   mm,
                                      //             //   '-',
                                      //             //   yyyy
                                      //             // ])}',
                                      //             style: primaryfont.copyWith(
                                      //                 color: Colors.black,
                                      //                 fontSize: 15.sp,
                                      //                 fontWeight:
                                      //                     FontWeight.w500),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     RichText(
                                      //       text: TextSpan(
                                      //         text: 'Time: ',
                                      //         style: primaryfont.copyWith(
                                      //             color: Colors.black,
                                      //             fontSize: 16.sp,
                                      //             fontWeight: FontWeight.bold),
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //             text:
                                      //                 "${widget.pickTimeFROM} to ${widget.pickTimeTO}",
                                      //             // '${widget.bookingdatalist.bookingProducts.first.pickuptimeFrom} to ${widget.bookingdatalist.bookingProducts.first.pickuptimeTo}',
                                      //             style: primaryfont.copyWith(
                                      //                 color: Colors.black,
                                      //                 fontSize: 15.sp,
                                      //                 fontWeight:
                                      //                     FontWeight.w500),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      ksizedbox5,
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          width: size.width,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Address: ',
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: widget.pickupADDRESS,
                                                  //  '${widget.bookingdatalist.pickupAddreess}',
                                                  style: primaryfont.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ksizedbox5,
                                      RichText(
                                        text: TextSpan(
                                          text: 'Name : ',
                                          style: primaryfont.copyWith(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: widget.senderNAME,
                                              //  '${widget.bookingdatalist.bookingDeliveryAddresses.first.customerName}',
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox5,
                                      RichText(
                                        text: TextSpan(
                                          text: 'Phone: ',
                                          style: primaryfont.copyWith(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: widget.phoneNUMBER,
                                              //  '${widget.bookingdatalist.bookingDeliveryAddresses.first.customerMobile}',
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox10,
                                      Divider(),
                                      ksizedbox10,
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Delivery details:',
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff000000),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox5,
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     RichText(
                                      //       text: TextSpan(
                                      //         text: 'Date: ',
                                      //         style: primaryfont.copyWith(
                                      //             color: Colors.black,
                                      //             fontSize: 16.sp,
                                      //             fontWeight: FontWeight.bold),
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //             text: widget.deliveyDate,
                                      //             // widget
                                      //             //     .bookingdatalist
                                      //             //     .bookingProducts
                                      //             //     .first
                                      //             //     .deliveryDate
                                      //             //     .toString(),
                                      //             style: primaryfont.copyWith(
                                      //                 color: Colors.black,
                                      //                 fontSize: 15.sp,
                                      //                 fontWeight:
                                      //                     FontWeight.w500),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     RichText(
                                      //       text: TextSpan(
                                      //         text: 'Time: ',
                                      //         style: primaryfont.copyWith(
                                      //             color: Colors.black,
                                      //             fontSize: 16.sp,
                                      //             fontWeight: FontWeight.bold),
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //             text:
                                      //                 "${widget.deliveryTimeFROM} to ${widget.deliveryTimeTO}",
                                      //             //   "${widget.bookingdatalist.bookingProducts.first.deliverytimeFrom} to ${widget.bookingdatalist.bookingProducts.first.deliverytimeTo}",
                                      //             style: primaryfont.copyWith(
                                      //                 color: Colors.black,
                                      //                 fontSize: 15.sp,
                                      //                 fontWeight:
                                      //                     FontWeight.w500),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.deliveyDate,
                                            style: primaryfont.copyWith(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${widget.deliveryTimeFROM} to ${widget.deliveryTimeTO}",
                                            style: primaryfont.copyWith(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      ksizedbox5,
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          width: size.width,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Address: ',
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: widget.droppingADDRESS
                                                      .join(", \n"),
                                                  //   '${widget.bookingdatalist.bookingDeliveryAddresses.first.address}',
                                                  style: primaryfont.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ksizedbox5,
                                      RichText(
                                        text: TextSpan(
                                          text: 'Name : ',
                                          style: primaryfont.copyWith(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: widget.receiverNAME
                                                  .join(", "),
                                              // '${widget.bookingdatalist.bookingDeliveryAddresses.first.reciverName}',
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox5,
                                      RichText(
                                        text: TextSpan(
                                          text: 'Phone: ',
                                          style: primaryfont.copyWith(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: widget.receiverPHONE
                                                  .join(", "),
                                              // '${widget.bookingdatalist.bookingDeliveryAddresses.first.reciverMobile}',
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox10,
                                      Divider(),
                                      ksizedbox10,

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Delivery Type :',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                'Parcel Item :',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                'Parcel Weight:',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                'Parcel Quantity:',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.deliveryTYPE,
                                                // widget.bookingdatalist
                                                //     .deliveryTypeName,
                                                //   textAlign: TextAlign.right,
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64)),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                widget.parcelITEMS,
                                                //  textAlign: TextAlign.left,
                                                //   "${widget.bookingdatalist.bookingProducts.first.parcelItems}",
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64)),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                "${widget.totalWeights} kg",
                                                //   textAlign: TextAlign.left,
                                                //  "${widget.parcelKg.map((e) => e.replaceAll(RegExp(r'\[|\]'), '').trim()).join(' ')} kg",
                                                // "${widget.bookingdatalist.bookingProducts.first.kg} Kg",
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64)),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                "${widget.parcelQty.map((e) => e.replaceAll(RegExp(r'\[|\]'), '').trim()).join(' ')} kg",
                                                textAlign: TextAlign.left,
                                                // "${widget.bookingdatalist.bookingProducts.first.qty} Qty",
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),

                                      ksizedbox15,
                                      Divider(),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Additional Services :',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 150,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              // itemCount: 2,
                                              itemCount: widget
                                                  .selectedParcelservice.length,
                                              itemBuilder: (context, index) {
                                                AdditionalServiceData
                                                    additionalparcelServiceData =
                                                    widget.selectedParcelservice[
                                                        index];
                                                return Text(
                                                  additionalparcelServiceData
                                                      .name,
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff455A64)),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      ksizedbox5,
                                      Divider(),
                                      ksizedbox10,
                                    ],
                                  ),
                                ),
                              ),
                              ksizedbox20,
                              Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.kwhite,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Driver Notes',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp),
                                      ),
                                      ksizedbox10,
                                      Text(
                                        widget.notes,
                                        // widget.bookingdatalist.notes,
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            color: Color(0xff1E1E1E),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      ksizedbox10,
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
                                    // boxShadow: const <BoxShadow>[
                                    //   BoxShadow(
                                    //       offset: Offset(0.0, 0.75),
                                    //       blurRadius: 2,
                                    //       color: AppColors.kgrey)
                                    // ],
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
                                    // boxShadow: const <BoxShadow>[
                                    //   BoxShadow(
                                    //       offset: Offset(0.0, 0.75),
                                    //       blurRadius: 2,
                                    //       color: AppColors.kgrey)
                                    // ],
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
                                      // ListView.builder(
                                      //     shrinkWrap: true,
                                      //     itemCount: widget
                                      //         .selectedParcelservice.length,
                                      //     itemBuilder: (context, index) {
                                      //       AdditionalServiceData
                                      //           additionalparcelServiceData1 =
                                      //           widget.selectedParcelservice[
                                      //               index];
                                      //       return Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment
                                      //                 .spaceBetween,
                                      //         children: [
                                      //           Column(
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               Text(
                                      //                 additionalparcelServiceData1
                                      //                     .name,
                                      //                 // "fhawbdkvbjkasbvj",
                                      //                 style:
                                      //                     primaryfont.copyWith(
                                      //                         fontSize: 15.sp,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .w600,
                                      //                         color: Color(
                                      //                             0xff455A64)),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //           Column(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment.start,
                                      //             children: [
                                      //               Container(
                                      //                 color: Colors.amber,
                                      //                 width: 90,
                                      //                 alignment:
                                      //                     Alignment.centerLeft,
                                      //                 child: Text(
                                      //                   '\$${additionalparcelServiceData1.amount}',
                                      //                   textAlign:
                                      //                       TextAlign.left,
                                      //                   style: primaryfont
                                      //                       .copyWith(
                                      //                           fontSize: 15,
                                      //                           fontWeight:
                                      //                               FontWeight
                                      //                                   .w600,
                                      //                           color: Color(
                                      //                               0xff455A64)),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           )
                                      //         ],
                                      //       );
                                      //     }),
                                      // ksizedbox20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Delivery Fees",
                                            // widget
                                            //     .bookingdatalist
                                            //     .additionalServices[index]
                                            //     .name,
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Text(
                                            // additionalparcelServiceData1
                                            //     .amount,

                                            '+\$${amountValue.toStringAsFixed(2)}',

                                            style: primaryfont.copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox5,
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: widget
                                              .selectedParcelservice.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            AdditionalServiceData
                                                additionalparcelServiceData1 =
                                                widget.selectedParcelservice[
                                                    index];
                                            return Row(
                                              children: [
                                                Container(
                                                  width: 293,
                                                  child: Text(
                                                    additionalparcelServiceData1
                                                        .name,
                                                    textAlign: TextAlign.left,
                                                    // widget
                                                    //     .bookingdatalist
                                                    //     .additionalServices[index]
                                                    //     .name,
                                                    style: primaryfont.copyWith(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff455A64)),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    // additionalparcelServiceData1
                                                    //     .amount,
                                                    '+\$${additionalparcelServiceData1.amount}',
                                                    textAlign: TextAlign.left,
                                                    style: primaryfont.copyWith(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff455A64)),
                                                  ),
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
                                            "\$${allTotalAmount.toStringAsFixed(2)}",
                                            // totalAmount.toStringAsFixed(2),
                                            //  '\$${widget.totalAmount}',\

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

                          Obx(() {
                            return parcelController.addBookingLoading.isTrue
                                ? Container(
                                    height: 50.h,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        //  color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.kblue,
                                    )),
                                  )
                                : InkWell(
                                    onTap: () {
                                      List<Product> products = [
                                        Product(
                                            parcelItems: widget.parcelITEMS,
                                            length: widget.parcelLengtH,
                                            width: widget.parcelHeight,
                                            height: widget.parcelHeight,
                                            qty: widget.parcelQty,
                                            kg: widget.parcelKg,
                                            pickupTimeFrom:
                                                widget.pickTimeFROM!,
                                            pickupTimeTo: widget.pickTimeTO!,
                                            deliveryDate: widget.deliveyDate,
                                            deliveryTimeFrom:
                                                widget.deliveryTimeFROM,
                                            deliveryTimeTo:
                                                widget.deliveryTimeTO)
                                      ];

                                      List<BookingAddress> bookingAddress = [
                                        BookingAddress(
                                            customerName: widget.senderNAME,
                                            customerMobile: widget.phoneNUMBER,
                                            unitNoBlockNo: widget.unitIdBlockID,
                                            address: widget.droppingADDRESS,
                                            postalCode: widget.arpinCODE,
                                            latitude: widget.droppingLATITUDE,
                                            longitude: widget.droppingLOGITUDE,
                                            deliveryStatus: "0",
                                            deliveryTimeFrom:
                                                widget.deliveryTimeFROM,
                                            deliveryTimeTo:
                                                widget.deliveryTimeTO,
                                            reciverName: widget.receiverNAME,
                                            reciverMobile: widget.receiverPHONE,
                                            reciverUnitIdBlockId:
                                                widget.receiverUnitIdBlockID),
                                      ];
                                      AddBookingParcelModel
                                          addBookingParcelModel =
                                          AddBookingParcelModel(
                                              totalAmountCost: allTotalAmount
                                                  .toStringAsFixed(2),
                                              pickupAddress:
                                                  widget.pickupADDRESS,
                                              deliveryTypeid: widget
                                                  .deliveryTypeID
                                                  .toString(),
                                              paymentMode: "500",
                                              bookingAmount: "500",
                                              gst: "500",
                                              additionalTotal: serviceAmount
                                                  .toStringAsFixed(2),
                                              totalAmount: allTotalAmount
                                                  .toStringAsFixed(2),
                                              isRoundTrip: '1',
                                              bookingDate: widget.bookingDATE,
                                              pickupTimeFrom:
                                                  widget.pickTimeFROM!,
                                              pickupTimeTo: widget.pickTimeTO!,
                                              deliveryDate: widget.deliveyDate,
                                              deliveryTimeFrom:
                                                  widget.deliveryTimeFROM,
                                              deliveryTimeTo:
                                                  widget.deliveryTimeTO,
                                              latitude: widget.pickpLATITUDE,
                                              longitude: widget.pickupLOGITUDE,
                                              distance: widget.distance,
                                              bookingType: "parcel",
                                              additionalDetails:
                                                  additionalServiceParcelIds,
                                              notes: widget.notes,
                                              products: products,
                                              bookingAddress: bookingAddress,
                                              parcelPhoto: widget.imagePath);
                                      parcelController.addBookingParcel(
                                          addBookingParcelModel);
                                      // if (formatDateTime.isNotEmpty) {

                                      // }
                                    },
                                    child: CommonContainer(
                                      name: "Confirm Payment",
                                    ));
                          }),
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
