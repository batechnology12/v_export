import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:svg_flutter/svg.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/get_accept_booking_details_model.dart';
import 'package:v_export/customer/model/onGoing_order_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/arrived_destination.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/cancel_booking.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_about_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_message.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DriverDetailsScreen extends StatefulWidget {
  OngoingOrderData getAcceptBookingdata;
  final LatLng initialPosition;

  DriverDetailsScreen(
      {super.key,
      required this.getAcceptBookingdata,
      required this.initialPosition});
  @override
  State<DriverDetailsScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DriverDetailsScreen> {
  final ParcelController parcelController = Get.put(ParcelController());

  late GoogleMapController _controller;
  final Set<Marker> _markers = {};

  late Marker _marker;
  Location location = Location();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _initLocationAndRedirect();
    _marker = Marker(
      markerId: MarkerId('initialPosition'),
      position: widget.initialPosition,
      infoWindow: InfoWindow(title: 'Selected Location'),
    );
  }

  void _initLocationAndRedirect() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  popUp1();
      // parcelController
      //     .getAcceptBooking(widget.getAcceptBookingdata!.id.toString());
    });
  }

  void launchCaller(String phoneNumber) async {
    // Ensure the phone number includes the +65 country code
    final formattedNumber =
        phoneNumber.startsWith('+65') ? phoneNumber : '+65$phoneNumber';

    final url = 'tel:$formattedNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchWhatsApp(String phoneNumber, String message) async {
    final formattedNumber =
        phoneNumber.startsWith('+65') ? phoneNumber : '+65$phoneNumber';
    final link = WhatsAppUnilink(
      phoneNumber: formattedNumber,
      text: message,
    );

    await launch(link.asUri().toString());
  }

  _callNumber({required String phonenumber}) async {
    await FlutterPhoneDirectCaller.callNumber(phonenumber);
  }

  String formatDateString(String dateString) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date into the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  // String formatTime(String time) {
  //   DateTime parsedTime = DateFormat("h ma").parse(time);
  //   String formattedTime = DateFormat("h ma").format(parsedTime);
  //   return formattedTime;
  // }

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
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(BottomNavigationScreen(indexes: 0));
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.kblue,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.kblue,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.to(BottomNavigationScreen(indexes: 0,));
            },
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.kwhite,
            ),
          ),
          title: Text(
            'Driver Details',
            style: primaryfont.copyWith(
                fontSize: 20.sp,
                color: AppColors.kwhite,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                popUp(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    shape: BoxShape.circle),
                child: const Center(
                    child: Icon(
                  Icons.question_mark_sharp,
                  color: Colors.white,
                  size: 20,
                )),
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                height: size.height,
                width: size.width,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: widget.initialPosition,
                    zoom: 14,
                  ),
                  markers: {_marker},
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.4,
              maxChildSize: 1.0,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffF4F8FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: scrollController,
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.kwhite,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/driverprofile.png'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  //  "",
                                                  widget.getAcceptBookingdata
                                                      .driver!.fullName,
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff000000),
                                                      fontSize: 14.sp),
                                                ),
                                                Text(
                                                  'Vechcle Driver',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.sp,
                                                      color: Color(0xff455A64)),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Phone Number:',
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13.sp,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    SizedBox(
                                                      width: 5.sp,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _callNumber(
                                                            phonenumber: widget
                                                                .getAcceptBookingdata
                                                                .driver!
                                                                .phone);
                                                      },
                                                      child: Text(
                                                        // "",
                                                        ' ${widget.getAcceptBookingdata.driver!.phone}',
                                                        style: primaryfont
                                                            .copyWith(
                                                          color:
                                                              AppColors.kblue,
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              launchWhatsApp(
                                                  widget.getAcceptBookingdata
                                                      .driver!.phone,
                                                  "Hii captan");
                                            },
                                            child: Container(
                                              height: 40.h,
                                              width: 40.w,
                                              child: SvgPicture.asset(
                                                'assets/icons/08.whatsapp.svg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(DriverMessage());
                                              },
                                              child: Container(
                                                height: 40.h,
                                                width: 40.w,
                                                child: SvgPicture.asset(
                                                  'assets/icons/Group 50.svg',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Divider(),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Rating Star',
                                            style: primaryfont.copyWith(
                                                fontSize: 13.sp,
                                                color: Color(0xff455A64),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFFAB18),
                                                ),
                                                Text(
                                                  '3.5',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff000000),
                                                      fontSize: 14.sp),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vechicle No',
                                            style: primaryfont.copyWith(
                                                fontSize: 13.sp,
                                                color: Color(0xff455A64),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Text(
                                              widget
                                                  .getAcceptBookingdata
                                                  .vehicleDetails!
                                                  .vehicleNumber,
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff000000),
                                                  fontSize: 14.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vechcle type',
                                            style: primaryfont.copyWith(
                                                fontSize: 13.sp,
                                                color: Color(0xff455A64),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: Text(
                                                widget.getAcceptBookingdata
                                                    .vehicleType,
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff000000),
                                                    fontSize: 14.sp),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                  ksizedbox20,
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     ElevatedButton(
                                  //       onPressed: () {
                                  //         // Get.to(DriverAboutDetails(
                                  //         //   getAcceptBookingdata:
                                  //         //       widget.getAcceptBookingdata,
                                  //         // ));
                                  //       },
                                  //       child: Text(
                                  //         'View Details',
                                  //         style: primaryfont.copyWith(
                                  //             fontWeight: FontWeight.w600,
                                  //             fontSize: 14.sp,
                                  //             color: AppColors.kblue),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  ksizedbox10
                                ],
                              ),
                            ),
                            ksizedbox10,
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 1, bottom: 7, right: 1, left: 1),
                                width: size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Booking ID : ${widget.getAcceptBookingdata.bookingId}',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15.sp,
                                                    color: Color(0xff1E1E1E)),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Ksizedboxw10,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Column(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xff038484),
                                                      ),
                                                      Dash(
                                                          direction:
                                                              Axis.vertical,
                                                          length: 30,
                                                          dashLength: 5,
                                                          dashColor:
                                                              AppColors.kgrey),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                        width: 225.h,
                                                        child: ExpandableText(
                                                          widget
                                                              .getAcceptBookingdata
                                                              .pickupAddreess,
                                                          expandText:
                                                              'show more',
                                                          collapseText:
                                                              'show less',
                                                          maxLines: 2,
                                                          linkColor:
                                                              Colors.blue,
                                                          style: primaryfont.copyWith(
                                                              color: const Color(
                                                                  0xff1E1E1E),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    formatTime(widget
                                                        .getAcceptBookingdata
                                                        .acceptedAt),
                                                    // widget.getAcceptBookingdata
                                                    //             .bookingType ==
                                                    //         "parcel"
                                                    //     ? "${widget.getAcceptBookingdata.bookingProducts.last.pickuptimeFrom}"
                                                    //     //  \nto \n${order.pickuptimeTo}"
                                                    //     : widget
                                                    //         .getAcceptBookingdata
                                                    //         .bookingTimeFromVehicle,
                                                    textAlign: TextAlign.center,
                                                    style: primaryfont.copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff455A64)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: widget
                                                  .getAcceptBookingdata
                                                  .bookingDeliveryAddresses
                                                  .length,
                                              itemBuilder: ((context, index) {
                                                var bookingDeliveryAddress = widget
                                                        .getAcceptBookingdata
                                                        .bookingDeliveryAddresses[
                                                    index];
                                                var bookingProduct = widget
                                                    .getAcceptBookingdata
                                                    .bookingProducts
                                                    .last;
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const Icon(
                                                              Icons.location_on,
                                                              color: Color(
                                                                  0xffF74354),
                                                            ),
                                                            if (index !=
                                                                widget
                                                                        .getAcceptBookingdata
                                                                        .bookingDeliveryAddresses
                                                                        .length -
                                                                    1)
                                                              const Dash(
                                                                  direction: Axis
                                                                      .vertical,
                                                                  length: 35,
                                                                  dashLength: 5,
                                                                  dashColor:
                                                                      AppColors
                                                                          .kgrey)
                                                            else
                                                              SizedBox(
                                                                  height: 20.h),
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
                                                              width: 225.h,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          0),
                                                              child:
                                                                  ExpandableText(
                                                                bookingDeliveryAddress
                                                                    .address,
                                                                expandText:
                                                                    'show more',
                                                                collapseText:
                                                                    'show less',
                                                                maxLines: 2,
                                                                linkColor:
                                                                    Colors.blue,
                                                                style: primaryfont.copyWith(
                                                                    color: const Color(
                                                                        0xff1E1E1E),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12.sp),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: primaryfont.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0xff455A64)),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              })),
                                        ],
                                      ),
                                      ksizedbox10,
                                      const Divider(),
                                      ksizedbox10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 70.h,
                                            width: 130.w,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF5F5F5),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Pickup Date',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff455A64),
                                                      fontSize: 12.sp),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  formatDateString(widget
                                                      .getAcceptBookingdata
                                                      .bookingDate),
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 70.h,
                                            width: 130.w,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF5F5F5),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Delivery Date',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff455A64),
                                                      fontSize: 12.sp),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  widget
                                                      .getAcceptBookingdata
                                                      .bookingProducts
                                                      .first
                                                      .deliveryDate,
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      ksizedbox20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Delivery Type:',
                                                style: primaryfont.copyWith(
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.sp),
                                              ),
                                              Text(
                                                'Parcel Weight:',
                                                style: primaryfont.copyWith(
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.sp),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.getAcceptBookingdata
                                                    .deliveryType.name,
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: Color(0xff455A64)),
                                              ),
                                              Text(
                                                widget.getAcceptBookingdata
                                                    .bookingProducts.first.kg,
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: Color(0xff455A64)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      // ksizedbox15,
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [

                                      //   ],
                                      // ),
                                      ksizedbox10,
                                      Divider(),
                                      // ksizedbox15,
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       'Additional Services:',
                                      //       style: primaryfont.copyWith(
                                      //           color: Color(0xff000000),
                                      //           fontWeight: FontWeight.w700,
                                      //           fontSize: 16.sp),
                                      //     ),
                                      //     Text(
                                      //       widget.getAcceptBookingdata
                                      //                   .additionalService ==
                                      //               ""
                                      //           ? "NO"
                                      //           : "sdlk",
                                      //       style: primaryfont.copyWith(
                                      //           fontWeight: FontWeight.w600,
                                      //           fontSize: 15.sp,
                                      //           color: Color(0xff455A64)),
                                      //     )
                                      //   ],
                                      // ),
                                      // ksizedbox10,
                                      // Divider(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  popUp(BuildContext context) {
    bool isEditDetailsChecked = false;
    bool isCancelBookingChecked = false;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.9, // Set the desired width here
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 30,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  ksizedbox20,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEditDetailsChecked = !isEditDetailsChecked;
                              });
                            },
                            child: Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.kblue),
                                  borderRadius: BorderRadius.circular(5)),
                              child: isEditDetailsChecked
                                  ? Image.asset("assets/icons/7-Check.png")
                                  : Text(""),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text("edit Details",
                              style: primaryfont.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                      ksizedbox20,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCancelBookingChecked =
                                    !isCancelBookingChecked;
                              });
                            },
                            child: Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.kblue),
                                  borderRadius: BorderRadius.circular(5)),
                              child: isCancelBookingChecked
                                  ? Image.asset("assets/icons/7-Check.png")
                                  : Text(""),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text("Cancel Booking",
                              style: primaryfont.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (isCancelBookingChecked == true) {
                        Get.to(CancelBooking(bookingCancelId: "",));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.kblue,
                          borderRadius: BorderRadius.circular(30)),
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
              ),
            ),
          );
        });
      },
    );
  }

  popUp1() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            padding: EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/icons/arrived.svg"),
                  ksizedbox15,
                  Text(
                    'Arrived At Destination',
                    style: primaryfont.copyWith(
                      fontSize: 21.sp,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '338 Serangoon North ave 6, 543338',
                    style: primaryfont.copyWith(
                      fontSize: 15.sp,
                      color: Color(0xff1E1E1E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
