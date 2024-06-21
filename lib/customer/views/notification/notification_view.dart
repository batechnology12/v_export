import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
          'Notification',
          style: primaryfont.copyWith(
              fontSize: 22.sp,
              color: Color(0xffF4F8FF),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
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
                    color: AppColors.kwhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17))),
                child: Padding(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today',
                              style: primaryfont.copyWith(
                                  color: Color(0xff263238),
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Mark all as read',
                              style: primaryfont.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.sp,
                                  color: AppColors.kblue),
                            )
                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade200),
                                            child: Center(
                                              child: Image.asset(
                                                  todayimage[index]),
                                            ),
                                          ),
                                          Ksizedboxw10,
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7, top: 7),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  todaytitle[index],
                                                  style: primaryfont.copyWith(
                                                      fontSize: 18.sp,
                                                      color: Color(0xff263238),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                    todaydescription[index],
                                                    style: primaryfont.copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '2h',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        ksizedbox30,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yesterday',
                              style: primaryfont.copyWith(
                                  color: Color(0xff263238),
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Mark all as read',
                              style: primaryfont.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.sp,
                                  color: AppColors.kblue),
                            )
                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 55.h,
                                            width: 55.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade200),
                                            child: Center(
                                              child: Image.asset(
                                                  todayimage[index]),
                                            ),
                                          ),
                                          Ksizedboxw10,
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7, top: 7),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  todaytitle[index],
                                                  style: primaryfont.copyWith(
                                                      fontSize: 18.sp,
                                                      color: Color(0xff263238),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                    todaydescription[index],
                                                    style: primaryfont.copyWith(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '2h',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
