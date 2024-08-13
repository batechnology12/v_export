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
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/make_payment_screen.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';
import 'package:intl/intl.dart';

class DriverBookingDetails extends StatefulWidget {
  // GetVehicleBookingDetailsData? getVehicleBookingDetailsDataList;
  String vehiclepickupAdress;
  String vehiclepickuplat;
  String vehiclepickuplong;
  String vehiclepickupunitIdBlockID;
  String vehiclepickupsendername;
  String vehicleSenderMobilenumber;

  List<AdditionalServiceData> selectedvehicleservice;
  List<String> vehicleDropAddress;
  List<String> vehicledroplat;
  List<String> vehicledroplong;
  List<String> vehiclearpincode;
//  List<String> vehicledoorname;
  List<String> vehicleDropunitIdBlockId;
  List<String> vehicleDropreceivername;
  List<String> vehicleDropreceiverphone;
  String vehicleItemsname;
  String pickupDate;
  String pickupTime;
  List<String> additionServiceId;
  String notes;
  String imagePath;
  String roundTrip;
  String additionalTotal;
  DriverBookingDetails(
      {super.key,
      required this.additionalTotal,
      required this.roundTrip,
      required this.vehiclepickupAdress,
      required this.additionServiceId,
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
      //  required this.vehicledoorname,
      required this.vehicledroplong,
      required this.vehicleDropunitIdBlockId,
      required this.vehicleDropreceivername,
      required this.vehicleDropreceiverphone});

  @override
  State<DriverBookingDetails> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<DriverBookingDetails> {
  @override
  void initState() {
    super.initState();
    // parcelController.addBookingVehicleApi(getVehicleBookingDetailsDataList);
  }

  var couponController = TextEditingController();

  final HomeController homeController = Get.find<HomeController>();
  final easebuzzController = Get.find<EasebuszzController>();
  final ParcelController parcelController = Get.find<ParcelController>();
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

  bool isCheck = false;

  List<int> selectedId = [];

  double additionalServiceAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<int> additionalServiceIds =
        widget.selectedvehicleservice.map((service) => service.id).toList();
    print(additionalServiceIds);
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
                                                color: Color(0xff1E1E1E),
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
                                              'Pickup Details:',
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff000000),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              widget.pickupDate,
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              widget.pickupTime,
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox5,
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          width: size.width,
                                          child: RichText(
                                            text: TextSpan(
                                              text:
                                                  'Address                 : ',
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: widget
                                                      .vehiclepickupAdress,
                                                  //  '${widget.getVehicleBookingDetailsDataList!.pickupAddreess}',
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
                                          text: 'Name                     : ',
                                          style: primaryfont.copyWith(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: widget
                                                  .vehiclepickupsendername,
                                              // "sjdjd",
                                              //  '${widget.getVehicleBookingDetailsDataList!.bookingDeliveryAddresses.first.customerName}',
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
                                          text: 'Phone                    : ',
                                          style: primaryfont.copyWith(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: widget
                                                  .vehicleSenderMobilenumber,
                                              //    '${widget.getVehicleBookingDetailsDataList!.bookingDeliveryAddresses.first.customerMobile}',
                                              style: primaryfont.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox15,
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
                                              'Delivery Details:',
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff000000),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
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
                                              itemCount: widget
                                                  .vehicleDropAddress.length,
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
                                                                  .vehicleDropAddress[
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
                                              text: widget
                                                  .vehicleDropreceivername
                                                  .join(", "),
                                              //  '${widget.getVehicleBookingDetailsDataList!.bookingDeliveryAddresses.first.reciverName}',
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
                                              text: widget
                                                  .vehicleDropreceiverphone
                                                  .join(", "),
                                              // "sjdjd",
                                              //   '${widget.getVehicleBookingDetailsDataList!.bookingDeliveryAddresses.first.reciverMobile}',
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
                                      ksizedbox5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Vehicle Mode',
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
                                              ]),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 130,
                                                child: Text(
                                                  widget.vehicleItemsname,
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff455A64)),
                                                ),
                                              ),
                                              ksizedbox5,
                                              Container(
                                                width: 130,
                                                child: Text(
                                                  widget.roundTrip == "1"
                                                      ? "Yes"
                                                      : "No",
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff455A64)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      ksizedbox10,
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
                                            width: 130,
                                            child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: widget
                                                    .selectedvehicleservice
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  AdditionalServiceData
                                                      additionalServiceData =
                                                      widget.selectedvehicleservice[
                                                          index];
                                                  return widget
                                                          .selectedvehicleservice
                                                          .isEmpty
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
                                                                      0xff455A64)),
                                                        )
                                                      : Container(
                                                          width: 200,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            additionalServiceData
                                                                .name,
                                                            style: primaryfont.copyWith(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff455A64)),
                                                          ),
                                                        );
                                                }),
                                          )
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
                                        'Drivery Notes',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp),
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
                                              fontWeight: FontWeight.w500),
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
                                                  height: 40.h,
                                                  width: 90.w,
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
                                      // Text("data"),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: widget
                                              .selectedvehicleservice.length,
                                          itemBuilder: (context, index) {
                                            AdditionalServiceData
                                                additionalServiceDat1 =
                                                widget.selectedvehicleservice[
                                                    index];
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  additionalServiceDat1.name,
                                                  // widget
                                                  //     .getVehicleBookingDetailsDataList!
                                                  //     .additionalServices[index]
                                                  //     .name,
                                                  style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff455A64)),
                                                ),
                                                Text(
                                                  additionalServiceDat1.amount,
                                                  // '\$${widget.getVehicleBookingDetailsDataList!.additionalServices[index].amount}',
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
                                            "${widget.additionalTotal}",
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
                            child: Obx(() {
                              return parcelController
                                      .addBookingVehicleLoading.isTrue
                                  ? Container(
                                      height: 50.h,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          // color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: AppColors.kblue,
                                      )),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        //
                                        List<BookingVehicleAddress>
                                            bookingAddress = [
                                          BookingVehicleAddress(
                                              senderName: widget
                                                  .vehiclepickupsendername,
                                              senderMobile: widget
                                                  .vehicleSenderMobilenumber,
                                              unitNoBlockNo: widget
                                                  .vehiclepickupunitIdBlockID,
                                              address:
                                                  widget.vehicleDropAddress,
                                              postalCode: ["78677"],
                                              latitude: homeController
                                                  .vehicledroppingLats,
                                              longitude: homeController
                                                  .vehicledropLongs,
                                              deliveryStatus: "0",
                                              reciverName: homeController
                                                  .vehiclereceiverNameList,
                                              reciverMobile: homeController
                                                  .vehiclereceiverNumberList,
                                              vehiclereciverUnitIdBlockId: widget
                                                  .vehicleDropunitIdBlockId),
                                        ];
                                        AddBookingVehicleModel
                                            addBookingVehicleModel =
                                            AddBookingVehicleModel(
                                                bookingTime: widget.pickupTime,
                                                // _formatTime(pickTime!),
                                                pickupAddress:
                                                    widget.vehiclepickupAdress,
                                                vehicleType:
                                                    widget.vehicleItemsname,
                                                paymentMode: "500",
                                                bookingAmount: "500",
                                                gst: "500",
                                                additionalTotal:
                                                    widget.additionalTotal,
                                                totalAmount: "500",
                                                isRoundTrip: widget.roundTrip,
                                                pickupDate: widget.pickupDate,
                                                pickupTimeFrom:
                                                    widget.pickupTime,
                                                pickupTimeTo: widget.pickupTime,
                                                latitude:
                                                    widget.vehiclepickuplat,
                                                longitude:
                                                    widget.vehiclepickuplong,
                                                distance: "30",
                                                bookingType: "vehicle",
                                                additionalDetails:
                                                    additionalServiceIds,
                                                //widget.additionServiceId,
                                                notes: widget.notes,
                                                bookingVehicleAddress:
                                                    bookingAddress,
                                                parcelPhoto: widget.imagePath);
                                        parcelController.addBookingVehicleApi(
                                            addBookingVehicleModel);
                                        // easebuzzController
                                        //     .tablepayUseingEaseBuzzSubs();
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
          ),
        ),
      ),
    );
  }
}
