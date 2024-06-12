import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  List todayimage = [
    'assets/images/notifi_profile1.png',
    'assets/images/notifi_profile2.png',
    'assets/images/notifi_profile3.png'
  ];
  List todaytitle = [
    'Ride Booked Successfully',
    '50% Off on First Ride',
    'Ride Review Request'
  ];
  List todaydescription = [
    'Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.',
    'Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.',
    'Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.'
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: Container(),
        title: Text(
          'Wallet',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 150.h),
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffF4F8FF),
                    //  color: Color.fromARGB(255, 235, 232, 232),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 5),
                            width: size.width,
                            decoration: BoxDecoration(
                                color: AppColors.kwhite,
                                // boxShadow: <BoxShadow>[
                                //   BoxShadow(
                                //       offset: Offset(0.0, 0.75),
                                //       blurRadius: 4,
                                //       color: AppColors.kgrey)
                                // ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/icons/Ellipse 26 (1).png",
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 20.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Lee Wong",
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 17.sp),
                                        ),
                                        Text(
                                          "Vechcle Driver",
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff455A64),
                                              fontSize: 13.sp),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            Ksizedboxw10,
                                            Text(
                                              "3.5",
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 16.sp),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      height: 35.h,
                                      width: 100.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xffFFBFBF),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Cancelled',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Color(0xffFF2D55)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          ksizedbox10,
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            width: size.width,
                            decoration: BoxDecoration(
                                color: AppColors.kwhite,
                                // boxShadow: <BoxShadow>[
                                //   BoxShadow(
                                //       offset: Offset(0.0, 0.95),
                                //       blurRadius: 4,
                                //       color: AppColors.kgrey)
                                // ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Column(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0xff038484),
                                          ),
                                          Dash(
                                              direction: Axis.vertical,
                                              length: 85,
                                              dashLength: 5,
                                              dashColor: AppColors.kgrey),
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0xffF74354),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pickup Address',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff455A64)),
                                              ),
                                              Text(
                                                '338 Serangoon North ave 6',
                                                style: primaryfont.copyWith(
                                                    color: Color(0xff1E1E1E),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.sp),
                                              ),
                                              Text(
                                                '2:30 PM',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13.sp,
                                                    color: Color(0xff455A64)),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 40.h,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Drop Address',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff455A64)),
                                              ),
                                              Text(
                                                '338 Serangoon North ave 6',
                                                style: primaryfont.copyWith(
                                                    color: Color(0xff1E1E1E),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.sp),
                                              ),
                                              Text(
                                                '2:30 PM',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13.sp,
                                                    color: Color(0xff455A64)),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
