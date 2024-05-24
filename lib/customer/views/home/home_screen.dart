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
import 'package:v_export/customer/views/home/book_vehicle/book_vehicle_screen.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

import 'package_send/package_send_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  late PageController _pageController;
  bool isPageViewEnabled = false;

  final homeController = Get.find<HomeController>();
  final CarouselController controller = CarouselController();

  List carosalimage = [
    SvgPicture.asset('assets/images/carolsliderimage.svg'),
    SvgPicture.asset('assets/images/carolsliderimage.svg'),
    SvgPicture.asset('assets/images/carolsliderimage.svg'),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/location_icon.svg',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pick up from',
                              style: secondoryfont.copyWith(
                                  fontSize: 15.sp, 
                                  fontWeight: FontWeight.w500),
                            ),
                            //  Obx(()=> Text(homeController.locationvalue.value,
                            //     style: primaryfont.copyWith(
                            //             fontSize: 11,
                            //             fontWeight: FontWeight.w400,
                            //             ),))

                            Text(
                              'Nungambakkam,Chennai',
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
                    onTap: (){
                      Get.to(NotificationView());
                    },
                    child: Image.asset('assets/icons/notification_icon.png'))
                ],
              ),
              ksizedbox30,
              CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  height: 130,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  initialPage: 0,
                  reverse: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
                items: [
                  Stack(children: [
                    InkWell(
                        onTap: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.decelerate,
                          );
                        },
                        child: SvgPicture.asset(
                            'assets/images/carolsliderimage.svg')),
                    Positioned(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Book Your Truck',
                                style: secondoryfont.copyWith(
                                    color: AppColors.kwhite,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'easy to send a your \norder any place ',
                                style: secondoryfont.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.kwhite,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Container(
                                  height: 30.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xff000B95),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'Book Now',
                                      style: secondoryfont.copyWith(
                                          color: AppColors.kwhite,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/images/carolslidercontainerimage.svg',
                            height: 71,
                            fit: BoxFit.fitHeight,
                          )
                        ],
                      ),
                    ))
                  ]),
                  Stack(children: [
                    InkWell(
                      onTap: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/carolsliderimage.svg',
                        color: Color(0xffFF0835),
                      ),
                    ),
                    Positioned(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Book Your Truck',
                                style: secondoryfont.copyWith(
                                    color: AppColors.kwhite,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'easy to send a your \norder any place ',
                                style: secondoryfont.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.kwhite,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Container(
                                  height: 30.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xff000B95),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'Book Now',
                                      style: secondoryfont.copyWith(
                                          color: AppColors.kwhite,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/images/carolslidercontainerimage.svg',
                            height: 71,
                            fit: BoxFit.fitHeight,
                          )
                        ],
                      ),
                    ))
                  ]),
                  Stack(children: [
                    SvgPicture.asset(
                      'assets/images/carolsliderimage.svg',
                      color: Colors.deepPurpleAccent,
                    ),
                    Positioned(
                      top: 15,
                      left: 15,
                      right: 15,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Book Your Truck',
                                  style: secondoryfont.copyWith(
                                      color: AppColors.kwhite,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'easy to send a your \norder any place ',
                                  style: secondoryfont.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColors.kwhite,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                    height: 30.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                        color: Color(0xff000B95),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Book Now',
                                        style: secondoryfont.copyWith(
                                            color: AppColors.kwhite,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SvgPicture.asset(
                              'assets/images/carolslidercontainerimage.svg',
                              height: 71,
                              fit: BoxFit.fitHeight,
                            )
                          ],
                        ))
                  ])
                ],
              ),
              ksizedbox5,
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 3,
                effect: ScaleEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: AppColors.kblue),
              ),
              ksizedbox30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(PackageSendScreen());
                    },
                    child: Container(
                      height: 132.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                          color: Color(0xff55208A),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          ksizedbox10,
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child:
                                SvgPicture.asset('assets/icons/packageicon.svg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Package \nSend',
                                  style: secondoryfont.copyWith(
                                      fontSize: 16.sp,
                                      color: AppColors.kwhite,
                                      fontWeight: FontWeight.w700),
                                ),
                             
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                                 InkWell(
                                  onTap: () {
                                    Get.to(PackageSendScreen());
                                  },
                                   child: Container(
                                    height: 23.h,
                                    width: 42.w,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))
                                    ),
                                    child: Center(
                                      child: Icon(Icons.arrow_forward,
                                      color: AppColors.kwhite,
                                      size: 20,),
                                    ),
                                                                   ),
                                 )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(BookVehicleScreen());
                    },
                    child: Container(
                      height: 132.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                          color: Color(0xffE9027E),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          ksizedbox10,
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: SvgPicture.asset(
                              'assets/icons/vehicleicon.svg',
                              height: 60.h,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 1),
                            child: Row(
                              children: [
                                Text(
                                  'Book \nVehicle',
                                  style: secondoryfont.copyWith(
                                      fontSize: 16.sp,
                                      color: AppColors.kwhite,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                                 InkWell(
                                  onTap: (){
                                    Get.to(BookVehicleScreen());
                                  },
                                   child: Container(
                                    height: 23.h,
                                    width: 42.w,
                                    decoration: BoxDecoration(
                                      color: Color(0xff9A0555),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))
                                    ),
                                    child: Center(
                                      child: Icon(Icons.arrow_forward,
                                      color: AppColors.kwhite,
                                      size: 20.sp,),
                                    ),
                                                                   ),
                                 )
                            ],
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
                            fontSize: 17.sp, 
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Your Up to Date Details',
                        style: primaryfont.copyWith(
                            fontSize: 11.sp,
                             fontWeight: FontWeight.w500),
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
                height: 200,
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
                                fontSize: 16.sp, 
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Booking ID : #ZAG01',
                            style: primaryfont.copyWith(
                                fontWeight: FontWeight.w600, 
                                fontSize: 14.sp),
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
                                   Text('Pickup Address',
                                    style: primaryfont.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff455A64)
                                    ),),
                                    Text('338C Anchorvale Cresent',
                                    style: primaryfont.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp
                                    ),)
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
                                        Text('Delivery Address',
                                        style: primaryfont.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff455A64)
                                        ),),
                                      ],
                                    ),
                                 
                                     Text('338 Serangoon North ave 6',
                                    style: primaryfont.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp
                                    ),)
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
