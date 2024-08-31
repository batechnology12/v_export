import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_about_details.dart';

class DriverContainerWidget extends StatefulWidget {
  const DriverContainerWidget({super.key});

  @override
  State<DriverContainerWidget> createState() => _DriverContainerWidgetState();
}

class _DriverContainerWidgetState extends State<DriverContainerWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: AppColors.kwhite,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        offset: Offset(0.0, 0.75),
                        blurRadius: 1,
                        color: AppColors.kgrey)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(color: AppColors.kwhite),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/driverprofile.png'),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lee Wong',
                                      style: primaryfont.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.5),
                                    ),
                                    Text(
                                      'Vechcle Driver',
                                      style: primaryfont.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Phone Number :',
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          ' 9876543210',
                                          style: primaryfont.copyWith(
                                              color: AppColors.kblue,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/icons/whatsappicon.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child:
                                        Image.asset('assets/icons/msgicon.png'),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rating Star',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Color(0xffFFAB18),
                                        ),
                                        Text(
                                          '3.5',
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.5),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vechicle No',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        'GBL3245N',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.5),
                                      ))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vechcle type',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        '2.4 Van',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.5),
                                      ))
                                ],
                              )
                            ],
                          ),
                          ksizedbox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //  Get.to(DriverAboutDetails());
                                },
                                child: Text(
                                  'View Details',
                                  style: primaryfont.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kblue),
                                ),
                              )
                            ],
                          ),
                          ksizedbox10
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ksizedbox20,
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
                color: AppColors.kwhite,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(0.0, 0.75),
                      blurRadius: 1,
                      color: AppColors.kgrey)
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Booking ID : #ZAG01',
                        style: primaryfont.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 15.5),
                      ),
                      Text(
                        'View',
                        style: primaryfont.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.kblue,
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  ksizedbox10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xff038484),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pickup Address',
                                style: primaryfont.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff455A64)),
                              ),
                              Text(
                                '338C Anchorvale Cresent',
                                style: primaryfont.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 11, bottom: 13),
                            child: Text('2PM to 5PM'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: Dash(
                            direction: Axis.vertical,
                            length: 50,
                            dashLength: 5,
                            dashColor: AppColors.kgrey),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xffF74354),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Delivery Address',
                                    style: primaryfont.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                ],
                              ),
                              Text(
                                '338 Serangoon North ave 6',
                                style: primaryfont.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1, bottom: 13),
                            child: Text('3PM to 6PM'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ksizedbox10,
                  Divider(),
                  ksizedbox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 65,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pickup Date',
                              style: primaryfont.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              '25/04/2024',
                              style: primaryfont.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 65,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Delivery Date',
                              style: primaryfont.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              '25/04/2024',
                              style: primaryfont.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 65,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Status',
                              style: primaryfont.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xff455A64)),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Pending',
                              style: primaryfont.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffFF8E00)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ksizedbox10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remarks',
                        style: primaryfont.copyWith(
                          fontSize: 15,
                          color: Color(0xff455A64),
                        ),
                      ),
                      Text(
                        'Call me before reaching and wait at lobby 6B',
                        style: primaryfont.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  ksizedbox20,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
