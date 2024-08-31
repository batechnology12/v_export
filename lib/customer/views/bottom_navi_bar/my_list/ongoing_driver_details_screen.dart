import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:svg_flutter/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/get_accept_booking_details_model.dart';
import 'package:v_export/customer/model/get_booking_details_model.dart';
import 'package:v_export/customer/model/get_ongoing_orders_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/arrived_destination.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/cancel_booking.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_about_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_message.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class OngoingDriverDetailsScreen extends StatefulWidget {
  GetOngoingOrdersModelData getOngoingOrdersModelDataList;

  OngoingDriverDetailsScreen({
    super.key,
    required this.getOngoingOrdersModelDataList,
  });
  @override
  State<OngoingDriverDetailsScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OngoingDriverDetailsScreen> {
  final ParcelController parcelController = Get.put(ParcelController());
  final MyListController myListController = Get.put(MyListController());

  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  LocationData? _currentPosition;

  Location location = Location();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _initLocationAndRedirect();
    parcelController
        .paymentshow(widget.getOngoingOrdersModelDataList.id.toString());
  }

  void _initLocationAndRedirect() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLocation();
    });
  }

  void _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _currentPosition = currentLocation;
      _controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
          zoom: 14.0,
        ),
      ));
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
          infoWindow: InfoWindow(title: 'Your Location'),
        ));
      });
    });
  }

  _callNumber({required String phonenumber}) async {
    await FlutterPhoneDirectCaller.callNumber(phonenumber);
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

  double finalTotal = 0;
  String formatTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);

      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(BottomNavigationScreen(
          indexes: 0,
        ));
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
              Get.to(BottomNavigationScreen(indexes: 0));
            },
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.kwhite,
              size: 22,
            ),
          ),
          title: Text(
            'Drivers Details',
            style: primaryfont.copyWith(
                fontSize: 19.sp,
                color: AppColors.kwhite,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            widget.getOngoingOrdersModelDataList.isConfirmed == "0"
                ? GestureDetector(
                    onTap: () {
                      popUp(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 28.h,
                      width: 28.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          shape: BoxShape.circle),
                      child: const Center(
                          child: Icon(
                        Icons.question_mark_sharp,
                        color: Colors.white,
                        size: 18,
                      )),
                    ),
                  )
                : Container(),
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
                child:
                    // Text("data"),
                    GoogleMap(
                  initialCameraPosition: _initialPosition,
                  markers: _markers,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                ),
              ),
            ),
            GetBuilder<ParcelController>(builder: (context) {
              return parcelController.paymentdata.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : DraggableScrollableSheet(
                      initialChildSize: 0.4,
                      minChildSize: 0.4,
                      maxChildSize: 1.0,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
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
                                      widget.getOngoingOrdersModelDataList
                                                  .isConfirmed ==
                                              "0"
                                          ? Container()
                                          : GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                padding: EdgeInsets.all(7),
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                    color: AppColors.kwhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                'assets/images/driverprofile.png'),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      top: 5),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    widget
                                                                        .getOngoingOrdersModelDataList
                                                                        .driver!
                                                                        .firstName,
                                                                    style: primaryfont.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            0xff000000),
                                                                        fontSize:
                                                                            17.sp),
                                                                  ),
                                                                  Text(
                                                                    'Vehicle Driver',
                                                                    style: primaryfont.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize: 13
                                                                            .sp,
                                                                        color: Color(
                                                                            0xff455A64)),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        'Phone Number:',
                                                                        style: primaryfont.copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize: 13.sp,
                                                                            color: Color(0xff455A64)),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          _callNumber(
                                                                              phonenumber: widget.getOngoingOrdersModelDataList.driver!.phone);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .getOngoingOrdersModelDataList
                                                                              .driver!
                                                                              .phone,
                                                                          style: primaryfont.copyWith(
                                                                              color: AppColors.kblue,
                                                                              fontSize: 13.sp,
                                                                              fontWeight: FontWeight.w500),
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
                                                                    widget
                                                                        .getOngoingOrdersModelDataList
                                                                        .driver!
                                                                        .phone,
                                                                    "Hii captan");
                                                              },
                                                              child: Container(
                                                                height: 40.h,
                                                                width: 40.w,
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/icons/08.whatsapp.svg',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Get.to(
                                                                      DriverMessage());
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    'assets/icons/Group 50.svg',
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Divider(),
                                                    ),
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
                                                              'Rating Star',
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Color(
                                                                      0xff455A64),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 2),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: Color(
                                                                        0xffFFAB18),
                                                                  ),
                                                                  Text(
                                                                    '3.5',
                                                                    style: primaryfont.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            0xff000000),
                                                                        fontSize:
                                                                            14.sp),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Vehicle No',
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Color(
                                                                      0xff455A64),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 2),
                                                              child: Text(
                                                                widget
                                                                    .getOngoingOrdersModelDataList
                                                                    .vehicleDetails!
                                                                    .vehicleNumber,
                                                                style: primaryfont.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff000000),
                                                                    fontSize:
                                                                        14.sp),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Vechcle type',
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Color(
                                                                      0xff455A64),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 2),
                                                                child: Text(
                                                                  widget
                                                                      .getOngoingOrdersModelDataList
                                                                      .vehicleType,
                                                                  style: primaryfont.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Color(
                                                                          0xff000000),
                                                                      fontSize:
                                                                          14.sp),
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    ksizedbox20,
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            //  Get.to(DriverAboutDetails());
                                                          },
                                                          child: Text(
                                                            'View Details',
                                                            style: primaryfont.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14.sp,
                                                                color: AppColors
                                                                    .kblue),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    ksizedbox10
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ksizedbox10,
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 1,
                                              bottom: 7,
                                              right: 1,
                                              left: 1),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          // "",
                                                          'Booking ID : ${widget.getOngoingOrdersModelDataList.bookingId}',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Color(
                                                                      0xff1E1E1E)),
                                                        ),
                                                        Text(
                                                          // "",
                                                          'Payment: ${widget.getOngoingOrdersModelDataList.paymentMode}',
                                                          style: primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12.sp,
                                                              color: const Color(
                                                                  0xff1E1E1E)),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 0),
                                                              child: Column(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .location_on,
                                                                    color: Color(
                                                                        0xff038484),
                                                                  ),
                                                                  Dash(
                                                                      direction:
                                                                          Axis
                                                                              .vertical,
                                                                      length:
                                                                          55,
                                                                      dashLength:
                                                                          5,
                                                                      dashColor:
                                                                          AppColors
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
                                                                  width: 230.h,
                                                                  child:
                                                                      ExpandableText(
                                                                    // "",
                                                                    "${widget.getOngoingOrdersModelDataList.senderUnitnoBlockno}, ${widget.getOngoingOrdersModelDataList.pickupAddreess}, ${widget.getOngoingOrdersModelDataList.unitno}",
                                                                    expandText:
                                                                        'show more',
                                                                    collapseText:
                                                                        'show less',
                                                                    maxLines: 2,
                                                                    linkColor:
                                                                        Colors
                                                                            .blue,
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
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  // "",
                                                                  formatTime(widget
                                                                      .getOngoingOrdersModelDataList
                                                                      .acceptedAt
                                                                      .toString()),
                                                                  style: primaryfont.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Color(
                                                                          0xff455A64)),
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
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
                                                            .getOngoingOrdersModelDataList
                                                            .bookingDeliveryAddresses
                                                            .length,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          BookingOngoingDeliveryAddress
                                                              bookingOngonigDeliveryDatalist =
                                                              widget.getOngoingOrdersModelDataList
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
                                                                        Icons
                                                                            .location_on,
                                                                        color: Color(
                                                                            0xffF74354),
                                                                      ),
                                                                      if (index !=
                                                                          widget.getOngoingOrdersModelDataList.bookingDeliveryAddresses.length -
                                                                              1)
                                                                        Dash(
                                                                            direction: Axis
                                                                                .vertical,
                                                                            length:
                                                                                50,
                                                                            dashLength:
                                                                                5,
                                                                            dashColor:
                                                                                AppColors.kgrey),
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
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color(0xff455A64)),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            230.h,
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            ExpandableText(
                                                                          "${bookingOngonigDeliveryDatalist.unitnoBlockno}, ${bookingOngonigDeliveryDatalist.address}, ${bookingOngonigDeliveryDatalist.unitno}",
                                                                          expandText:
                                                                              'show more',
                                                                          collapseText:
                                                                              'show less',
                                                                          maxLines:
                                                                              2,
                                                                          linkColor:
                                                                              Colors.blue,
                                                                          style: primaryfont.copyWith(
                                                                              color: const Color(0xff1E1E1E),
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12.sp),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
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
                                                      widget.getOngoingOrdersModelDataList
                                                                  .bookingType ==
                                                              "parcel"
                                                          ? MainAxisAlignment
                                                              .spaceEvenly
                                                          : MainAxisAlignment
                                                              .start,
                                                  children: [
                                                    Container(
                                                      height: 70.h,
                                                      width: 130.w,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffF5F5F5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Pickup Date',
                                                            style: primaryfont.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff455A64),
                                                                fontSize:
                                                                    12.sp),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            '${formatDate(DateTime.parse(widget.getOngoingOrdersModelDataList.bookingDate.toString()), [
                                                                  dd,
                                                                  '-',
                                                                  mm,
                                                                  '-',
                                                                  yyyy
                                                                ])}',
                                                            style: primaryfont
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        13.sp,
                                                                    color: Colors
                                                                        .black),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    widget.getOngoingOrdersModelDataList
                                                                .bookingType ==
                                                            "parcel"
                                                        ? Container(
                                                            height: 70.h,
                                                            width: 130.w,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xffF5F5F5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Delivery Date',
                                                                  style: primaryfont.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(
                                                                          0xff455A64),
                                                                      fontSize:
                                                                          12.sp),
                                                                ),
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Text(
                                                                  widget
                                                                      .getOngoingOrdersModelDataList
                                                                      .bookingProducts
                                                                      .first
                                                                      .deliveryDate
                                                                      .toString(),
                                                                  style: primaryfont.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          13.sp,
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
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
                                                        widget.getOngoingOrdersModelDataList
                                                                    .bookingType ==
                                                                "parcel"
                                                            ? Text(
                                                                'Delivery Type:',
                                                                style: primaryfont.copyWith(
                                                                    color: Color(
                                                                        0xff000000),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        14.sp),
                                                              )
                                                            : Container(),
                                                        ksizedbox5,
                                                        widget.getOngoingOrdersModelDataList
                                                                    .bookingType ==
                                                                "parcel"
                                                            ? Container()
                                                            : Text(
                                                                'Vechicle Mode:',
                                                                style: primaryfont.copyWith(
                                                                    color: Color(
                                                                        0xff000000),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        14.sp),
                                                              ),
                                                        ksizedbox5,
                                                        widget.getOngoingOrdersModelDataList
                                                                    .bookingType ==
                                                                "parcel"
                                                            ? Text(
                                                                'Parcel Weight:',
                                                                style: primaryfont.copyWith(
                                                                    color: Color(
                                                                        0xff000000),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        14.sp),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        widget.getOngoingOrdersModelDataList
                                                                    .bookingType ==
                                                                "parcel"
                                                            ? Text(
                                                                widget
                                                                    .getOngoingOrdersModelDataList
                                                                    .deliveryType
                                                                    .name,
                                                                style: primaryfont.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Color(
                                                                        0xff455A64)),
                                                              )
                                                            : Container(),
                                                        ksizedbox5,
                                                        widget.getOngoingOrdersModelDataList
                                                                    .bookingType ==
                                                                "parcel"
                                                            ? Container()
                                                            : Text(
                                                                widget
                                                                    .getOngoingOrdersModelDataList
                                                                    .vehicleType,
                                                                style: primaryfont.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Color(
                                                                        0xff455A64)),
                                                              ),
                                                        ksizedbox5,
                                                        widget.getOngoingOrdersModelDataList
                                                                    .bookingType ==
                                                                "parcel"
                                                            ? Text(
                                                                "${widget.getOngoingOrdersModelDataList.bookingProducts.first.kg}kg",
                                                                style: primaryfont.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Color(
                                                                        0xff455A64)),
                                                              )
                                                            : Container(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                ksizedbox10,
                                                Divider(),
                                                //
                                                Container(
                                                  width: size.width,
                                                  padding: EdgeInsets.only(
                                                      bottom: 5),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.kwhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              17)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Bill Details',
                                                              style: primaryfont
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16,
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
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Delivery Fees',
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
                                                                "\$${parcelController.paymentdata.first.paymentDetails.deliveryfees}",
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
                                                        ),
                                                        GetBuilder<
                                                                ParcelController>(
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
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              20),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Additonal Service",
                                                                            style: primaryfont.copyWith(
                                                                                fontSize: 14.sp,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xff455A64)),
                                                                          ),
                                                                          Text(
                                                                            "-",
                                                                            style: primaryfont.copyWith(
                                                                                fontSize: 14.sp,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xff455A64)),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : ListView
                                                                      .builder(
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
                                                                        PaymentDetailsAdditionalService addAdditionalservicelists = parcelController
                                                                            .paymentdata
                                                                            .first
                                                                            .paymentDetails
                                                                            .additionalServices[index];
                                                                        return Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 5),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                addAdditionalservicelists.name,
                                                                                style: primaryfont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Color(0xff455A64)),
                                                                              ),
                                                                              Text(
                                                                                "\$${double.tryParse(addAdditionalservicelists.value) ?? '0.00'}", // Ensure amountPerItem is a double
                                                                                style: primaryfont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Color(0xff455A64)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                              Padding(
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
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(0xff455A64)),
                                                                    ),
                                                                    Text(
                                                                      "\$${parcelController.paymentdata.first.paymentDetails.additionalStopCount}",
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
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        10),
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
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "\$${parcelController.paymentdata.first.paymentDetails.total}",
                                                                      style: primaryfont.copyWith(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              const Color(0xff455A64)),
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
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // }),
                        );
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }

  popUp(BuildContext context) {
    bool isDetailsChecked = false;
    bool isCancelBookingChecked = false;

    isSelected(bool isDetails) {
      if (isDetails) {
        isDetailsChecked = true;
        isCancelBookingChecked = false;
      } else {
        isCancelBookingChecked = true;
        isDetailsChecked = false;
      }
    }

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
                        'Need Help?',
                        style: primaryfont.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 22,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  ksizedbox10,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected(true);
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelected(true);
                                  });
                                },
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppColors.kblue),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: isDetailsChecked
                                      ? Image.asset("assets/icons/7-Check.png")
                                      : Text(""),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("edit Details",
                                  style: primaryfont.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      ksizedbox20,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected(false);
                            isChecked = true;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelected(false);
                                    isChecked = true;
                                  });
                                },
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
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
                                width: 10,
                              ),
                              Text("Cancel Booking",
                                  style: primaryfont.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (isCancelBookingChecked == true && isChecked == true) {
                        Get.to(CancelBooking(
                          bookingCancelId: widget
                              .getOngoingOrdersModelDataList.id
                              .toString(),
                        ));
                      } else {
                        Get.snackbar(
                            "Please select the above help", "Please try again!",
                            colorText: AppColors.kwhite,
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.kblue,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'Confirm',
                        style: primaryfont.copyWith(
                            fontSize: 17.sp,
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
