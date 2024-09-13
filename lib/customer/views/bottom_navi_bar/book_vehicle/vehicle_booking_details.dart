import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/add_booking_vehicle_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/get_vehicle_booking_details_model.dart';
import 'package:v_export/customer/model/get_vehicle_calculation_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/make_payment_screen.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';
import 'package:intl/intl.dart';

class DriverBookingDetails extends StatefulWidget {
  String vehiclepickupAdress;
  String vehiclepickuplat;
  String vehiclepickuplong;

  String unitId;
  String vehiclepickupunitIdBlockID;
  String vehiclepickupsendername;
  String vehicleSenderMobilenumber;
  List<AdditionalServiceData> selectedvehicleservice;
  List<String> vehicleDropAddress;
  List<String> vehicledroplat;
  List<String> vehicledroplong;
  List<String> vehiclearpincode;
  List<String> vehicleDropunitIdBlockId;
  List<String> vehicleUnitId;

  List<String> vehicleDropreceivername;
  List<String> vehicleDropreceiverphone;
  String vehicleItemsname;
  String pickupDate;
  String pickupTime;
  List<AdditionalServiceData> additionServiceItems;
  int addtionalManpowerQty;
  int addtionalStairCaseQty;
  String notes;
  String imagePath;
  String roundTrip;
  String additionalTotal;

  String vehiclePickUppincode;
  List<String> vehicleDropPincode;
  int vehicleTypeId;
  String distance;
  int manPowerQty;
  int staircaseCount;
  bool weekEnd;
  String dropLocatiocounts;
  int helperQty;
  String stairCaseTotal;
  List<String> additionalServicequantity;
  List<String> additionalServiceID;
  bool showingManPower;
  DriverBookingDetails(
      {super.key,
      required this.showingManPower,
      required this.additionalServiceID,
      required this.additionalServicequantity,
      required this.stairCaseTotal,
      required this.helperQty,
      required this.dropLocatiocounts,
      required this.weekEnd,
      required this.manPowerQty,
      required this.staircaseCount,
      required this.distance,
      required this.vehicleTypeId,
      required this.vehiclePickUppincode,
      required this.vehicleDropPincode,
      required this.addtionalManpowerQty,
      required this.addtionalStairCaseQty,
      required this.unitId,
      required this.vehicleUnitId,
      required this.additionalTotal,
      required this.roundTrip,
      required this.vehiclepickupAdress,
      required this.additionServiceItems,
      required this.imagePath,
      required this.notes,
      required this.selectedvehicleservice,
      required this.pickupDate,
      required this.pickupTime,
      required this.vehiclepickuplat,
      required this.vehicleItemsname,
      required this.vehiclepickuplong,
      required this.vehiclepickupunitIdBlockID,
      required this.vehiclepickupsendername,
      required this.vehicleSenderMobilenumber,
      required this.vehicleDropAddress,
      required this.vehicledroplat,
      required this.vehiclearpincode,
      required this.vehicledroplong,
      required this.vehicleDropunitIdBlockId,
      required this.vehicleDropreceivername,
      required this.vehicleDropreceiverphone});

  @override
  State<DriverBookingDetails> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<DriverBookingDetails> {
  List<int> additionalServiceIds = [];
  List<String> combinedArrays = [];
  List<String> combineQantity = [];
  List<String> additinalServiceID = [];
  List<int> additionalServiceParcelIds = [];

  List<String> serviceNames = [];
  List<String> serviceAmounts = [];

  @override
  void initState() {
    super.initState();
  }

  final ParcelController parcelController = Get.put(ParcelController());
  double totalAmountOfVehicle = 0;
  double totalAmountOfPercentageorFixed = 0;

  bool amountCheck = false;
  void coupondiscount() {
    if (parcelController.redmeeCouponsData.first.type == "percentage") {
      totalAmountOfPercentageorFixed = double.parse(parcelController
              .getvehicleCalculationDatas.last.totalCost.value) -
          (double.parse(parcelController
                  .getvehicleCalculationDatas.last.totalCost.value) *
              (int.parse(parcelController.redmeeCouponsData.first.value) /
                  100));
    } else if (parcelController.redmeeCouponsData.first.type == "fixed") {
      totalAmountOfPercentageorFixed = double.parse(parcelController
              .getvehicleCalculationDatas.last.totalCost.value) -
          double.parse(parcelController.redmeeCouponsData.first.value);
    }
    setState(() {
      totalAmountOfVehicle = totalAmountOfPercentageorFixed;
      amountCheck = true;
    });
  }

  void applyCoupon() async {
    await parcelController.redeemeCouponsApi(couponController.text);
    coupondiscount();
  }

  List<String> getID() {
    additinalServiceID = widget.selectedvehicleservice
        .map((service) => service.id.toString())
        .toList();

    print("service id====");
    print(additinalServiceID);
    return additinalServiceID;
  }

  var couponController = TextEditingController();

  final HomeController homeController = Get.put(HomeController());
  final easebuzzController = Get.put(EasebuszzController());

  String totalAmount = "";
  final formKey = GlobalKey<FormState>();

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }

  bool isCheck = false;

  List<int> selectedId = [];

  double additionalServiceAmount = 0.0;
  String jsonString = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    additionalServiceIds =
        widget.selectedvehicleservice.map((service) => service.id).toList();

    combinedArrays = [
      widget.vehiclePickUppincode,
      ...widget.vehicleDropPincode
    ];

    combineQantity = [
      widget.manPowerQty.toString(),
      widget.staircaseCount.toString()
    ];

    for (var element in widget.vehicleDropPincode) {
      print("drop pin $element");
    }
    String postalCodeResults = combinedArrays.join(',');

    // List<String> additionalServiceVehicleIdsString =
    //     additionalServiceIds.map((id) => id.toString()).toList();

    parcelController.getVehicleCalculationApi(
        widget.vehicleTypeId.toString(),
        widget.distance,
        widget.roundTrip == "1" ? "yes" : "no",
        widget.dropLocatiocounts == "1"
            ? "0"
            : widget.dropLocatiocounts == "2"
                ? "1"
                : widget.dropLocatiocounts == "3"
                    ? "2"
                    : widget.dropLocatiocounts == "4"
                        ? "3"
                        : widget.dropLocatiocounts == "5"
                            ? "4"
                            : widget.dropLocatiocounts == "6"
                                ? "5"
                                : widget.dropLocatiocounts == "7"
                                    ? "6"
                                    : widget.dropLocatiocounts == "8"
                                        ? "7"
                                        : widget.dropLocatiocounts == "9"
                                            ? "8"
                                            : widget.dropLocatiocounts == "10"
                                                ? "9"
                                                : "0",
        // (widget.dropLocatiocounts != "0") ? (int.parse(widget.dropLocationcounts) - 1).toString() : "0",
        widget.manPowerQty.toString() == "1"
            ? "yes"
            : widget.manPowerQty.toString() == "2"
                ? "yes"
                : widget.manPowerQty.toString() == "3"
                    ? "yes"
                    : "no",
        widget.helperQty == 2
            ? "1"
            : widget.helperQty == 3
                ? "2"
                : "0",
        widget.weekEnd ? "yes" : "no",
        widget.additionalServiceID,
        widget.additionalServicequantity,
        postalCodeResults);

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
          child: GetBuilder<ParcelController>(builder: (_) {
            return parcelController.getvehicleCalculationDatas.isEmpty
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
                                                        color:
                                                            Color(0xff1E1E1E),
                                                        fontSize: 19.sp),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              ksizedbox5,
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Pickup Details:',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xff000000),
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    Text(
                                                      widget.pickupDate,
                                                      style:
                                                          primaryfont.copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Text(
                                                      widget.pickupTime,
                                                      style:
                                                          primaryfont.copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
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
                                                          'Address                 : ',
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
                                                              "${widget.vehiclepickupunitIdBlockID}, ${widget.vehiclepickupAdress}, ${widget.unitId}",
                                                          //  '${widget.getVehicleBookingDetailsDataList!.pickupAddreess}',
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
                                                  text:
                                                      'Name                     : ',
                                                  style: primaryfont.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: widget
                                                          .vehiclepickupsendername,
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
                                                  text:
                                                      'Phone                    : ',
                                                  style: primaryfont.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: widget
                                                          .vehicleSenderMobilenumber,
                                                      //    '${widget.getVehicleBookingDetailsDataList!.bookingDeliveryAddresses.first.customerMobile}',
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
                                              ksizedbox15,
                                              Divider(),
                                              ksizedbox10,
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Delivery Details:',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xff000000),
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ],
                                                ),
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
                                                          .vehicleDropAddress
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                text: homeController
                                                                        .isCheckedVehicleLocation
                                                                    ? 'Address:- ${index + 1}               : '
                                                                    : 'Address:-                : ',
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
                                                                        // "${widget.vehiclepickupunitIdBlockID}, ${widget.vehiclepickupAdress}, ${widget.unitId}",

                                                                        "${widget.vehicleDropunitIdBlockId[index].split('[').last.split(']').first}, ${widget.vehicleDropAddress[index]}, ${widget.vehicleUnitId[index].split('[').last.split(']').first}",
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
                                                                    'Name                         : ',
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
                                                                            .vehicleDropreceivername[
                                                                        index],
                                                                    // .join(
                                                                    //     ", "),
                                                                    //  '${widget.getVehicleBookingDetailsDataList!.bookingDeliveryAddresses.first.reciverName}',
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
                                                                    'Phone                        : ',
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
                                                                            .vehicleDropreceiverphone[
                                                                        index],
                                                                    //     .join(", "),
                                                                    //  "djshjkdn",
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
                                                            ksizedbox15,
                                                          ],
                                                        );
                                                      }),
                                                ),
                                              ),
                                              Divider(),
                                              ksizedbox5,
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
                                                        'Vehicle Mode',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      ksizedbox5,
                                                      widget.roundTrip == "1"
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
                                                        widget.roundTrip == "1"
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
                                                      Container(
                                                        width: 130,
                                                        child: Text(
                                                          widget
                                                              .vehicleItemsname,
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                        ),
                                                      ),
                                                      ksizedbox5,
                                                      widget.roundTrip == "1"
                                                          ? Container(
                                                              width: 130,
                                                              child: Text(
                                                                widget.roundTrip ==
                                                                        "1"
                                                                    ? "Yes"
                                                                    : "No",
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Color(
                                                                        0xff455A64)),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              ksizedbox10,
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                  Container(
                                                    width: 130,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Check if showingManPower is true and selectedvehicleservice is not empty
                                                        if (widget
                                                            .showingManPower)
                                                          Text(
                                                            "ManPower (helper)",
                                                            style: primaryfont
                                                                .copyWith(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xff455A64),
                                                            ),
                                                          ),
                                                        // Render ListView only if selectedvehicleservice is not empty
                                                        Container(
                                                            width: 130,
                                                            child: widget
                                                                        .selectedvehicleservice
                                                                        .isEmpty &&
                                                                    widget.showingManPower ==
                                                                        false
                                                                ? Text(
                                                                    "No",
                                                                    style: primaryfont
                                                                        .copyWith(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(
                                                                          0xff455A64),
                                                                    ),
                                                                  )
                                                                : Container()),
                                                        ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: widget
                                                              .selectedvehicleservice
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            AdditionalServiceData
                                                                additionalServiceData =
                                                                widget.selectedvehicleservice[
                                                                    index];
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          8), // Optional spacing between items
                                                              width: 200,
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: widget
                                                                      .selectedvehicleservice
                                                                      .isEmpty
                                                                  ? Container(
                                                                      width:
                                                                          130,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: const Text(
                                                                          "No"))
                                                                  : Text(
                                                                      additionalServiceData
                                                                          .name,
                                                                      style: primaryfont
                                                                          .copyWith(
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Color(
                                                                            0xff455A64),
                                                                      ),
                                                                    ),
                                                            );
                                                          },
                                                        ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Text("data"),
                                                ],
                                              ),
                                              ksizedbox5,
                                            ],
                                          ),
                                        ),
                                      ),
                                      ksizedbox10,
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
                                              widget.imagePath.isNotEmpty
                                                  ? Text(
                                                      'Vehicle Picture',
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp),
                                                    )
                                                  : Container(),
                                              widget.imagePath.isNotEmpty
                                                  ? ksizedbox10
                                                  : Container(),
                                              widget.imagePath.isNotEmpty
                                                  ? ClipRRect(
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
                                                          File(widget.imagePath
                                                                  .isEmpty
                                                              ? ""
                                                              : widget
                                                                  .imagePath),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              ksizedbox10,
                                              Text(
                                                'Deliver Notes',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.sp),
                                              ),
                                              ksizedbox10,
                                              Container(
                                                width: size.width,
                                                child: Text(
                                                  //  "sjdjd",
                                                  widget.notes,
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      color: Color(0xff1E1E1E),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
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
                                              Container(
                                                height: 50.h,
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: TextField(
                                                  controller: couponController,
                                                  textAlign: TextAlign.left,
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
                                                          amountCheck = true;
                                                          print(
                                                              "totalcostofvehicle------ ${parcelController.getvehicleCalculationDatas.last.totalCost.value}");
                                                          print(
                                                              "totalamountofvehicle------ ${totalAmountOfVehicle.toStringAsFixed(2)}");
                                                          // });
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          height: 40.h,
                                                          width: 90.w,
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
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                                        fontSize: 17.sp,
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
                                              GetBuilder<ParcelController>(
                                                  builder: (context) {
                                                return ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: parcelController
                                                        .getvehicleCalculationDatas
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      VehiclePaymentDetails
                                                          getVehicleBookingDetailsData =
                                                          parcelController
                                                                  .getvehicleCalculationDatas[
                                                              index];
                                                      totalAmount =
                                                          getVehicleBookingDetailsData
                                                              .totalCost.value;
                                                      List<Map<String, dynamic>>
                                                          additionalServicesList =
                                                          getVehicleBookingDetailsData
                                                              .additionalServices
                                                              .map((service) {
                                                        return {
                                                          'name': service
                                                              .serviceName,
                                                          'value': service
                                                              .serviceCost,
                                                        };
                                                      }).toList();
                                                      Map<String, dynamic>
                                                          data = {
                                                        "deliveryfees":
                                                            getVehicleBookingDetailsData
                                                                .deliveryFees
                                                                .value,
                                                        "roundtripCost":
                                                            getVehicleBookingDetailsData
                                                                .roundTripCost
                                                                .value,
                                                        "additionalStopCount":
                                                            getVehicleBookingDetailsData
                                                                .additionalStopCost
                                                                .value,
                                                        "driverHelpCost":
                                                            getVehicleBookingDetailsData
                                                                .driverHelpCost
                                                                .value,
                                                        "helperCost":
                                                            getVehicleBookingDetailsData
                                                                .helperCost
                                                                .value,
                                                        'additional_services':
                                                            additionalServicesList,
                                                        "total": amountCheck ==
                                                                true
                                                            ? totalAmountOfVehicle
                                                                .toStringAsFixed(
                                                                    2)
                                                            : getVehicleBookingDetailsData
                                                                .totalCost
                                                                .value,
                                                        "weekend":
                                                            getVehicleBookingDetailsData
                                                                .weekendCost
                                                                .value,
                                                        "staircase (per floor)":
                                                            widget
                                                                .stairCaseTotal,
                                                        "discount": amountCheck ==
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
                                                                getVehicleBookingDetailsData
                                                                    .deliveryFees
                                                                    .name,
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff455A64)),
                                                              ),
                                                              getVehicleBookingDetailsData
                                                                          .roundTripCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      getVehicleBookingDetailsData
                                                                          .roundTripCost
                                                                          .name,
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                              getVehicleBookingDetailsData
                                                                          .additionalStopCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      getVehicleBookingDetailsData
                                                                          .additionalStopCost
                                                                          .name,
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                              getVehicleBookingDetailsData
                                                                          .driverHelpCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      getVehicleBookingDetailsData
                                                                          .driverHelpCost
                                                                          .name,
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                              getVehicleBookingDetailsData
                                                                          .helperCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      getVehicleBookingDetailsData
                                                                          .helperCost
                                                                          .name,
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                              getVehicleBookingDetailsData
                                                                          .weekendCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      getVehicleBookingDetailsData
                                                                          .weekendCost
                                                                          .name,
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                '\$${getVehicleBookingDetailsData.deliveryFees.value}',
                                                                style: primaryfont.copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff455A64)),
                                                              ),
                                                              getVehicleBookingDetailsData
                                                                          .roundTripCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      '\$${getVehicleBookingDetailsData.roundTripCost.value}',
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                              getVehicleBookingDetailsData
                                                                          .additionalStopCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      '\$${getVehicleBookingDetailsData.additionalStopCost.value}',
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                              getVehicleBookingDetailsData
                                                                          .driverHelpCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      '\$${getVehicleBookingDetailsData.driverHelpCost.value}',
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                              getVehicleBookingDetailsData
                                                                          .helperCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      '\$${getVehicleBookingDetailsData.helperCost.value}',
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                              getVehicleBookingDetailsData
                                                                          .weekendCost
                                                                          .value ==
                                                                      "0.00"
                                                                  ? Container()
                                                                  : Text(
                                                                      '\$${getVehicleBookingDetailsData.weekendCost.value}',
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    });
                                              }),
                                              /////
                                              GetBuilder<ParcelController>(
                                                  builder: (context) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: parcelController
                                                        .getvehicleCalculationDatas
                                                        .first
                                                        .additionalServices
                                                        .length,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      AdditionalServiceListData
                                                          additionalServiceListData =
                                                          parcelController
                                                              .getvehicleCalculationDatas
                                                              .first
                                                              .additionalServices[index];

                                                      String serviceCost =
                                                          (additionalServiceListData
                                                                          .serviceName ==
                                                                      "Staircase (per floor)" &&
                                                                  index == 2)
                                                              ? widget
                                                                  .stairCaseTotal
                                                                  .toString()
                                                              : additionalServiceListData
                                                                  .serviceCost
                                                                  .toString();

                                                      print(
                                                          'Index: $index, serviceName: ${additionalServiceListData.serviceName}, serviceCost: $serviceCost');

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
                                                                additionalServiceListData
                                                                    .serviceName,
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
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                '\$$serviceCost',

                                                                // '\$${additionalServiceListData.serviceCost}',
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
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              }),
                                              ksizedbox15,
                                              if (amountCheck == true)
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
                                              if (amountCheck == true)
                                                ksizedbox10,
                                              GetBuilder<ParcelController>(
                                                  builder: (context) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    // itemCount: 2,
                                                    itemCount: parcelController
                                                        .getvehicleCalculationDatas
                                                        .length,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      VehiclePaymentDetails
                                                          getVehicleBookingDetailsDatas =
                                                          parcelController
                                                                  .getvehicleCalculationDatas[
                                                              index];

                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            getVehicleBookingDetailsDatas
                                                                .totalCost.name,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: primaryfont.copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff000000)),
                                                          ),
                                                          Text(
                                                            '\$${amountCheck == true ? totalAmountOfVehicle.toStringAsFixed(2) : getVehicleBookingDetailsDatas.totalCost.value}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: primaryfont.copyWith(
                                                                fontSize: 15.sp,
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

                                              ksizedbox40,
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  ksizedbox40,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Obx(() {
                                      return parcelController
                                              .addBookingVehicleLoading.isTrue
                                          ? Container(
                                              height: 50.h,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  // color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: AppColors.kblue,
                                              )),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                print(
                                                    "JSON Data-----------------: $jsonString");
                                                print(
                                                    "vehical cost------ ${parcelController.getvehicleCalculationDatas.last.totalCost.value}");

                                                List<BookingVehicleAddress>
                                                    bookingAddressList = [];
                                                for (var i = 0;
                                                    i <
                                                        widget
                                                            .vehicleDropAddress
                                                            .length;
                                                    i++) {
                                                  bookingAddressList.add(
                                                    BookingVehicleAddress(
                                                      senderName: widget
                                                          .vehiclepickupsendername,
                                                      senderMobile: widget
                                                          .vehicleSenderMobilenumber,

                                                      ///
                                                      // unitNoBlockNo: widget
                                                      //     .vehiclepickupunitIdBlockID,

                                                      vehicleUnitId: widget
                                                          .vehicleUnitId[i],
                                                      vehiclereciverUnitIdBlockId:
                                                          widget.vehicleDropunitIdBlockId[
                                                              i],
                                                      /////
                                                      address: widget
                                                          .vehicleDropAddress[i],
                                                      postalCode: ["78677"],
                                                      latitude: homeController
                                                          .vehicledroppingLats[i],
                                                      longitude: homeController
                                                          .vehicledropLongs[i],
                                                      deliveryStatus: "0",
                                                      reciverName: homeController
                                                          .vehiclereceiverNameList[i],
                                                      reciverMobile: homeController
                                                          .vehiclereceiverNumberList[i],
                                                    ),
                                                  );
                                                }
                                                print(
                                                    "booking address list-----");
                                                print(bookingAddressList);

                                                AddBookingVehicleModel
                                                    addBookingVehicleModel =
                                                    AddBookingVehicleModel(
                                                        paymentDetails:
                                                            jsonString,
                                                        totalManpwoerValue: widget
                                                            .addtionalManpowerQty,
                                                        totalStaircaseValue: widget
                                                            .addtionalStairCaseQty,
//////
                                                        senderUnitId: widget
                                                            .vehiclepickupunitIdBlockID,
                                                        pickupunitId:
                                                            widget.unitId,
                                                        ////
                                                        bookingTime:
                                                            widget.pickupTime,
                                                        pickupAddress: widget
                                                            .vehiclepickupAdress,
                                                        vehicleType: widget
                                                            .vehicleItemsname,
                                                        paymentMode: "",
                                                        bookingAmount: parcelController
                                                            .getvehicleCalculationDatas
                                                            .last
                                                            .totalCost
                                                            .value,
                                                        gst: "0",
                                                        additionalTotal: widget
                                                            .additionalTotal,
                                                        totalAmount: parcelController
                                                            .getvehicleCalculationDatas
                                                            .last
                                                            .totalCost
                                                            .value,
                                                        isRoundTrip:
                                                            widget.roundTrip,
                                                        pickupDate:
                                                            widget.pickupDate,
                                                        pickupTimeFrom:
                                                            widget.pickupTime,
                                                        pickupTimeTo:
                                                            widget.pickupTime,
                                                        latitude: widget
                                                            .vehiclepickuplat,
                                                        longitude: widget
                                                            .vehiclepickuplong,
                                                        distance: widget.distance,
                                                        bookingType: "vehicle",
                                                        additionalDetails: widget.additionServiceItems,
                                                        //widget.additionServiceId,
                                                        notes: widget.notes,
                                                        bookingVehicleAddress: bookingAddressList,
                                                        parcelPhoto: widget.imagePath);

                                                parcelController
                                                    .addBookingVehicleLoading
                                                    .value = true;
                                                try {
                                                  // await parcelController.addBookingParcel(addBookingParcelModel);
                                                  // Navigate to the next screen if the booking is successful
                                                  await parcelController.addBookingVehicleApi(
                                                      addBookingVehicleModel,
                                                      amountCheck == true
                                                          ? totalAmountOfVehicle
                                                              .toStringAsFixed(
                                                                  2)
                                                          : parcelController
                                                                  .getvehicleCalculationDatas
                                                                  .last
                                                                  .totalCost
                                                                  .value
                                                                  .toString() ??
                                                              '0' // Default to '0' if null
                                                      );
                                                } catch (error) {
                                                  // Handle the error here
                                                  print(
                                                      'Booking failed: $error');
                                                } finally {
                                                  parcelController
                                                      .addBookingVehicleLoading
                                                      .value = false;
                                                }
                                              },
                                              child: CommonContainer(
                                                name: "Confirm Payment",
                                              ));
                                    }),
                                  ),
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
}
