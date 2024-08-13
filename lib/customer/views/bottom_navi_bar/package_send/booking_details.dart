import 'dart:convert';
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
import 'package:v_export/customer/model/delivery_type_model.dart';
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
  String senderunitIdBlockID;
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
  List<String> receiverUnitIdBlockID;
  String deliveyDate;
  String deliveryTimeFROM;
  String deliveryTimeTO;
  String imagePath;
  String notes;
  List<AdditionalServiceData> selectedParcelservice;
  String totalWeights;
  List<DeliveryTypeData> selectedDeliveryTypes = [];
  String roundtrip;
  String parcelofKg;
  String parcelofQty;
  BookingDetailsScreen(
      {super.key,
      required this.parcelofKg,
      required this.parcelofQty,
      required this.roundtrip,
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
      required this.senderunitIdBlockID,
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
      required this.selectedDeliveryTypes});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateAmount();
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
  ];
  double amount = 0.0;
  double additionalServiceAmount = 0.0;
  double totalParcelAmount = 0.0;
  double totalDistance = 0.0;
  String jsonString = "";
  double distanceCost = 0.0;
  // double feesamounts = 0.0;
  List<BookingAddress> bookingAddress = [];
  void calculateAmount() {
    totalDistance = double.tryParse(widget.distance) ?? 0.0;
    additionalServiceAmount =
        double.tryParse(widget.additionalservicetotalAmount) ?? 0.0;
    for (var deliveryType in widget.selectedDeliveryTypes) {
      double basePerKm = double.tryParse(deliveryType.basePerkm) ?? 0.0;
      distanceCost = totalDistance * basePerKm;

      if (deliveryType.name == '4 Hours Delivery' ||
          deliveryType.name == 'Express Delivery' ||
          deliveryType.name == 'Same day delivery' ||
          deliveryType.name == 'Next day delivery' ||
          deliveryType.name == 'Specific Time') {
        for (int i = 0; i < widget.parcelKg.length; i++) {
          double kg = double.tryParse(widget.parcelKg[i]) ?? 0.0;
          int qty = int.tryParse(widget.parcelQty[i]) ?? 0;

          double price = 0.0;
          if (kg <= 5) {
            price = double.tryParse(deliveryType.price05Kg) ?? 0.0;
          } else if (kg <= 10) {
            price = double.tryParse(deliveryType.price510Kg) ?? 0.0;
          } else if (kg <= 15) {
            price = double.tryParse(deliveryType.price1015Kg) ?? 0.0;
          } else if (kg <= 20) {
            price = double.tryParse(deliveryType.price1520Kg) ?? 0.0;
          } else if (kg <= 25) {
            price = double.tryParse(deliveryType.price2025Kg) ?? 0.0;
          } else {
            price = double.tryParse(deliveryType.priceAbove25Kg) ?? 0.0;
          }

          double discountedPrice = price;
          if (qty >= 2) {
            discountedPrice *= 0.6; // Apply 40% discount
          }

          // amount += (discountedPrice * qty) + distanceCost;
          double parcelAmount = discountedPrice * qty;
          // totalParcelAmount = totalParcelAmount
          totalParcelAmount += parcelAmount;
          // double feesamounts = parcelAmount + distanceCost;
          amount += totalParcelAmount + distanceCost;
        }
      }
    }

    amount += additionalServiceAmount;
    // Create a Map to encode as JSON
    Map<String, dynamic> data = {
      'totalDistance': totalDistance.toStringAsFixed(2),
      'totalparcelAmounts': totalParcelAmount.toStringAsFixed(2),
      'additionalServiceAmount': additionalServiceAmount,
      'totalamount': amount.toStringAsFixed(2)
    };

    jsonString = jsonEncode(data);
    print("JSON Data: $jsonString");
    setState(() {});
    print("amount =${amount.toStringAsFixed(2)}");
    print("feesamount---");
    print("----------kg");
  }

  final formKey = GlobalKey<FormState>();

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }

  // Define a function that returns farePrice and perKm as a tuple
  // Map<String, double> deliveryCost(List<DeliveryTypeData> deliveryType,
  //     List<String> parcelQty, List<String> parcelKg, String distanse) {
  //   double farePrice = 0.0;
  //   double perKm = 0.0;
  //   double distance = double.parse(distanse);

  //   // Determine farePrice and perKm based on deliveryType
  //   if (deliveryType.first.name == "4 Hours Delivery") {
  //     farePrice = 9.00;
  //     perKm = 0.40;
  //   } else if (deliveryType.first.name == "Express Delivery") {
  //     farePrice = 12.00;
  //     perKm = 0.50;
  //   } else if (deliveryType.first.name == "Same day delivery") {
  //     farePrice = 8.00;
  //     perKm = 0.30;
  //   } else if (deliveryType.first.name == "Specific Time") {
  //     farePrice = 11.00;
  //     perKm = 0.40;
  //   }

  //   // Calculate the distance price
  //   double distancePrice = perKm * distance;

  //   // Calculate the total parcelKg price with possible discounts
  //   double totalParcelKgPrice = 0.0;
  //   for (int i = 0; i < parcelKg.length; i++) {
  //     double kg = double.parse(parcelKg[i]);
  //     double pricePerKg = 2.0; // Default price per kg

  //     // Apply discount if parcelKg is greater than the threshold
  //     if (kg > 10.0) {
  //       pricePerKg *= 0.60; // Apply 40% discount
  //     }
  //     print(kg);
  //     totalParcelKgPrice += pricePerKg * kg;
  //     print("----------------kg");
  //     print(kg);
  //       print("kg----- $kg");
  //   }

  // Calculate the total cost
  //   double totalCost = distancePrice + totalParcelKgPrice;

  //   return {
  //     'farePrice': farePrice,
  //     'perKm': perKm,
  //     'distancePrice': distancePrice,
  //     'totalParcelKgPrice': totalParcelKgPrice,
  //     'totalCost': totalCost,
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    // final double distance = double.tryParse(widget.distance) ?? 0.0;
    // final double serviceAmount =
    //     double.tryParse(widget.additionalservicetotalAmount) ?? 0.0;
    // final cost = deliveryCost(widget.selectedDeliveryTypes, widget.parcelQty,
    //     widget.parcelKg, widget.distance);
    // final farePrice = cost['farePrice']!;
    // final perKm = cost['perKm']!;
    // final amountValue = farePrice + (perKm * distance);
    // final allTotalAmount = serviceAmount + farePrice + (perKm * distance);
    // print("------3456---------");
    // print(serviceAmount);
    // print(distance);
    // print(farePrice + (perKm * distance));
    // print(amountValue.toStringAsFixed(2));
    // print(allTotalAmount.toStringAsFixed(2));
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Pickup Details:',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            widget.bookingDATE,
                                            style: primaryfont.copyWith(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${widget.pickTimeFROM} - ${widget.pickTimeTO}",
                                            style: primaryfont.copyWith(
                                                color: Colors.black,
                                                fontSize: 12.sp,
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
                                              text: 'Address           : ',
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
                                          text: 'Name               : ',
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
                                          text: 'Phone              : ',
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Delivery Details:',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            widget.deliveyDate,
                                            style: primaryfont.copyWith(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${widget.deliveryTimeFROM} - ${widget.deliveryTimeTO}",
                                            style: primaryfont.copyWith(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ], 
                                      ),
                           
                                      
                                      ksizedbox5,
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          width: size.width,
                                          child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  widget.droppingADDRESS.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text:
                                                          'Address:- ${index + 1}        : ',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget
                                                                  .droppingADDRESS[
                                                              index],
                                                          //   '${widget.bookingdatalist.bookingDeliveryAddresses.first.address}',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                          // child: RichText(
                                          //   text: TextSpan(
                                          //     text: 'Address: ',
                                          //     style: primaryfont.copyWith(
                                          //         color: Colors.black,
                                          //         fontSize: 16.sp,
                                          //         fontWeight: FontWeight.bold),
                                          //     children: <TextSpan>[
                                          //       TextSpan(
                                          //         text: widget.droppingADDRESS
                                          //             .join(", \n"),
                                          //         //   '${widget.bookingdatalist.bookingDeliveryAddresses.first.address}',
                                          //         style: primaryfont.copyWith(
                                          //             color: Colors.black,
                                          //             fontSize: 15.sp,
                                          //             fontWeight:
                                          //                 FontWeight.w500),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                      ksizedbox5,
                                      RichText(
                                        text: TextSpan(
                                          text: 'Name                   : ',
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
                                          text: 'Phone                  : ',
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
                                                'Delivery Type',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                'Parcel Item',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                'Parcel Weight',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                'Parcel Quantity',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                'Round Trip',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   width: 0,
                                          // ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ":",
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                ksizedbox5,
                                                Text(
                                                  ":",
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                ksizedbox5,
                                                Text(
                                                  ":",
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                ksizedbox5,
                                                Text(
                                                  ":",
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                ksizedbox5,
                                                Text(
                                                  ":",
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ]),
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
                                                "${widget.parcelofKg} kg",
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64)),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                "${widget.parcelofQty} Qty",
                                                textAlign: TextAlign.left,
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64)),
                                              ),
                                              ksizedbox5,
                                              Text(
                                                widget.roundtrip == "1"
                                                    ? "Yes"
                                                    : "No",
                                                textAlign: TextAlign.left,
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
                                                'Additional Services  :',
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
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       "Delivery Fees",
                                      //       style: primaryfont.copyWith(
                                      //           fontSize: 15.sp,
                                      //           fontWeight: FontWeight.w600,
                                      //           color: Color(0xff455A64)),
                                      //     ),
                                      //     Text(
                                      //       '\$${distanceCost.toStringAsFixed(2)}',
                                      //       style: primaryfont.copyWith(
                                      //           fontSize: 14,
                                      //           fontWeight: FontWeight.w600,
                                      //           color: Color(0xff455A64)),
                                      //     )
                                      //   ],
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Parcel Amount",
                                            // widget
                                            //     .bookingdatalist
                                            //     .additionalServices[index]
                                            //     .name,
                                            style: primaryfont.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          //    Text("\$"),
                                          Text(
                                            // additionalparcelServiceData1
                                            //     .amount,

                                            '\$${totalParcelAmount.toStringAsFixed(2)}',

                                            style: primaryfont.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
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
                                            "Delivery Fees",
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Text(
                                            '\$${distanceCost.toStringAsFixed(2)}',
                                            style: primaryfont.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          // itemCount: 2,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  additionalparcelServiceData1
                                                      .name,
                                                  textAlign: TextAlign.left,
                                                  // widget
                                                  //     .bookingdatalist
                                                  //     .additionalServices[index]
                                                  //     .name,
                                                  style: primaryfont.copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff455A64)),
                                                ),
                                                Text(
                                                  // additionalparcelServiceData1
                                                  //     .amount,
                                                  '\$${additionalparcelServiceData1.amount}',
                                                  textAlign: TextAlign.left,
                                                  style: primaryfont.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff455A64)),
                                                ),
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
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "\$${amount.toStringAsFixed(2)}",
                                            // totalAmount.toStringAsFixed(2),
                                            //  '\$${widget.totalAmount}',\

                                            style: primaryfont.copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
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
                            List<String> droppingAddresses =
                                widget.droppingADDRESS;
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
                                      List<Product> products = [];

                                      debugLists();
                                      for (int index = 0;
                                          index < widget.parcelLengtH.length;
                                          index++) {
                                        products.add(Product(
                                          parcelItems: widget.parcelITEMS,
                                          length: widget.parcelLengtH[index],
                                          width: widget.parcelWidth[index],
                                          height: widget.parcelHeight[index],
                                          qty: widget.parcelQty[index],
                                          kg: widget.parcelKg[index],
                                          pickupTimeFrom: widget.pickTimeFROM!,
                                          pickupTimeTo: widget.pickTimeTO!,
                                          deliveryDate: widget.deliveyDate,
                                          deliveryTimeFrom:
                                              widget.deliveryTimeFROM,
                                          deliveryTimeTo: widget.deliveryTimeTO,
                                        ));
                                      }
                                      print(products);
                                      // List<Product> products = List.generate(
                                      //     widget.parcelLengtH.length, (index) {
                                      //   return Product(
                                      //     parcelItems: widget.parcelITEMS,
                                      //     length: widget.parcelLengtH[index],
                                      //     width: widget.parcelWidth[index],
                                      //     height: widget.parcelHeight[index],
                                      //     qty: widget.parcelQty[index],
                                      //     kg: widget.parcelKg[index],
                                      //     pickupTimeFrom: widget.pickTimeFROM!,
                                      //     pickupTimeTo: widget.pickTimeTO!,
                                      //     deliveryDate: widget.deliveyDate,
                                      //     deliveryTimeFrom:
                                      //         widget.deliveryTimeFROM,
                                      //     deliveryTimeTo: widget.deliveryTimeTO,
                                      //   );
                                      // });
                                      // List<Product> products = [
                                      //   Product(
                                      //       parcelItems: widget.parcelITEMS,
                                      //       length: widget.parcelLengtH,
                                      //       width: widget.parcelHeight,
                                      //       height: widget.parcelHeight,
                                      //       qty: widget.parcelQty,
                                      //       kg: widget.parcelKg,
                                      //       pickupTimeFrom:
                                      //           widget.pickTimeFROM!,
                                      //       pickupTimeTo: widget.pickTimeTO!,
                                      //       deliveryDate: widget.deliveyDate,
                                      //       deliveryTimeFrom:
                                      //           widget.deliveryTimeFROM,
                                      //       deliveryTimeTo:
                                      //           widget.deliveryTimeTO)
                                      // ];

                                      String diliverystatus = "0";
                                      List<BookingAddress> bookingAddress = [];

                                      for (int index = 0;
                                          index < widget.droppingADDRESS.length;
                                          index++) {
                                        bookingAddress.add(BookingAddress(
                                          customerName: widget.senderNAME,
                                          customerMobile: widget.phoneNUMBER,
                                          unitNoBlockNo:
                                              widget.senderunitIdBlockID,
                                          address:
                                              widget.droppingADDRESS[index],
                                          postalCode: widget.arpinCODE[index],
                                          latitude:
                                              widget.droppingLATITUDE[index],
                                          longitude:
                                              widget.droppingLOGITUDE[index],
                                          deliveryStatus: diliverystatus,
                                          deliveryTimeFrom:
                                              widget.deliveryTimeFROM,
                                          deliveryTimeTo: widget.deliveryTimeTO,
                                          reciverName:
                                              widget.receiverNAME[index],
                                          reciverMobile:
                                              widget.receiverPHONE[index],
                                          reciverUnitIdBlockId: widget
                                              .receiverUnitIdBlockID[index],
                                        ));
                                      }
                                      print(bookingAddress);
                                      // String diliverystatus = "0";
                                      // List<BookingAddress> bookingAddress =
                                      //     List.generate(
                                      //   widget.droppingADDRESS.length,
                                      //   (index) => BookingAddress(
                                      //     customerName:
                                      //         widget.senderNAME[index],
                                      //     customerMobile:
                                      //         widget.phoneNUMBER[index],
                                      //     unitNoBlockNo:
                                      //         widget.unitIdBlockID[index],
                                      //     address:
                                      //         widget.droppingADDRESS[index],
                                      //     postalCode: widget.arpinCODE[index],
                                      //     latitude:
                                      //         widget.droppingLATITUDE[index],
                                      //     longitude:
                                      //         widget.droppingLOGITUDE[index],
                                      //     deliveryStatus: diliverystatus[index],
                                      //     deliveryTimeFrom:
                                      //         widget.deliveryTimeFROM[index],
                                      //     deliveryTimeTo:
                                      //         widget.deliveryTimeTO[index],
                                      //     reciverName:
                                      //         widget.receiverNAME[index],
                                      //     reciverMobile:
                                      //         widget.receiverPHONE[index],
                                      //     reciverUnitIdBlockId: widget
                                      //         .receiverUnitIdBlockID[index],
                                      //   ),
                                      // );

                                      // List<BookingAddress> bookingAddress = [
                                      //   BookingAddress(
                                      //       customerName: widget.senderNAME,
                                      //       customerMobile: widget.phoneNUMBER,
                                      //       unitNoBlockNo: widget.unitIdBlockID,
                                      //       address: widget.droppingADDRESS,
                                      //       postalCode: widget.arpinCODE,
                                      //       latitude: widget.droppingLATITUDE,
                                      //       longitude: widget.droppingLOGITUDE,
                                      //       deliveryStatus: "0",
                                      //       deliveryTimeFrom:
                                      //           widget.deliveryTimeFROM,
                                      //       deliveryTimeTo:
                                      //           widget.deliveryTimeTO,
                                      //       reciverName: widget.receiverNAME,
                                      //       reciverMobile: widget.receiverPHONE,
                                      //       reciverUnitIdBlockId:
                                      //           widget.receiverUnitIdBlockID),
                                      // ];
                                      AddBookingParcelModel
                                          addBookingParcelModel =
                                          AddBookingParcelModel(
                                              senderUnitId:
                                                  widget.senderunitIdBlockID,
                                              totalAmountCost:
                                                  amount.toStringAsFixed(2),
                                              pickupAddress:
                                                  widget.pickupADDRESS,
                                              deliveryTypeid: widget
                                                  .deliveryTypeID
                                                  .toString(),
                                              paymentMode: "cash",
                                              bookingAmount:
                                                  amount.toStringAsFixed(2),
                                              gst: "0",
                                              additionalTotal:
                                                  additionalServiceAmount
                                                      .toStringAsFixed(2),
                                              totalAmount:
                                                  amount.toStringAsFixed(2),
                                              isRoundTrip: widget.roundtrip,
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
                                              parcelPhoto: widget.imagePath,
                                              //    imagePath == null ? "" : imagePath!,
                                              paymentdetails: jsonString);
                                      // parcelController.addBookingParcel(
                                      //     addBookingParcelModel);
                                      parcelController
                                          .addBookingLoading1.value = true;
                                      try {
                                        parcelController.addBookingParcel(
                                            addBookingParcelModel);
                                        // Navigate to the next screen if the booking is successful
                                      } catch (error) {
                                        // Handle the error here
                                        print('Booking failed: $error');
                                      } finally {
                                        parcelController
                                            .addBookingLoading1.value = false;
                                      }
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

  void debugLists() {
    print('droppingADDRESS length: ${widget.droppingADDRESS.length}');
    print('senderNAME length: ${widget.senderNAME.length}');
    print('phoneNUMBER length: ${widget.phoneNUMBER.length}');
    print('unitIdBlockID length: ${widget.senderunitIdBlockID.length}');
    print('arpinCODE length: ${widget.arpinCODE.length}');
    print('droppingLATITUDE length: ${widget.droppingLATITUDE.length}');
    print('droppingLOGITUDE length: ${widget.droppingLOGITUDE.length}');
    print('deliveryTimeFROM length: ${widget.deliveryTimeFROM.length}');
    print('deliveryTimeTO length: ${widget.deliveryTimeTO.length}');
    print('receiverNAME length: ${widget.receiverNAME.length}');
    print('receiverPHONE length: ${widget.receiverPHONE.length}');
    print(
        'receiverUnitIdBlockID length: ${widget.receiverUnitIdBlockID.length}');
  }
}
