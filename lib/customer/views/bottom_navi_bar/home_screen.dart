import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/book_vehicle/book_vehicle_screen.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

import 'package_send/package_send_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  int _current = 0;
  late PageController _pageController;
  bool isPageViewEnabled = false;

  final homeController = Get.find<HomeController>();
  final CarouselController controller = CarouselController();

  List carosalimage = [
    'assets/images/banners.png',
    'assets/images/banners.png',
    'assets/images/banners.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF4F8FF),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/Ellipse 1.png',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: secondoryfont.copyWith(
                                  fontSize: 15.sp, fontWeight: FontWeight.w500),
                            ),
                            //  Obx(()=> Text(homeController.locationvalue.value,
                            //     style: primaryfont.copyWith(
                            //             fontSize: 11,
                            //             fontWeight: FontWeight.w400,
                            //             ),))

                            Text(
                              'Syed',
                              style: primaryfont.copyWith(
                                fontSize: 15.5.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(NotificationView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child:
                            Image.asset('assets/icons/notification_icon.png'),
                      ))
                ],
              ),
              ksizedbox10,
              CarouselSlider(
                items: carosalimage
                    .map((item) => Container(
                        width: 450.0, // Set the width
                        height: 200.0, // Set the height
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(item),
                            fit: BoxFit.fill,
                          ),
                        )))
                    .toList(),
                carouselController: controller,
                options: CarouselOptions(
                    height: 160.h,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 4.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: carosalimage.asMap().entries.map(
                  (entry) {
                    return GestureDetector(
                      onTap: () => controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0.w,
                        height: 12.0.h,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Color(0xffE8E8E8)
                                        : AppColors.kblue)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  },
                ).toList(),
              ),
              ksizedbox10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(PackageSendScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 150.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          color: Color(0xff55208A),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/icons/packageicon.svg'),
                          Text(
                            'Parcel Delivery',
                            style: secondoryfont.copyWith(
                                fontSize: 16.sp,
                                color: AppColors.kwhite,
                                fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(PackageSendScreen());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  color: Color(0xffCDDD13),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Book Now',
                                style: secondoryfont.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(BookVehicleScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 150.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          color: Color(0xffE9027E),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/icons/Group.png'),
                          Text(
                            'Book Vehicle',
                            style: secondoryfont.copyWith(
                                fontSize: 16.sp,
                                color: AppColors.kwhite,
                                fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(PackageSendScreen());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  color: Color(0xffCDDD13),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Book Now',
                                style: secondoryfont.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              ksizedbox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Ongoing Orders',
                        style: primaryfont.copyWith(
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Your Up to Date Details',
                        style: primaryfont.copyWith(
                            fontSize: 11.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Text(
                    'See all',
                    style: primaryfont.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kblue,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              ksizedbox20,
              Container(
                padding: EdgeInsets.only(bottom: 10),
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          offset: Offset(0.0, 0.75),
                          blurRadius: 1,
                          color: AppColors.kgrey)
                    ],
                    color: AppColors.kwhite),
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ongoing Order',
                            style: primaryfont.copyWith(
                                fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Booking ID : #ZAG01',
                            style: primaryfont.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          )
                        ],
                      ),
                      Divider(),
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
                                padding: const EdgeInsets.only(left: 40),
                                child: Text('2:30 PM'),
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
                                padding: const EdgeInsets.only(left: 30),
                                child: Text('2:30 PM'),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ksizedbox10,
            ],
          ),
        ),
      ),
    );
  }
}
