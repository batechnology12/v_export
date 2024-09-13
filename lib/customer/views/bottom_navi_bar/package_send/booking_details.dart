import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/Payment_detalis_data_model.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/booking_review_detalis_model.dart';
import 'package:v_export/customer/model/delivery_type_model.dart';
import 'package:v_export/customer/model/get_vehicle_calculation_model.dart';
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
  String senderunitIdBlockID;
  String unitId;
  int deliveryTypeID;
  List<String> parcelLengtH;
  List<String> parcelWidth;
  List<String> parcelHeight;
  List<String> parcelKg;
  List<String> parcelQty;
  String parcelITEMS;
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
  List<String> receiverunitId;
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

  String pickupPOSTALCODE;
  List<String> dropPOSTALCODE;

  BookingDetailsScreen(
      {super.key,
      required this.pickupPOSTALCODE,
      required this.dropPOSTALCODE,
      required this.unitId,
      required this.receiverunitId,
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
  List<String> combinedArray = [];
  List<String> additinalServiceID = [];
  List<int> additionalServiceParcelIds = [];

  @override
  void initState() {
    super.initState();
    //  redeemecoupon();
  }

  double totalAmountOfParcel = 0;
  double totalAmountParcelOfPercentageorFixed = 0;

  bool amountCheckParcel = false;
  void coupondiscount() {
    if (parcelController.redmeeCouponsData.first.type == "percentage") {
      totalAmountParcelOfPercentageorFixed =
          double.parse(parcelController.paymentdatalist.last.total.value) -
              (double.parse(parcelController.paymentdatalist.last.total.value) *
                  (int.parse(parcelController.redmeeCouponsData.first.value) /
                      100));
    } else if (parcelController.redmeeCouponsData.first.type == "fixed") {
      totalAmountParcelOfPercentageorFixed =
          double.parse(parcelController.paymentdatalist.last.total.value) -
              double.parse(parcelController.redmeeCouponsData.first.value);
    }
    setState(() {
      totalAmountOfParcel = totalAmountParcelOfPercentageorFixed;
      amountCheckParcel = true;
    });
  }

  void applyCoupon() async {
    await parcelController.redeemeCouponsApi(couponParcelController.text);
    coupondiscount();
  }

  List<String> getID() {
    additinalServiceID = widget.selectedParcelservice
        .map((service) => service.id.toString())
        .toList();
    print("service id====");
    print(additinalServiceID);
    return additinalServiceID;
  }

  var couponParcelController = TextEditingController();

  ParcelController parcelController = Get.put(ParcelController());
  final HomeController homeController = Get.put(HomeController());

  final easebuzzController = Get.put(EasebuszzController());

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
  String totalAmount = "";
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
            discountedPrice *= 0.60; // Apply 40% discount
          } else if (qty >= 6) {
            discountedPrice *= 0.40; // 60% discount
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
      'additionalServiceAmount': additionalServiceAmount.toString(),
      'totalamount': amount.toStringAsFixed(2)
    };

    jsonString = jsonEncode(data);
    print("JSON Data: $jsonString");
  }

  final formKey = GlobalKey<FormState>();

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    additionalServiceParcelIds =
        widget.selectedParcelservice.map((service) => service.id).toList();
    combinedArray = [widget.pickupPOSTALCODE, ...widget.dropPOSTALCODE];
    String result = combinedArray.join(',');
    List<String> additionalServiceParcelIdsString =
        additionalServiceParcelIds.map((id) => id.toString()).toList();

    parcelController.getBookingCalculationApi(
        widget.deliveryTypeID.toString(),
        widget.distance,
        widget.roundtrip == "1" ? "yes" : "no",
        widget.parcelKg,
        widget.parcelQty,
        additionalServiceParcelIdsString,
        ["0"],
        result);

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
          child: GetBuilder<ParcelController>(builder: (context) {
            return parcelController.paymentdatalist.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
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
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
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
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 19.sp),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              ksizedbox5,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Pickup Details:',
                                                    style: primaryfont.copyWith(
                                                        color:
                                                            Color(0xff000000),
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    widget.bookingDATE,
                                                    style: primaryfont.copyWith(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "${widget.pickTimeFROM} - ${widget.pickTimeTO}",
                                                    style: primaryfont.copyWith(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              ksizedbox5,
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Container(
                                                  width: size.width,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text:
                                                          'Address           : ',
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
                                                          text:
                                                              "${widget.senderunitIdBlockID}, ${widget.pickupADDRESS}, ${widget.unitId}",
                                                          //  '${widget.bookingdatalist.pickupAddreess}',
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
                                                ),
                                              ),
                                              ksizedbox5,
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Name               : ',
                                                  style: primaryfont.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: widget.senderNAME,
                                                      //  '${widget.bookingdatalist.bookingDeliveryAddresses.first.customerName}',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: widget.phoneNUMBER,
                                                      //  '${widget.bookingdatalist.bookingDeliveryAddresses.first.customerMobile}',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ksizedbox10,
                                              Divider(),
                                              ksizedbox10,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Delivery Details:',
                                                    style: primaryfont.copyWith(
                                                        color:
                                                            Color(0xff000000),
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    widget.deliveyDate,
                                                    style: primaryfont.copyWith(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "${widget.deliveryTimeFROM} - ${widget.deliveryTimeTO}",
                                                    style: primaryfont.copyWith(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              ksizedbox5,
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Container(
                                                  width: size.width,
                                                  child: ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: widget
                                                          .droppingADDRESS
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RichText(
                                                                text: TextSpan(
                                                                  text: homeController
                                                                          .isCheckedparcelLocation
                                                                      ? 'Address:- ${index + 1}        : '
                                                                      : 'Address:-           : ',
                                                                  style: primaryfont.copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                      text:
                                                                          "${widget.receiverUnitIdBlockID[index].split('[').last.split("]").first}, ${widget.droppingADDRESS[index]}, ${widget.receiverunitId[index].split('[').last.split("]").first}",
                                                                      //   '${widget.bookingdatalist.bookingDeliveryAddresses.first.address}',
                                                                      style: primaryfont.copyWith(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              ksizedbox5,
                                                              RichText(
                                                                text: TextSpan(
                                                                  text:
                                                                      'Name                   : ',
                                                                  style: primaryfont.copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                      text: widget
                                                                              .receiverNAME[
                                                                          index],
                                                                      // '${widget.bookingdatalist.bookingDeliveryAddresses.first.reciverName}',
                                                                      style: primaryfont.copyWith(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              ksizedbox5,
                                                              RichText(
                                                                text: TextSpan(
                                                                  text:
                                                                      'Phone                  : ',
                                                                  style: primaryfont.copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                      text: widget
                                                                              .receiverPHONE[
                                                                          index],
                                                                      style: primaryfont.copyWith(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              ksizedbox10,
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ),
                                              Divider(),
                                              ksizedbox10,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Delivery Type',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      ksizedbox5,
                                                      Text(
                                                        'Parcel Item',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      ksizedbox5,
                                                      Text(
                                                        'Parcel Weight',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      ksizedbox5,
                                                      Text(
                                                        'Parcel Quantity',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      ksizedbox5,
                                                      widget.roundtrip == "1"
                                                          ? Text(
                                                              'Round Trip',
                                                              style: primaryfont
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   width: 0,
                                                  // ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          ":",
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        ksizedbox5,
                                                        Text(
                                                          ":",
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        ksizedbox5,
                                                        Text(
                                                          ":",
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        ksizedbox5,
                                                        Text(
                                                          ":",
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        ksizedbox5,
                                                        widget.roundtrip == "1"
                                                            ? Text(
                                                                ":",
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              )
                                                            : Container(),
                                                      ]),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        widget.deliveryTYPE,
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      ksizedbox5,
                                                      Text(
                                                        widget.parcelITEMS,
                                                        //  textAlign: TextAlign.left,
                                                        //   "${widget.bookingdatalist.bookingProducts.first.parcelItems}",
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      ksizedbox5,
                                                      Text(
                                                        "${widget.parcelofKg} kg",
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      ksizedbox5,
                                                      Text(
                                                        "${widget.parcelofQty} Qty",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                      ksizedbox5,
                                                      widget.roundtrip == "1"
                                                          ? Text(
                                                              "Yes",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: const Color(
                                                                      0xff455A64)),
                                                            )
                                                          : Container()
                                                    ],
                                                  )
                                                ],
                                              ),
                                              ksizedbox15,
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Additional Services  :',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ],
                                                  ),
                                                  widget.selectedParcelservice
                                                          .isEmpty
                                                      ? Container(
                                                          width: 140,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          child: Text(
                                                            "No",
                                                            style: primaryfont.copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: const Color(
                                                                    0xff455A64)),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 150,
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            // itemCount: 2,
                                                            itemCount: widget
                                                                .selectedParcelservice
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              AdditionalServiceData
                                                                  additionalparcelServiceData =
                                                                  widget.selectedParcelservice[
                                                                      index];
                                                              return Text(
                                                                additionalparcelServiceData
                                                                    .name,
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Color(
                                                                        0xff455A64)),
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
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, right: 10, left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              widget.imagePath.isEmpty
                                                  ? Container()
                                                  : Text(
                                                      'Parcel Picture',
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp),
                                                    ),
                                              widget.imagePath.isEmpty
                                                  ? Container()
                                                  : ksizedbox10,
                                              widget.imagePath.isEmpty
                                                  ? Container()
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        height: 120.h,
                                                        width: 120.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Image.file(
                                                          File(
                                                              widget.imagePath),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                              ksizedbox10,
                                              Text(
                                                'Driver Notes',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp),
                                              ),
                                              ksizedbox10,
                                              Text(
                                                widget.notes,
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    color: Color(0xff1E1E1E),
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  height: 50.h,
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextField(
                                                    controller:
                                                        couponParcelController,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () {
                                                            // setState(() {
                                                            applyCoupon();
                                                            amountCheckParcel =
                                                                true;
                                                            print(
                                                                "totalcostofvehicle------ ${parcelController.getvehicleCalculationDatas.last.totalCost.value}");
                                                            print(
                                                                "totalamountofvehicle------ ${totalAmountOfParcel.toStringAsFixed(2)}");
                                                            // });
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            height: 40.h,
                                                            width: 80.w,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .kblue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            child: Center(
                                                              child: Text(
                                                                'Apply',
                                                                style: primaryfont.copyWith(
                                                                    color: AppColors
                                                                        .kwhite,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                                  ),
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
                                            borderRadius:
                                                BorderRadius.circular(17)),
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
                                                        color:
                                                            Color(0xff1E1E1E),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              ksizedbox5,
                                              Divider(),
                                              ksizedbox5,
                                              ksizedbox5,
                                              GetBuilder<ParcelController>(
                                                  builder: (context) {
                                                return parcelController
                                                        .paymentdatalist.isEmpty
                                                    ? Container()
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        // itemCount: 2,
                                                        itemCount:
                                                            parcelController
                                                                .paymentdatalist
                                                                .length,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) {
                                                          PaymentDetailsData
                                                              paymentDetailsDataList =
                                                              parcelController
                                                                      .paymentdatalist[
                                                                  index];

                                                          totalAmount =
                                                              paymentDetailsDataList
                                                                  .total.value;
                                                          List<
                                                                  Map<String,
                                                                      dynamic>>
                                                              additionalServicesList =
                                                              parcelController
                                                                  .paymentdatalist
                                                                  .first
                                                                  .additionalServices
                                                                  .map(
                                                                      (service) {
                                                            return {
                                                              'name':
                                                                  service.name,
                                                              'value':
                                                                  service.value,
                                                            };
                                                          }).toList();
                                                          Map<String, dynamic>
                                                              data = {
                                                            "deliveryfees":
                                                                paymentDetailsDataList
                                                                    .deliveryFees
                                                                    .value,
                                                            "roundtripCost":
                                                                paymentDetailsDataList
                                                                    .roundTripCost
                                                                    .value,
                                                            "addtionalstopCount":
                                                                "0.00",
                                                            "driverHelpcost":
                                                                "0.00",
                                                            "helperCost":
                                                                "0.00",
                                                            "weekendCost":
                                                                "0.00",
                                                            'additional_services':
                                                                additionalServicesList,
                                                            "total": amountCheckParcel ==
                                                                    true
                                                                ? totalAmountOfParcel
                                                                    .toStringAsFixed(
                                                                        2)
                                                                : paymentDetailsDataList
                                                                    .total
                                                                    .value,
                                                            "discount": amountCheckParcel ==
                                                                    true
                                                                ? parcelController
                                                                            .redmeeCouponsData
                                                                            .first
                                                                            .type ==
                                                                        "percentage"
                                                                    ? "${parcelController.redmeeCouponsData.first.value}%"
                                                                    : "\$${parcelController.redmeeCouponsData.first.value}"
                                                                : "0.00",
                                                          };
                                                          jsonString =
                                                              jsonEncode(data);
                                                          print(
                                                              "JSON Data: $jsonString");
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    paymentDetailsDataList
                                                                        .deliveryFees
                                                                        .name,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: primaryfont.copyWith(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            0xff455A64)),
                                                                  ),
                                                                  paymentDetailsDataList
                                                                              .roundTripCost
                                                                              .value ==
                                                                          "0.00"
                                                                      ? Container()
                                                                      : Text(
                                                                          paymentDetailsDataList
                                                                              .roundTripCost
                                                                              .name,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                  paymentDetailsDataList
                                                                              .accessRestrictedArea
                                                                              .value ==
                                                                          "0.00"
                                                                      ? Container()
                                                                      : Text(
                                                                          paymentDetailsDataList
                                                                              .accessRestrictedArea
                                                                              .name,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                  paymentDetailsDataList
                                                                              .cbdArea
                                                                              .value ==
                                                                          "0.00"
                                                                      ? Container()
                                                                      : Text(
                                                                          paymentDetailsDataList
                                                                              .cbdArea
                                                                              .name,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    '\$${paymentDetailsDataList.deliveryFees.value}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: primaryfont.copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            0xff455A64)),
                                                                  ),
                                                                  paymentDetailsDataList
                                                                              .roundTripCost
                                                                              .value ==
                                                                          "0.00"
                                                                      ? Container()
                                                                      : Text(
                                                                          '\$${paymentDetailsDataList.roundTripCost.value}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                  paymentDetailsDataList
                                                                              .accessRestrictedArea
                                                                              .value ==
                                                                          "0.00"
                                                                      ? Container()
                                                                      : Text(
                                                                          '\$${paymentDetailsDataList.accessRestrictedArea.value}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                  paymentDetailsDataList
                                                                              .cbdArea
                                                                              .value ==
                                                                          "0.00"
                                                                      ? Container()
                                                                      : Text(
                                                                          '\$${paymentDetailsDataList.cbdArea.value}',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: primaryfont.copyWith(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff455A64)),
                                                                        ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        });
                                              }),
                                              GetBuilder<ParcelController>(
                                                  builder: (context) {
                                                return parcelController
                                                        .paymentdatalist
                                                        .first
                                                        .additionalServices
                                                        .isEmpty
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Additonal Service",
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                            ),
                                                            Text(
                                                              "-",
                                                              style: primaryfont.copyWith(
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
                                                      )
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        // itemCount: 2,
                                                        itemCount: parcelController
                                                            .paymentdatalist
                                                            .first
                                                            .additionalServices
                                                            .length,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) {
                                                          AccessRestrictedArea
                                                              paymentDetailsDatasList =
                                                              parcelController
                                                                  .paymentdatalist
                                                                  .first
                                                                  .additionalServices[index];

                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    paymentDetailsDatasList
                                                                        .name,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: primaryfont.copyWith(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            0xff455A64)),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    '\$${paymentDetailsDatasList.value}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: primaryfont.copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            0xff455A64)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        });
                                              }),
                                              ksizedbox15,
                                              if (amountCheckParcel == true)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Discount",
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    parcelController
                                                            .redmeeCouponsData
                                                            .isEmpty
                                                        ? CircularProgressIndicator()
                                                        : parcelController
                                                                    .redmeeCouponsData
                                                                    .first
                                                                    .type ==
                                                                "percentage"
                                                            ? Text(
                                                                "${parcelController.redmeeCouponsData.first.value}%",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff455A64)),
                                                              )
                                                            : Text(
                                                                "\$${parcelController.redmeeCouponsData.first.value}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff000000)),
                                                              )
                                                  ],
                                                ),
                                              if (amountCheckParcel == true)
                                                ksizedbox10,
                                              GetBuilder<ParcelController>(
                                                  builder: (context) {
                                                return parcelController
                                                        .paymentdatalist.isEmpty
                                                    ? Container()
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        // itemCount: 2,
                                                        itemCount:
                                                            parcelController
                                                                .paymentdatalist
                                                                .length,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) {
                                                          PaymentDetailsData
                                                              paymentDetailsDataLists =
                                                              parcelController
                                                                      .paymentdatalist[
                                                                  index];

                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                paymentDetailsDataLists
                                                                    .total.name,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff000000)),
                                                              ),
                                                              Text(
                                                                '\$${amountCheckParcel == true ? totalAmountOfParcel.toStringAsFixed(2) : paymentDetailsDataLists.total.value}',
                                                                //    '\$${paymentDetailsDataLists.total.value}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff000000)),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                              }),
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

                                    print(
                                        "pickup block iD --- ${widget.senderunitIdBlockID}");
                                    print(
                                        "pickup unit id --- ${widget.unitId}");
                                    print(
                                        "drop block iD --- ${widget.receiverUnitIdBlockID}");
                                    print(
                                        "drop unit id --- ${widget.receiverunitId}");
                                    print(
                                        "total amount ---- ${parcelController.paymentdatalist.first.total.value}");

                                    return parcelController
                                            .addBookingLoading.isTrue
                                        ? Container(
                                            height: 50.h,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.kblue,
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              List<Product> products = [];

                                              debugLists();
                                              for (int index = 0;
                                                  index <
                                                      widget
                                                          .parcelLengtH.length;
                                                  index++) {
                                                products.add(Product(
                                                  parcelItems:
                                                      widget.parcelITEMS,
                                                  length: widget
                                                      .parcelLengtH[index],
                                                  width:
                                                      widget.parcelWidth[index],
                                                  height: widget
                                                      .parcelHeight[index],
                                                  qty: widget.parcelQty[index],
                                                  kg: widget.parcelKg[index],
                                                  pickupTimeFrom:
                                                      widget.pickTimeFROM!,
                                                  pickupTimeTo:
                                                      widget.pickTimeTO!,
                                                  deliveryDate:
                                                      widget.deliveyDate,
                                                  deliveryTimeFrom:
                                                      widget.deliveryTimeFROM,
                                                  deliveryTimeTo:
                                                      widget.deliveryTimeTO,
                                                ));
                                              }
                                              print(products);
                                              String diliverystatus = "0";
                                              List<BookingAddress>
                                                  bookingAddress = [];
                                              for (int index = 0;
                                                  index <
                                                      widget.droppingADDRESS
                                                          .length;
                                                  index++) {
                                                bookingAddress
                                                    .add(BookingAddress(
                                                  uintIdList:
                                                      widget.receiverunitId,
                                                  unitNoBlockNo: widget
                                                          .receiverUnitIdBlockID[
                                                      index],
                                                  reciverUnitIdBlockId: widget
                                                          .receiverUnitIdBlockID[
                                                      index],
                                                  customerName:
                                                      widget.senderNAME,
                                                  customerMobile:
                                                      widget.phoneNUMBER,
                                                  address: widget
                                                      .droppingADDRESS[index],
                                                  postalCode:
                                                      widget.arpinCODE[index],
                                                  latitude: widget
                                                      .droppingLATITUDE[index],
                                                  longitude: widget
                                                      .droppingLOGITUDE[index],
                                                  deliveryStatus:
                                                      diliverystatus,
                                                  deliveryTimeFrom:
                                                      widget.deliveryTimeFROM,
                                                  deliveryTimeTo:
                                                      widget.deliveryTimeTO,
                                                  reciverName: widget
                                                      .receiverNAME[index],
                                                  reciverMobile: widget
                                                      .receiverPHONE[index],
                                                ));
                                              }
                                              print(bookingAddress);

                                              AddBookingParcelModel
                                                  addBookingParcelModel =
                                                  AddBookingParcelModel(
                                                unitId: widget.unitId,
                                                senderUnitId:
                                                    widget.senderunitIdBlockID,
                                                totalAmountCost:
                                                    parcelController
                                                        .paymentdatalist
                                                        .first
                                                        .total
                                                        .value,
                                                pickupAddress:
                                                    widget.pickupADDRESS,
                                                deliveryTypeid: widget
                                                    .deliveryTypeID
                                                    .toString(),
                                                paymentMode: "",
                                                isRoundTrip: widget.roundtrip,
                                                bookingAmount:
                                                    amount.toStringAsFixed(2),
                                                gst: "0",
                                                additionalTotal:
                                                    additionalServiceAmount
                                                        .toStringAsFixed(2),
                                                totalAmount: parcelController
                                                    .paymentdatalist
                                                    .first
                                                    .total
                                                    .value,
                                                bookingDate: widget.bookingDATE,
                                                pickupTimeFrom:
                                                    widget.pickTimeFROM!,
                                                pickupTimeTo:
                                                    widget.pickTimeTO!,
                                                deliveryDate:
                                                    widget.deliveyDate,
                                                deliveryTimeFrom:
                                                    widget.deliveryTimeFROM,
                                                deliveryTimeTo:
                                                    widget.deliveryTimeTO,
                                                latitude: widget.pickpLATITUDE,
                                                longitude:
                                                    widget.pickupLOGITUDE,
                                                distance: widget.distance,
                                                bookingType: "parcel",
                                                additionalDetails:
                                                    additionalServiceParcelIds,
                                                notes: widget.notes,
                                                products: products,
                                                bookingAddress: bookingAddress,
                                                parcelPhoto: widget.imagePath,
                                                paymentdetails: jsonString,
                                              );

                                              parcelController
                                                  .addBookingLoading1
                                                  .value = true;
                                              try {
                                                await parcelController.addBookingParcel(
                                                    addBookingParcelModel,
                                                    amountCheckParcel == true
                                                        ? totalAmountOfParcel
                                                            .toStringAsFixed(2)
                                                        : parcelController
                                                                .paymentdatalist
                                                                .first
                                                                .total
                                                                .value
                                                                .toString() ??
                                                            '0');
                                                // Navigate to the next screen if the booking is successful
                                              } catch (error) {
                                                // Handle the error here
                                                print('Booking failed: $error');
                                              } finally {
                                                parcelController
                                                    .addBookingLoading1
                                                    .value = false;
                                              }
                                            },
                                            child: CommonContainer(
                                              name: "Confirm Payment",
                                            ),
                                          );
                                  }),

                                  ksizedbox20,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
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
