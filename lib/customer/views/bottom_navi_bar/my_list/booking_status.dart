import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:intl/intl.dart';
import 'package:v_export/customer/model/get_ongoing_orders_model.dart';

class BookingStatus extends StatefulWidget {
  @override
  State<BookingStatus> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BookingStatus> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  late LocationData _currentPosition;
  Location location = Location();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    //  _getLocation();
    myListController.getOngoingOrdersUser("ongoing");
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
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(_currentPosition.latitude!, _currentPosition.longitude!),
          zoom: 14.0,
        ),
      ));
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition.latitude!, _currentPosition.longitude!),
          infoWindow: InfoWindow(title: 'Your Location'),
        ));
      });
    });
  }

  MyListController myListController = Get.find<MyListController>();
  ParcelController parcelController = Get.find<ParcelController>();

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Booking status',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Container(
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
              //  color: Colors.yellow,
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                markers: _markers,
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
            builder: (BuildContext context, ScrollController scrollController) {
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
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            myListController.getOngoingOrdersModelData.length,
                        itemBuilder: (BuildContext context, int index) {
                          GetOngoingOrdersModelData getongoingDatas =
                              myListController.getOngoingOrdersModelData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: ClipRRect(
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Booking ID : ${getongoingDatas.bookingId}',
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.5),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      ksizedbox10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Pickup details',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            formatDate(
                                                DateTime.parse(getongoingDatas
                                                    .bookingDate
                                                    .toString()),
                                                [dd, '-', mm, '-', yyyy]),
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          ),
                                          Text(
                                            '${getongoingDatas.bookingProducts[index].pickuptimeFrom} to ${getongoingDatas.bookingProducts[index].pickuptimeTo}',
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox10,
                                      Container(
                                        width: size.width,
                                        child: Text(
                                          getongoingDatas.pickupAddreess,
                                          style: primaryfont.copyWith(
                                              color: const Color(0xff1E1E1E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                      ksizedbox20,
                                      const Divider(),
                                      ksizedbox20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Delivery details',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            getongoingDatas.bookingType ==
                                                    "parcel"
                                                ? getongoingDatas
                                                    .bookingProducts[index]
                                                    .deliveryDate
                                                    .toString()
                                                : "",
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          ),
                                          Text(
                                            getongoingDatas.bookingType ==
                                                    "parcel"
                                                ? '${getongoingDatas.bookingProducts[index].deliverytimeFrom} to ${getongoingDatas.bookingProducts[index].deliverytimeTo}'
                                                : "",
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox10,
                                      Container(
                                        width: size.width,
                                        child: Text(
                                          getongoingDatas
                                              .bookingDeliveryAddresses[index]
                                              .address,
                                          style: primaryfont.copyWith(
                                              color: Color(0xff1E1E1E),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                      ksizedbox20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Delivery Type:',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            getongoingDatas.deliveryType.name,
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Vechicle Mode:',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            'All',
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox15,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Parcel Weight:',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            getongoingDatas
                                                .bookingProducts[index].kg,
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox15,
                                      Divider(),
                                      ksizedbox15,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Additional Services:',
                                            style: primaryfont.copyWith(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            'No',
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      ),
                                      ksizedbox10,
                                      Divider(),
                                      ksizedbox10,
                                      Text(
                                        'Driver Notes',
                                        style: primaryfont.copyWith(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        getongoingDatas.notes,
                                        style: primaryfont.copyWith(
                                            color: Color(0xff1E1E1E),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
