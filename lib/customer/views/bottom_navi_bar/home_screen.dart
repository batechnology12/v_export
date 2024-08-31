import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';
import 'package:expandable_text/expandable_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/booking_status.dart';
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
  PageController pageController = PageController(initialPage: 0);

  bool isPageViewEnabled = false;

  final ParcelController parcelController = Get.put(ParcelController());

  final homeController = Get.put(HomeController());
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  CarouselController controller = Get.put(CarouselController());
  AccountController accountController = Get.put(AccountController());

  List carosalimage = [
    'assets/images/banners.png',
    'assets/images/banners.png',
    'assets/images/banners.png',
  ];

  String formateTimePickAddress = "";
  String formateTimeDropAddress = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    print('getData');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('addPostFrameCallback');
      await homeScreenController.getSlider();
      await parcelController.getonGoingOrders();
      await accountController.getProfile();
      //      await parcelController.getAcceptBooking(parcelController.driverbookingid);
      homeScreenController.update();
      parcelController.update();
      homeController.clearDropLocations();
      homeController.parceldroplocationclear();
      // setState(() {});
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
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Welcome',
                                style: secondoryfont.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
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
                        child: Image.asset(
                          'assets/icons/Group 57.png',
                          height: 20,
                          width: 20,
                        ),
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
                        unitId: "",
                        pickupAdress: "Pickup address...",
                        lat: '',
                        long: '',
                        unitIdBlockID: "",
                        sendername: '',
                        // receivername: '',
                        mobilenumber: '',
                        pickUpPostalCode: "",
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
                        vehiclepickupBlockIDs: "",
                        vehiclepickupsendername: "",
                        vehicleSenderMobilenumber: "",
                        vehiclepickupunitId: "",
                        vehiclePickupPincode: "",
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
                                vehiclepickupBlockIDs: "",
                                vehiclepickupsendername: "",
                                vehicleSenderMobilenumber: "",
                                vehiclepickupunitId: "",
                                vehiclePickupPincode: "",
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
              Container(
                height: 300.h,
                width: size.width,
                // color: Colors.amber,
                child: Image.asset(
                  "assets/icons/3333449.png",
                  fit: BoxFit.cover,
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             Get.to(BookingStatus());
              //           },
              //           child: Text(
              //             'Ongoing Orders',
              //             style: primaryfont.copyWith(
              //                 fontSize: 19.sp, fontWeight: FontWeight.w600),
              //           ),
              //         ),
              //         Text(
              //           'Your Up to Date Details',
              //           style: primaryfont.copyWith(
              //               color: Color(0xff464646),
              //               fontSize: 12.sp,
              //               fontWeight: FontWeight.w500),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // ksizedbox20,
              // Container(
              //   padding: EdgeInsets.only(bottom: 5),
              //   width: size.width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: AppColors.kwhite),
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 7, top: 10),
              //     child: Obx(() {
              //       return parcelController.ongoingorderLoading.isTrue
              //           ? Center(
              //               child: CircularProgressIndicator(
              //               color: AppColors.kblue,
              //             ))
              //           : parcelController.ongoingOrdersData.isEmpty
              //               ? Center(
              //                   child: Container(
              //                       padding: EdgeInsets.only(top: 10),
              //                       alignment: Alignment.center,
              //                       height: 200.h,
              //                       width: size.width,
              //                       decoration: BoxDecoration(
              //                         color: Colors.grey.withOpacity(.09),
              //                         borderRadius: BorderRadius.circular(10),
              //                       ),
              //                       child: Image.asset(
              //                         "assets/images/Group 42002.png",
              //                       )))
              //               : ListView.builder(
              //                   shrinkWrap: true,
              //                   // scrollDirection: Axis.horizontal,
              //                   physics: NeverScrollableScrollPhysics(),
              //                   itemCount:
              //                       parcelController.ongoingOrdersData.length,
              //                   itemBuilder: (context, index) {
              //                     OngoingOrderData order =
              //                         parcelController.ongoingOrdersData[index];
              //                     return GestureDetector(
              //                       onTap: () async {
              //                         if (order.vehicleDetails != null &&
              //                             order.driver != null &&
              //                             order.driver!.latitude != null &&
              //                             order.driver!.longitude != null) {
              //                           try {
              //                             double latitude = double.parse(
              //                                 order.driver!.latitude);
              //                             double longitude = double.parse(
              //                                 order.driver!.longitude);
              //                             Get.to(DriverDetailsScreen(
              //                               getAcceptBookingdata: order,
              //                               initialPosition:
              //                                   LatLng(latitude, longitude),
              //                             ));
              //                           } catch (e) {
              //                             print(
              //                                 "Error parsing latitude/longitude: $e");
              //                           }
              //                         } else {
              //                           // Handle the case where driver or its latitude/longitude is null
              //                           // Handle parsing error
              //                           Get.snackbar(
              //                               "Driver still not accepted your order",
              //                               "",
              //                               colorText: AppColors.kwhite,
              //                               backgroundColor: Colors.red,
              //                               snackPosition:
              //                                   SnackPosition.BOTTOM);
              //                         }
              //                       },
              //                       child: Container(
              //                         decoration: BoxDecoration(
              //                           color: Colors.grey.withOpacity(.09),
              //                           borderRadius: BorderRadius.circular(10),
              //                         ),
              //                         // margin:
              //                         //     EdgeInsets.symmetric(horizontal: 8),
              //                         margin: EdgeInsets.only(bottom: 10),
              //                         child: Column(
              //                           children: [
              //                             Padding(
              //                               padding: const EdgeInsets.only(
              //                                   left: 5, right: 5, top: 5),
              //                               child: Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment
              //                                         .spaceBetween,
              //                                 children: [
              //                                   order.isConfirmed == "0"
              //                                       ? Text(
              //                                           "Pending Order",
              //                                           style: primaryfont
              //                                               .copyWith(
              //                                                   color:
              //                                                       Colors.red,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w700,
              //                                                   fontSize:
              //                                                       13.sp),
              //                                         )
              //                                       : Text(
              //                                           "Ongoing Order",
              //                                           style: primaryfont
              //                                               .copyWith(
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w700,
              //                                                   color: AppColors
              //                                                       .kblue,
              //                                                   fontSize:
              //                                                       13.sp),
              //                                         ),
              //                                   Text(
              //                                     'BookingID :- ${order.bookingId}',
              //                                     style: primaryfont.copyWith(
              //                                         fontWeight:
              //                                             FontWeight.w700,
              //                                         fontSize: 13.sp),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                             Divider(),
              //                             ksizedbox10,
              //                             Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 Row(
              //                                   children: [
              //                                     const Padding(
              //                                       padding:
              //                                           EdgeInsets.only(top: 0),
              //                                       child: Column(
              //                                         children: [
              //                                           Icon(
              //                                             Icons.location_on,
              //                                             color:
              //                                                 Color(0xff038484),
              //                                           ),
              //                                           Dash(
              //                                               direction:
              //                                                   Axis.vertical,
              //                                               length: 30,
              //                                               dashLength: 5,
              //                                               dashColor: AppColors
              //                                                   .kgrey),
              //                                         ],
              //                                       ),
              //                                     ),
              //                                     SizedBox(
              //                                       width: 5.w,
              //                                     ),
              //                                     Column(
              //                                       crossAxisAlignment:
              //                                           CrossAxisAlignment
              //                                               .start,
              //                                       children: [
              //                                         Text(
              //                                           'Pickup Address',
              //                                           style: primaryfont
              //                                               .copyWith(
              //                                                   fontSize: 14.sp,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w600,
              //                                                   color: Color(
              //                                                       0xff455A64)),
              //                                         ),
              //                                         Container(
              //                                           width: 225.h,
              //                                           child: ExpandableText(
              //                                             order.pickupAddreess,
              //                                             expandText:
              //                                                 'show more',
              //                                             collapseText:
              //                                                 'show less',
              //                                             maxLines: 2,
              //                                             linkColor:
              //                                                 Colors.blue,
              //                                             style: primaryfont.copyWith(
              //                                                 color: const Color(
              //                                                     0xff1E1E1E),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontSize: 13.sp),
              //                                           ),
              //                                         ),
              //                                       ],
              //                                     )
              //                                   ],
              //                                 ),
              //                                 Row(
              //                                   children: [
              //                                     Text(
              //                                       order.bookingType ==
              //                                               "parcel"
              //                                           ? "${order.bookingProducts.last.pickuptimeFrom}"
              //                                           //  \nto \n${order.pickuptimeTo}"
              //                                           : order
              //                                               .bookingTimeFromVehicle,
              //                                       textAlign: TextAlign.center,
              //                                       style: primaryfont.copyWith(
              //                                           fontSize: 12.sp,
              //                                           fontWeight:
              //                                               FontWeight.w600,
              //                                           color: const Color(
              //                                               0xff455A64)),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                             GetBuilder<ParcelController>(
              //                                 builder: (_) {
              //                               return ListView.builder(
              //                                   shrinkWrap: true,
              //                                   physics:
              //                                       NeverScrollableScrollPhysics(),
              //                                   itemCount: order
              //                                       .bookingDeliveryAddresses
              //                                       .length,
              //                                   itemBuilder: ((context, index) {
              //                                     var bookingDeliveryAddress =
              //                                         order.bookingDeliveryAddresses[
              //                                             index];
              //                                     var bookingProduct = order
              //                                         .bookingProducts.last;
              //                                     return Row(
              //                                       mainAxisAlignment:
              //                                           MainAxisAlignment
              //                                               .spaceBetween,
              //                                       children: [
              //                                         Row(
              //                                           crossAxisAlignment:
              //                                               CrossAxisAlignment
              //                                                   .start,
              //                                           children: [
              //                                             Column(
              //                                               children: [
              //                                                 const Icon(
              //                                                   Icons
              //                                                       .location_on,
              //                                                   color: Color(
              //                                                       0xffF74354),
              //                                                 ),
              //                                                 if (index !=
              //                                                     order.bookingDeliveryAddresses
              //                                                             .length -
              //                                                         1)
              //                                                   const Dash(
              //                                                       direction: Axis
              //                                                           .vertical,
              //                                                       length: 30,
              //                                                       dashLength:
              //                                                           5,
              //                                                       dashColor:
              //                                                           AppColors
              //                                                               .kgrey)
              //                                                 // else
              //                                                 //   SizedBox(
              //                                                 //       height:
              //                                                 //           20.h),
              //                                               ],
              //                                             ),
              //                                             // SizedBox(
              //                                             //   width: 5.w,
              //                                             // ),
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
              //                                                   width: 225.h,
              //                                                   padding: EdgeInsets
              //                                                       .only(
              //                                                           bottom:
              //                                                               0),
              //                                                   child:
              //                                                       ExpandableText(
              //                                                     bookingDeliveryAddress
              //                                                         .address,
              //                                                     expandText:
              //                                                         'show more',
              //                                                     collapseText:
              //                                                         'show less',
              //                                                     maxLines: 2,
              //                                                     linkColor:
              //                                                         Colors
              //                                                             .blue,
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
              //                                             order.bookingType ==
              //                                                     "parcel"
              //                                                 ? Text(
              //                                                     "${bookingProduct.deliverytimeTo}",
              //                                                     textAlign:
              //                                                         TextAlign
              //                                                             .center,
              //                                                     style: primaryfont.copyWith(
              //                                                         fontSize:
              //                                                             12.sp,
              //                                                         fontWeight:
              //                                                             FontWeight
              //                                                                 .w600,
              //                                                         color: const Color(
              //                                                             0xff455A64)),
              //                                                   )
              //                                                 : Container(),
              //                                           ],
              //                                         )
              //                                       ],
              //                                     );
              //                                   }));
              //                             }),
              //                             Container(
              //                               alignment: Alignment.center,
              //                               height: 35.h,
              //                               width: size.width,
              //                               decoration: const BoxDecoration(
              //                                 color: AppColors.kblue,
              //                                 borderRadius: BorderRadius.only(
              //                                     bottomLeft:
              //                                         Radius.circular(10),
              //                                     bottomRight:
              //                                         Radius.circular(10)),
              //                               ),
              //                               child: Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.center,
              //                                 children: [
              //                                   Text(
              //                                     order.bookingType == "parcel"
              //                                         ? "Parcel Delivery"
              //                                         : "Vehicle Booking",
              //                                     style: primaryfont.copyWith(
              //                                         fontSize: 14.sp,
              //                                         fontWeight:
              //                                             FontWeight.w600,
              //                                         color: Colors.white),
              //                                   ),
              //                                   Ksizedboxw10,
              //                                   order.bookingType == "parcel"
              //                                       ? Padding(
              //                                           padding:
              //                                               const EdgeInsets
              //                                                   .all(9.0),
              //                                           child: SvgPicture.asset(
              //                                               "assets/icons/parceItem.svg"),
              //                                         )
              //                                       : Padding(
              //                                           padding:
              //                                               const EdgeInsets
              //                                                   .all(9.0),
              //                                           child: Image.asset(
              //                                             "assets/images/delivery-man.png",
              //                                             color: Colors.white,
              //                                           ),
              //                                         )
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                 );
              //     }),
              //   ),
              // ),
              ksizedbox10,
            ],
          ),
        ),
      ),
    );
  }
}
