import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';
import 'package:expandable_text/expandable_text.dart';

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
import 'package:v_export/customer/model/onGoing_order_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/book_vehicle/book_vehicle_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_about_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_details_screen.dart';
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

  late ParcelController parcelController;

  final homeController = Get.find<HomeController>();
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  final CarouselController controller = Get.find<CarouselController>();
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
    parcelController = Get.find<ParcelController>();
    print('ParcelController: $parcelController');
    _pageController = PageController(initialPage: 0);
    getData();
  }

  Future<void> getData() async {
    print('getData');
    //WidgetsBinding.instance.addPostFrameCallback((_) async {
    print('addPostFrameCallback');
    await homeScreenController.getSlider();
    await parcelController.getonGoingOrders();
    await accountController.getProfile();
    //     await parcelController.getAcceptBooking(parcelController.driverbookingid);
    homeScreenController.update();
    parcelController.update();
    setState(() {});
    //});
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
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                            GetBuilder<AccountController>(
                              builder: (_) {
                                return accountController.imageLoading.value
                                    ? Text("")
                                    : Text(
                                        accountController.getUserData == null
                                            ? ""
                                            : accountController
                                                .getUserData!.data.firstName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                              },
                            ),
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
                        pickupAdress: "Pickup address",
                        lat: '',
                        long: '',
                        unitIdBlockID: "",
                        sendername: '',
                        // receivername: '',
                        mobilenumber: '',
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
                          Container(
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
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(BookVehicleScreen(
                        vehiclepickupAdress: "PickUp Address",
                        vehiclepickuplat: "",
                        vehiclepickuplong: "",
                        vehiclepickupunitIdBlockID: "",
                        vehiclepickupsendername: "",
                        vehicleSenderMobilenumber: "",
                      ));
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
                            'Book Vehicle',
                            style: secondoryfont.copyWith(
                                fontSize: 16.sp,
                                color: AppColors.kwhite,
                                fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(BookVehicleScreen(
                                vehiclepickupAdress: "PickUp Address",
                                vehiclepickuplat: "",
                                vehiclepickuplong: "",
                                vehiclepickupunitIdBlockID: "",
                                vehiclepickupsendername: "",
                                vehicleSenderMobilenumber: "",
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
                  )
                ],
              ),
              ksizedbox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      ),
                    ],
                  ),
                ],
              ),
              ksizedbox20,

              // Container(
              //   padding: EdgeInsets.only(bottom: 5),
              //   width: size.width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: AppColors.kwhite),
              //   child: Padding(
              //       padding: EdgeInsets.only(left: 7, top: 10),
              //       child: GetBuilder<ParcelController>(builder: (_) {
              //         return parcelController.ongoingorderLoading.isTrue
              //             ? Center(
              //                 child: CircularProgressIndicator(
              //                 color: AppColors.kblue,
              //               ))
              //             : parcelController.ongoingOrdersData.isEmpty
              //                 ? Center(
              //                     child: Container(
              //                         alignment: Alignment.center,
              //                         height: 200.h,
              //                         width: size.width,
              //                         decoration: BoxDecoration(
              //                           color: Colors.grey.withOpacity(.09),
              //                           borderRadius: BorderRadius.circular(10),
              //                         ),
              //                         child: Image.asset(
              //                             "assets/images/Group 42002.png")))
              //                 : Container(
              //                     decoration: BoxDecoration(
              //                       color: Colors.grey.withOpacity(.09),
              //                       borderRadius: BorderRadius.circular(10),
              //                     ),
              //                     margin: EdgeInsets.only(bottom: 10),
              //                     child: Column(
              //                       children: [
              //                         Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 5),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               parcelController.ongoingOrdersData
              //                                           .first.isConfirmed ==
              //                                       "0"
              //                                   ? Text(
              //                                       "Pending Order",
              //                                       style: primaryfont.copyWith(
              //                                           color: Colors.red,
              //                                           fontWeight:
              //                                               FontWeight.w700,
              //                                           fontSize: 15.sp),
              //                                     )
              //                                   : Text(
              //                                       "Ongoing Order",
              //                                       style: primaryfont.copyWith(
              //                                           fontWeight:
              //                                               FontWeight.w700,
              //                                           color: AppColors.kblue,
              //                                           fontSize: 15.sp),
              //                                     ),
              //                               Text(
              //                                 'BookingID :- ${parcelController.ongoingOrdersData.first.bookingId}',
              //                                 style: primaryfont.copyWith(
              //                                     fontWeight: FontWeight.w700,
              //                                     fontSize: 15.sp),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(),
              //                         ksizedbox10,
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 const Column(
              //                                   children: [
              //                                     Icon(
              //                                       Icons.location_on,
              //                                       color: Color(0xff038484),
              //                                     ),
              //                                     Dash(
              //                                         direction: Axis.vertical,
              //                                         length: 55,
              //                                         dashLength: 5,
              //                                         dashColor:
              //                                             AppColors.kgrey),
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   width: 5.w,
              //                                 ),
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       'Pickup Address',
              //                                       style: primaryfont.copyWith(
              //                                           fontSize: 14.sp,
              //                                           fontWeight:
              //                                               FontWeight.w600,
              //                                           color:
              //                                               Color(0xff455A64)),
              //                                     ),
              //                                     Container(
              //                                       width: 230.h,
              //                                       child: Text(
              //                                         parcelController
              //                                             .ongoingOrdersData
              //                                             .first
              //                                             .pickupAddreess,

              //                                         //   "jdj",
              //                                         style:
              //                                             primaryfont.copyWith(
              //                                                 color: const Color(
              //                                                     0xff1E1E1E),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontSize: 13.sp),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                             Row(
              //                               children: [
              //                                 Text(
              //                                   //   "chjsdhvbhds ",
              //                                   parcelController
              //                                               .ongoingOrdersData
              //                                               .first
              //                                               .bookingType ==
              //                                           "parcel"
              //                                       ? "${parcelController.ongoingOrdersData.first.bookingProducts.first.pickuptimeFrom} \nto \n${parcelController.ongoingOrdersData.first.pickuptimeTo}"
              //                                       : parcelController
              //                                           .ongoingOrdersData
              //                                           .first
              //                                           .bookingTimeFromVehicle,
              //                                   textAlign: TextAlign.center,
              //                                   style: primaryfont.copyWith(
              //                                       fontSize: 12.sp,
              //                                       fontWeight: FontWeight.w600,
              //                                       color: const Color(
              //                                           0xff455A64)),
              //                                 ),
              //                               ],
              //                             )
              //                           ],
              //                         ),
              //                         GetBuilder<ParcelController>(
              //                             builder: (_) {
              //                           return parcelController
              //                                   .ongoingOrdersData.isEmpty
              //                               ? Center(
              //                                   child: Container(
              //                                       alignment: Alignment.center,
              //                                       height: 200.h,
              //                                       width: size.width,
              //                                       decoration: BoxDecoration(
              //                                         color: Colors.grey
              //                                             .withOpacity(.09),
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 10),
              //                                       ),
              //                                       child: Image.asset(
              //                                         "assets/images/Group 42002.png",
              //                                         height: 20,
              //                                         width: 20,
              //                                       )))
              //                               :
              // ListView.builder(
              //                                   shrinkWrap: true,
              //                                   physics:
              //                                       NeverScrollableScrollPhysics(),
              //                                   itemCount:
              //                                       //3,
              //                                       parcelController
              //                                           .ongoingOrdersData
              //                                           .length,
              //                                   padding:
              //                                       EdgeInsets.only(top: 10),
              //                                   itemBuilder: ((context, index) {
              //                                     OngoingOrderData
              //                                         ongoingorderList =
              //                                         parcelController
              //                                                 .ongoingOrdersData[
              //                                             index];
              //                                     // BookingDeliveryAddress
              //                                     //     bookingDeliveryAddress =
              //                                     //     ongoingorderList
              //                                     //             .bookingDeliveryAddresses[
              //                                     //         index];
              //                                     // BookingProduct bookingProduct =
              //                                     //     ongoingorderList
              //                                     //         .bookingProducts[index];
              //                                     return Row(
              //                                       mainAxisAlignment:
              //                                           MainAxisAlignment
              //                                               .spaceBetween,
              //                                       children: [
              //                                         Row(
              //                                           children: [
              //                                             const Column(
              //                                               children: [
              //                                                 Icon(
              //                                                   Icons
              //                                                       .location_on,
              //                                                   color: Color(
              //                                                       0xffF74354),
              //                                                 ),
              //                                                 Dash(
              //                                                     direction: Axis
              //                                                         .vertical,
              //                                                     length: 75,
              //                                                     dashLength: 5,
              //                                                     dashColor:
              //                                                         AppColors
              //                                                             .kgrey),
              //                                               ],
              //                                             ),
              //                                             SizedBox(
              //                                               width: 5.w,
              //                                             ),
              //                                             Column(
              //                                               crossAxisAlignment:
              //                                                   CrossAxisAlignment
              //                                                       .start,
              //                                               children: [
              //                                                 Text(
              //                                                   'Delivery Address',
              //                                                   style: primaryfont.copyWith(
              //                                                       fontSize:
              //                                                           14.sp,
              //                                                       fontWeight:
              //                                                           FontWeight
              //                                                               .w600,
              //                                                       color: Color(
              //                                                           0xff455A64)),
              //                                                 ),
              //                                                 Container(
              //                                                   width: 230.h,
              //                                                   padding: EdgeInsets
              //                                                       .only(
              //                                                           bottom:
              //                                                               20),
              //                                                   child: Text(
              //                                                     ongoingorderList
              //                                                         .bookingDeliveryAddresses[
              //                                                             index]
              //                                                         .address,

              //                                                     // bookingDeliveryAddress
              //                                                     //     .address,
              //                                                     style: primaryfont.copyWith(
              //                                                         color: const Color(
              //                                                             0xff1E1E1E),
              //                                                         fontWeight:
              //                                                             FontWeight
              //                                                                 .w600,
              //                                                         fontSize:
              //                                                             13.sp),
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             )
              //                                           ],
              //                                         ),
              //                                         Row(
              //                                           children: [
              //                                             Text(
              //                                               // ongoingorderList
              //                                               //             .bookingType ==
              //                                               //         "parcel"
              //                                               //     ? "${ongoingorderList.bookingProducts[index].deliverytimeFrom} \nto \n${ongoingorderList.bookingProducts[index].deliverytimeTo}"
              //                                               //     : ongoingorderList
              //                                               //         .bookingTimeFromVehicle,
              //                                               "ycgsjhab",
              //                                               textAlign: TextAlign
              //                                                   .center,
              //                                               style: primaryfont.copyWith(
              //                                                   fontSize: 12.sp,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w600,
              //                                                   color: const Color(
              //                                                       0xff455A64)),
              //                                             ),
              //                                           ],
              //                                         )
              //                                       ],
              //                                     );
              //                                   }));
              //                         }),
              //                         Container(
              //                           alignment: Alignment.center,
              //                           height: 45.h,
              //                           width: size.width,
              //                           decoration: const BoxDecoration(
              //                               color: AppColors.kblue,
              //                               borderRadius: BorderRadius.only(
              //                                   bottomLeft: Radius.circular(20),
              //                                   bottomRight:
              //                                       Radius.circular(20))),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                             children: [
              //                               Text(
              //                                 //    "nndsv ands ",
              //                                 parcelController.ongoingOrdersData
              //                                             .first.bookingType ==
              //                                         "parcel"
              //                                     ? "Parcel Delivery"
              //                                     : "Book Vehicle",
              //                                 style: primaryfont.copyWith(
              //                                     fontSize: 14.sp,
              //                                     fontWeight: FontWeight.w600,
              //                                     color: Colors.white),
              //                               ),
              //                               Ksizedboxw10,
              //                               parcelController.ongoingOrdersData
              //                                           .first.bookingType ==
              //                                       "parcel"
              //                                   ? Padding(
              //                                       padding:
              //                                           const EdgeInsets.all(
              //                                               9.0),
              //                                       child: Image.asset(
              //                                         "assets/images/delivery-man.png",
              //                                         color: Colors.white,
              //                                       ),
              //                                     )
              //                                   : Padding(
              //                                       padding:
              //                                           const EdgeInsets.all(
              //                                               13.0),
              //                                       child: Image.asset(
              //                                           "assets/images/Group (5).png"),
              //                                     ),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   );
              //       })),
              // ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.kwhite),
                child: Padding(
                    padding: EdgeInsets.only(left: 7, top: 10),
                    child: Obx(() {
                      return parcelController.ongoingorderLoading.isTrue
                          ? Center(
                              child: CircularProgressIndicator(
                              color: AppColors.kblue,
                            ))
                          : parcelController.ongoingOrdersData.isEmpty
                              ? Center(
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 200.h,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.09),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                          "assets/images/Group 42002.png")))
                              : GestureDetector(
                                  onTap: () {
                                    //  Get.to(DriverDetailsScreen());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.09),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              parcelController.ongoingOrdersData
                                                          .last.isConfirmed ==
                                                      "0"
                                                  ? Text(
                                                      "Pending Order",
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 15.sp),
                                                    )
                                                  : Text(
                                                      "Ongoing Order",
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .kblue,
                                                              fontSize: 15.sp),
                                                    ),
                                              //   Text("dskjsdjkjs"),
                                              Text(
                                                'BookingID :- ${parcelController.ongoingOrdersData.last.bookingId}',
                                                //  "efhjadvhjbadjkv",
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        ksizedbox10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 0),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xff038484),
                                                      ),
                                                      Dash(
                                                          direction:
                                                              Axis.vertical,
                                                          length: 55,
                                                          dashLength: 5,
                                                          dashColor:
                                                              AppColors.kgrey),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Pickup Address',
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    Container(
                                                      width: 230.h,
                                                      child: ExpandableText(
                                                        parcelController
                                                            .ongoingOrdersData
                                                            .last
                                                            .pickupAddreess,
                                                        expandText: 'show more',
                                                        collapseText:
                                                            'show less',
                                                        maxLines: 3,
                                                        linkColor: Colors.blue,
                                                        style: primaryfont
                                                            .copyWith(
                                                                color: const Color(
                                                                    0xff1E1E1E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    13.sp),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  //  "chjsdhvbhds ",
                                                  parcelController
                                                              .ongoingOrdersData
                                                              .last
                                                              .bookingType ==
                                                          "parcel"
                                                      ? "${parcelController.ongoingOrdersData.last.bookingProducts.last.pickuptimeFrom} \nto \n${parcelController.ongoingOrdersData.last.pickuptimeTo}"
                                                      : parcelController
                                                          .ongoingOrdersData
                                                          .last
                                                          .bookingTimeFromVehicle,
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
                                        GetBuilder<ParcelController>(
                                            builder: (_) {
                                          return parcelController
                                                  .ongoingOrdersData.isEmpty
                                              ? Center(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 200.h,
                                                      width: size.width,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(.09),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/Group 42002.png",
                                                        height: 20,
                                                        width: 20,
                                                      )))
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: parcelController
                                                      .ongoingOrdersData
                                                      .last
                                                      .bookingDeliveryAddresses
                                                      .length,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    OngoingOrderData
                                                        ongoingorderList =
                                                        parcelController
                                                            .ongoingOrdersData
                                                            .last;

                                                    BookingDeliveryAddress
                                                        bookingDeliveryAddress =
                                                        ongoingorderList
                                                                .bookingDeliveryAddresses[
                                                            index];
                                                    BookingProduct
                                                        bookingProduct =
                                                        ongoingorderList
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
                                                                Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Color(
                                                                      0xffF74354),
                                                                ),
                                                                Dash(
                                                                    direction: Axis
                                                                        .vertical,
                                                                    length: 75,
                                                                    dashLength:
                                                                        5,
                                                                    dashColor:
                                                                        AppColors
                                                                            .kgrey),
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
                                                                  width: 230.h,
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
                                                                    maxLines: 3,
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
                                                                            13.sp),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              // "fjkabjsk v jkd",
                                                              ongoingorderList
                                                                          .bookingType ==
                                                                      "parcel"
                                                                  ? "${bookingProduct.deliverytimeFrom} \nto \n${bookingProduct.deliverytimeTo}"
                                                                  : ongoingorderList
                                                                      .bookingTimeFromVehicle,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      12.sp,
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
                                                  }));
                                        }),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 45.h,
                                          width: size.width,
                                          decoration: const BoxDecoration(
                                              color: AppColors.kblue,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                //   "nndsv ands ",
                                                parcelController
                                                            .ongoingOrdersData
                                                            .last
                                                            .bookingType ==
                                                        "parcel"
                                                    ? "Parcel Delivery"
                                                    : "vehicle Booking",
                                                style: primaryfont.copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              Ksizedboxw10,
                                              parcelController.ongoingOrdersData
                                                          .last.bookingType ==
                                                      "parcel"
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              9.0),
                                                      child: Image.asset(
                                                        "assets/images/delivery-man.png",
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              13.0),
                                                      child: SvgPicture.asset(
                                                          "assets/icons/parceItem.svg"),
                                                      // Image.asset(
                                                      //     "assets/images/Group (5).png"),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
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
