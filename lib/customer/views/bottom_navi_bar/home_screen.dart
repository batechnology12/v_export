import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/home_screen_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
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
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  ParcelController parcelController = Get.find<ParcelController>();
  final CarouselController controller = CarouselController();
  AccountController accountController = Get.find<AccountController>();

  List carosalimage = [
    'assets/images/banners.png',
    'assets/images/banners.png',
    'assets/images/banners.png',
  ];

  String formateTimePickAddress = "";
  String formateTimeDropAddress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeScreenController.getSlider();
      await parcelController.getonGoingOrders();
      homeScreenController.update();
    });
  }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    //String formattedTime = DateFormat("h m a").format(parsedTime);
    String formattedTime = DateFormat("HH:mm:a").format(parsedTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF4F8FF),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          child: accountController.getUserData == null
                              ? Image.asset(
                                  "assets/icons/Ellipse 26.png",
                                  fit: BoxFit.cover,
                                )
                              : accountController.getUserData!.data.imageUrl ==
                                      ""
                                  ? Image.asset("assets/icons/Ellipse 26.png")
                                  : accountController
                                          .editProfilePictureLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Image.network(
                                          accountController
                                              .getUserData!.data.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                        ),
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
              Obx(() {
                return homeScreenController.sliderLoading.isTrue
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 20.w,
                            height: 170.h,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade300,
                              child: Container(
                                width: 20.0,
                                height: 170.0,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300.w,
                            height: 170.h,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.white,
                              child: Container(
                                width: 300.0,
                                height: 170.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                            height: 170.h,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade300,
                              child: Container(
                                width: 20.0,
                                height: 170.0,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                              ),
                            ),
                          ),
                        ],
                      )
                    : CarouselSlider(
                        items: homeScreenController.sliderData
                            .map((item) => ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    width: 450.0,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Image.network(
                                      item.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
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
                      );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: homeScreenController.sliderData.asMap().entries.map(
                  (entry) {
                    return GestureDetector(
                      onTap: () => controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0.w,
                        height: 12.0.h,
                        margin: const EdgeInsets.symmetric(
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
                      Get.to(PackageSendScreen(
                        pickupAdress: "pickup address",
                        lat: '',
                        long: '',
                        unitIdBlockID: [""],
                      ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 160.h,
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
                              Get.to(PackageSendScreen(
                                pickupAdress: "pickup",
                                lat: '',
                                long: '',
                                unitIdBlockID: [""],
                              ));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  color: Color(0xffCDDD13),
                                  borderRadius: BorderRadius.circular(6)),
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
                      height: 160.h,
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
                            'Moving Vehicle',
                            style: secondoryfont.copyWith(
                                fontSize: 16.sp,
                                color: AppColors.kwhite,
                                fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(BookVehicleScreen());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  color: Color(0xffCDDD13),
                                  borderRadius: BorderRadius.circular(6)),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ongoing Orders',
                        style: primaryfont.copyWith(
                            fontSize: 19.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Your Up to Date Details',
                        style: primaryfont.copyWith(
                            color: Color(0xff464646),
                            fontSize: 12.sp,
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
                padding: EdgeInsets.only(bottom: 5),
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.kwhite),
                child: Padding(
                    padding: EdgeInsets.only(left: 7, right: 7, top: 10),
                    child: GetBuilder<ParcelController>(builder: (_) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: parcelController.ongoingOrdersData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.09),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ongoing Order',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        parcelController
                                            .ongoingOrdersData[index].bookingId,
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp),
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  ksizedbox10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xff038484),
                                              ),
                                              Dash(
                                                  direction: Axis.vertical,
                                                  length: 60,
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff455A64)),
                                                  ),
                                                  Container(
                                                    width: 250.h,
                                                    child: Text(
                                                      // parcelController
                                                      //     .ongoingOrdersData[
                                                      //         index]
                                                      //     .fromAddress
                                                      //     .first
                                                      //     .address,
                                                      "338C Anchorvale Cresen",
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: const Color(
                                                                  0xff1E1E1E),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp),
                                                    ),
                                                  ),
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff455A64)),
                                                  ),
                                                  Container(
                                                    width: 250.h,
                                                    child: Text(
                                                      parcelController
                                                          .ongoingOrdersData[
                                                              index]
                                                          .bookingDeliveryAddresses[
                                                              index]
                                                          .address,
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: const Color(
                                                                  0xff1E1E1E),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: size.height * .12,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  // formateTimePickAddress =
                                                  //     formatDate(
                                                  //         parcelController
                                                  //             .ongoingOrdersData[
                                                  //                 index].bookingProducts[index].deliverytimeFrom.toString()
                                                  //            ,
                                                  //         [
                                                  //       HH,
                                                  //       ':',
                                                  //       nn,
                                                  //       " ",
                                                  //       am
                                                  //     ]),
                                                  '${formatTime(parcelController.ongoingOrdersData[index].bookingProducts[index].pickuptimeFrom)}',
                                                  style: primaryfont.copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xff455A64)),
                                                ),
                                                Text(
                                                  '${formatTime(parcelController.ongoingOrdersData[index].bookingProducts[index].deliverytimeFrom)}',
                                                  style: primaryfont.copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff455A64)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  ksizedbox10,
                                ],
                              ),
                            );
                          });
                    })),
              ),
              ksizedbox10,
            ],
          ),
        ),
      ),
    );
  }
}
