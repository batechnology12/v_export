import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingStatus extends StatefulWidget {
  @override
  State<BookingStatus> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BookingStatus> {
  GoogleMapController? myController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
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
              color: Colors.yellow,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10.0,
                ),
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
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child:
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Booking ID : #ZAG01',
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
                                            '25/04/2024',
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          ),
                                          Text(
                                            '2PM to 5PM',
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
                                          '338C Anchorvale Cresent, 543338',
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
                                            '25/04/2024',
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Color(0xff455A64)),
                                          ),
                                          Text(
                                            '3PM to 7PM',
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
                                          '338C Anchorvale Cresent, 543338',
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
                                            '3 hours Delivery',
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
                                            '1kg',
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
                                        'Call me before reaching and wait at lobby 6B',
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
