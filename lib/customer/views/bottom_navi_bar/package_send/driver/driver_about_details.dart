import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/model/onGoing_order_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_message.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class DriverAboutDetails extends StatefulWidget {
  OngoingOrderData getAcceptBookingdata;
  DriverAboutDetails({super.key, required this.getAcceptBookingdata});

  @override
  State<DriverAboutDetails> createState() => _DriverAboutDetailsState();
}

class _DriverAboutDetailsState extends State<DriverAboutDetails> {
  List helpCentre = ["About", "Review"];

  void launchWhatsApp(String phoneNumber, String message) async {
    final formattedNumber =
        phoneNumber.startsWith('+65') ? phoneNumber : '+65$phoneNumber';
    final link = WhatsAppUnilink(
      phoneNumber: formattedNumber,
      text: message,
    );
    // Convert the WhatsAppUnilink instance to a Uri.
    // The "launch" method is part of "url_launcher".
    await launch(link.asUri().toString());
  }

  _callNumber({required String phonenumber}) async {
    await FlutterPhoneDirectCaller.callNumber(phonenumber);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.kblue,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(330.h),
          child: Column(
            children: [
              AppBar(
                backgroundColor: AppColors.kblue,
                title: Text(
                  'Driver Details',
                  style: primaryfont.copyWith(
                      fontSize: 19.sp,
                      color: AppColors.kwhite,
                      fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: AppColors.kwhite,
                  ),
                ),
              ),
              ksizedbox20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/Ellipse 26.png",
                      height: 90,
                      width: 90,
                    ),
                    Ksizedboxw10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.getAcceptBookingdata.driver!.fullName,
                          style: primaryfont.copyWith(
                              fontSize: 23.sp,
                              color: AppColors.kwhite,
                              fontWeight: FontWeight.w600),
                        ),
                        ksizedbox5,
                        Text(
                          widget.getAcceptBookingdata.driver!.email,
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.kwhite,
                              fontWeight: FontWeight.w500),
                        ),
                        ksizedbox5,
                        Text(
                          "Chennai",
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.kwhite,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ksizedbox10,
              Divider(
                color: Colors.white.withOpacity(.68),
              ),
              ksizedbox10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: const BoxDecoration(
                            color: Color(0xffF6F6F6),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                              "assets/icons/Group (1).png",
                            ))),
                      ),
                      ksizedbox5,
                      Text(
                        '7500+',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Customer',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: const BoxDecoration(
                            color: Color(0xffF6F6F6),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                              "assets/icons/Group 55.png",
                            ))),
                      ),
                      ksizedbox5,
                      Text(
                        '10+',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Years,Exp',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: const BoxDecoration(
                            color: Color(0xffF6F6F6),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                              "assets/icons/star.png",
                            ))),
                      ),
                      ksizedbox5,
                      Text(
                        '4.9',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Rating',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: const BoxDecoration(
                            color: Color(0xffF6F6F6),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                              "assets/icons/msg.png",
                            ))),
                      ),
                      ksizedbox5,
                      Text(
                        '4560',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Review',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.kwhite,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Color(0xff9E9E9E),
                indicatorColor: AppColors.kblue,
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 4.0,
                      color: AppColors.kblue,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 90.0)),
                tabs: [
                  Tab(
                    child: Text(
                      "About",
                      style: primaryfont.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Review",
                      style: primaryfont.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
                child: Container(
              color: Colors.white,
              child: TabBarView(children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ksizedbox20,
                      Text(
                        "About",
                        style: primaryfont.copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                      ksizedbox10,
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since...",
                        style: primaryfont.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      ksizedbox20,
                      Text(
                        "Driver Contact",
                        style: primaryfont.copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/driverprofile.png'),
                              Ksizedboxw10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget
                                        .getAcceptBookingdata.driver!.fullName,
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.5),
                                  ),
                                  Text(
                                    widget.getAcceptBookingdata.vehicleType,
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  launchWhatsApp(
                                      widget.getAcceptBookingdata.driver!.phone,
                                      "Hi Captan");
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 45.w,
                                  child: SvgPicture.asset(
                                    'assets/icons/Layer 2.svg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Ksizedboxw10,
                              GestureDetector(
                                onTap: () {
                                  Get.to(DriverMessage());
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 45.w,
                                  child: SvgPicture.asset(
                                    'assets/icons/Group 50.svg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Ksizedboxw10,
                              InkWell(
                                onTap: () {
                                  _callNumber(
                                      phonenumber: widget
                                          .getAcceptBookingdata.driver!.phone);
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 45.w,
                                  child: SvgPicture.asset(
                                    'assets/icons/Group 42029.svg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      ksizedbox20,
                      Text(
                        "Vechicle  Details",
                        style: primaryfont.copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.getAcceptBookingdata.vehicleType == "Bike"
                                ? "Bike Model"
                                : widget.getAcceptBookingdata.vehicleType ==
                                        "car"
                                    ? "Car Model"
                                    : "van Model",
                            style: primaryfont.copyWith(
                                fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            widget.getAcceptBookingdata.vehicleDetails!
                                .vehicleModel,
                            style: primaryfont.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff455A64),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.getAcceptBookingdata.vehicleType == "Bike"
                                ? "Bike Number"
                                : widget.getAcceptBookingdata.vehicleType ==
                                        "car"
                                    ? "Car Number"
                                    : "van Number",
// widget.getAcceptBookingdata.vehicleType =="Bike" ?
//                             "Bike Number":widget.getAcceptBookingdata.vehicleType =="car":"Bike Number":"van",
                            style: primaryfont.copyWith(
                                fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            widget.getAcceptBookingdata.vehicleDetails!
                                .vehicleNumber,
                            style: primaryfont.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff455A64),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ksizedbox20,
                      Text(
                        "Review",
                        style: primaryfont.copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                      ksizedbox20,
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              height: 150.h,
                              width: size.width,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.w,
                                            child: Image.asset(
                                                "assets/icons/Ellipse 26.png"),
                                          ),
                                          Ksizedboxw10,
                                          Text(
                                            "Wasim",
                                            style: primaryfont.copyWith(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "11 Months ago",
                                            style: primaryfont.copyWith(
                                                color: const Color(0xff455A64),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  ksizedbox5,
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since...",
                                    style: primaryfont.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Divider(
                                    color: Colors.black.withOpacity(.20),
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                )
              ]),
            ))

            //  Container(
            //   width: double.infinity,
            //   height: size.height,
            //   decoration: const BoxDecoration(color: AppColors.kblue),
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         Container(
            //           height: 310.h,
            //           padding: EdgeInsets.only(top: 40.h, left: 15, right: 15),
            //           child: Column(
            //             children: [],
            //           ),
            //         ),
            //         ksizedbox10,
            //         Container(
            //           height: size.height,
            //           width: size.width,
            //           decoration: const BoxDecoration(
            //               color: AppColors.kwhite,
            //               borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(17),
            //                   topRight: Radius.circular(17))),
            //           child: Padding(
            //               padding: const EdgeInsets.only(right: 15, left: 15),
            //               child: DefaultTabController(
            //                 length: 2,
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       padding: EdgeInsets.symmetric(horizontal: 10),
            //                       height: 50.h,
            //                       color: Colors.white,
            //                       child: TabBar(
            //                         labelColor: Colors.blue,
            //                         unselectedLabelColor: Color(0xff9E9E9E),
            //                         indicatorColor: AppColors.kblue,
            //                         indicator: const UnderlineTabIndicator(
            //                             borderSide: BorderSide(
            //                               width: 4.0,
            //                               color: AppColors.kblue,
            //                             ),
            //                             insets:
            //                                 EdgeInsets.symmetric(horizontal: 100.0)),
            //                         tabs: [
            //                           Tab(
            //                             child: Text(
            //                               "About",
            //                               style: primaryfont.copyWith(
            //                                   fontSize: 16.sp,
            //                                   fontWeight: FontWeight.w600),
            //                             ),
            //                           ),
            //                           Tab(
            //                             child: Text(
            //                               "Review",
            //                               style: primaryfont.copyWith(
            //                                   fontSize: 16.sp,
            //                                   fontWeight: FontWeight.w600),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     Expanded(
            //                         child: Container(
            //                       height: 100.h,
            //                       child: TabBarView(
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               ksizedbox20,
            //                               Text(
            //                                 "About",
            //                                 style: primaryfont.copyWith(
            //                                     fontSize: 18.sp,
            //                                     fontWeight: FontWeight.w700),
            //                               ),
            //                               ksizedbox10,
            //                               Text(
            //                                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since...",
            //                                 style: primaryfont.copyWith(
            //                                     fontSize: 16.sp,
            //                                     fontWeight: FontWeight.w500),
            //                               ),
            //                               ksizedbox20,
            //                               Text(
            //                                 "Driver Contact",
            //                                 style: primaryfont.copyWith(
            //                                     fontSize: 18.sp,
            //                                     fontWeight: FontWeight.w700),
            //                               ),
            //                               ksizedbox10,
            //                               Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Row(
            //                                     children: [
            //                                       Image.asset(
            //                                           'assets/images/driverprofile.png'),
            //                                       Ksizedboxw10,
            //                                       Column(
            //                                         crossAxisAlignment:
            //                                             CrossAxisAlignment.start,
            //                                         children: [
            //                                           Text(
            //                                             'Lee Wong',
            //                                             style: primaryfont.copyWith(
            //                                                 fontWeight:
            //                                                     FontWeight.w600,
            //                                                 fontSize: 15.5),
            //                                           ),
            //                                           Text(
            //                                             'Two wheeler',
            //                                             style: primaryfont.copyWith(
            //                                                 fontWeight:
            //                                                     FontWeight.w500),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   Row(
            //                                     children: [
            //                                       Image.asset(
            //                                           'assets/icons/Layer 2.png'),
            //                                       Ksizedboxw10,
            //                                       GestureDetector(
            //                                         onTap: () {
            //                                           Get.to(DriverMessage());
            //                                         },
            //                                         child: Image.asset(
            //                                             'assets/icons/Group 50.png'),
            //                                       ),
            //                                       Ksizedboxw10,
            //                                       Image.asset(
            //                                           'assets/icons/Group 42029.png'),
            //                                     ],
            //                                   )
            //                                 ],
            //                               ),
            //                               ksizedbox20,
            //                               Text(
            //                                 "Vechicle  Details",
            //                                 style: primaryfont.copyWith(
            //                                     fontSize: 18.sp,
            //                                     fontWeight: FontWeight.w700),
            //                               ),
            //                               ksizedbox10,
            //                               Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text(
            //                                     "Bike Model",
            //                                     style: primaryfont.copyWith(
            //                                         fontSize: 18.sp,
            //                                         fontWeight: FontWeight.w700),
            //                                   ),
            //                                   Text(
            //                                     "Tata Ace Closed",
            //                                     style: primaryfont.copyWith(
            //                                         fontSize: 12.sp,
            //                                         color: Color(0xff455A64),
            //                                         fontWeight: FontWeight.w500),
            //                                   ),
            //                                 ],
            //                               ),
            //                               ksizedbox10,
            //                               Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text(
            //                                     "Bike Number",
            //                                     style: primaryfont.copyWith(
            //                                         fontSize: 18.sp,
            //                                         fontWeight: FontWeight.w700),
            //                                   ),
            //                                   Text(
            //                                     "TN-22-X-2101",
            //                                     style: primaryfont.copyWith(
            //                                         fontSize: 12.sp,
            //                                         color: Color(0xff455A64),
            //                                         fontWeight: FontWeight.w500),
            //                                   ),
            //                                 ],
            //                               )
            //                             ],
            //                           ),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               ksizedbox20,
            //                               Text(
            //                                 "Review",
            //                                 style: primaryfont.copyWith(
            //                                     fontSize: 18.sp,
            //                                     fontWeight: FontWeight.w700),
            //                               ),
            //                               ListView.builder(
            //                                   shrinkWrap: true,
            //                                   itemCount: 3,
            //                                   itemBuilder: (context, index) {
            //                                     return Container(
            //                                       margin: EdgeInsets.only(bottom: 5),
            //                                       height: 150.h,
            //                                       width: size.width,
            //                                       child: Column(
            //                                         children: [
            //                                           Row(
            //                                             mainAxisAlignment:
            //                                                 MainAxisAlignment
            //                                                     .spaceBetween,
            //                                             children: [
            //                                               Row(
            //                                                 children: [
            //                                                   Container(
            //                                                     height: 50.h,
            //                                                     width: 50.w,
            //                                                     child: Image.asset(
            //                                                         "assets/icons/Ellipse 26.png"),
            //                                                   ),
            //                                                   Ksizedboxw10,
            //                                                   Text(
            //                                                     "Wasim",
            //                                                     style: primaryfont
            //                                                         .copyWith(
            //                                                             fontSize:
            //                                                                 17.sp,
            //                                                             fontWeight:
            //                                                                 FontWeight
            //                                                                     .w600),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                               Row(
            //                                                 children: [
            //                                                   Text(
            //                                                     "11 Months ago",
            //                                                     style: primaryfont.copyWith(
            //                                                         color: const Color(
            //                                                             0xff455A64),
            //                                                         fontSize: 13.sp,
            //                                                         fontWeight:
            //                                                             FontWeight
            //                                                                 .w500),
            //                                                   ),
            //                                                 ],
            //                                               )
            //                                             ],
            //                                           ),
            //                                           ksizedbox5,
            //                                           Text(
            //                                             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since...",
            //                                             style: primaryfont.copyWith(
            //                                                 fontSize: 13.sp,
            //                                                 fontWeight:
            //                                                     FontWeight.w500),
            //                                           ),
            //                                           Divider(
            //                                             color: Colors.black
            //                                                 .withOpacity(.20),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                     );
            //                                   })
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ))
            //                   ],
            //                 ),
            //               )),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}






// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:svg_flutter/svg_flutter.dart';
// import 'package:v_export/constant/app_colors.dart';
// import 'package:v_export/constant/app_font.dart';
// import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_message.dart';

// class DriverAboutDetails extends StatefulWidget {
//   const DriverAboutDetails({super.key});

//   @override
//   State<DriverAboutDetails> createState() => _DriverAboutDetailsState();
// }

// class _DriverAboutDetailsState extends State<DriverAboutDetails> {
//   List helpCentre = ["About", "Review"];
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         backgroundColor: AppColors.kblue,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(330.h),
//           child: Column(
//             children: [
//               AppBar(
//                 backgroundColor: AppColors.kblue,
//                 title: Text(
//                   'Driver Details',
//                   style: primaryfont.copyWith(
//                       fontSize: 19.sp,
//                       color: AppColors.kwhite,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 centerTitle: true,
//                 leading: InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Icon(
//                     Icons.arrow_back_ios_new_sharp,
//                     color: AppColors.kwhite,
//                   ),
//                 ),
//               ),
//               ksizedbox20,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   children: [
//                     Image.asset(
//                       "assets/icons/Ellipse 26.png",
//                       height: 90,
//                       width: 90,
//                     ),
//                     Ksizedboxw10,
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Lee Wong',
//                           style: primaryfont.copyWith(
//                               fontSize: 23.sp,
//                               color: AppColors.kwhite,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         ksizedbox5,
//                         Text(
//                           'example@gmail.com',
//                           style: primaryfont.copyWith(
//                               fontSize: 14.sp,
//                               color: AppColors.kwhite,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         ksizedbox5,
//                         Text(
//                           'New York, United State',
//                           style: primaryfont.copyWith(
//                               fontSize: 14.sp,
//                               color: AppColors.kwhite,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               ksizedbox10,
//               Divider(
//                 color: Colors.white.withOpacity(.68),
//               ),
//               ksizedbox10,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         height: 60.h,
//                         width: 60.w,
//                         decoration: const BoxDecoration(
//                             color: Color(0xffF6F6F6),
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: AssetImage(
//                               "assets/icons/Group (1).png",
//                             ))),
//                       ),
//                       ksizedbox5,
//                       Text(
//                         '7500+',
//                         style: primaryfont.copyWith(
//                             fontSize: 14.sp,
//                             color: AppColors.kwhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         'Customer',
//                         style: primaryfont.copyWith(
//                             fontSize: 14.sp,
//                             color: AppColors.kwhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         height: 60.h,
//                         width: 60.w,
//                         decoration: const BoxDecoration(
//                             color: Color(0xffF6F6F6),
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: AssetImage(
//                               "assets/icons/Group 55.png",
//                             ))),
//                       ),
//                       ksizedbox5,
//                       Text(
//                         '10+',
//                         style: primaryfont.copyWith(
//                             fontSize: 14.sp,
//                             color: AppColors.kwhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         'Years,Exp',
//                         style: primaryfont.copyWith(
//                             fontSize: 14.sp,
//                             color: AppColors.kwhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         height: 60.h,
//                         width: 60.w,
//                         decoration: const BoxDecoration(
//                             color: Color(0xffF6F6F6),
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: AssetImage(
//                               "assets/icons/star.png",
//                             ))),
//                       ),
//                       ksizedbox5,
//                       Text(
//                         '4.9',
//                         style: primaryfont.copyWith(
//                             fontSize: 14.sp,
//                             color: AppColors.kwhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         'Rating',
//                         style: primaryfont.copyWith(
//                             fontSize: 14.sp,
//                             color: AppColors.kwhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         height: 60.h,
//                         width: 60.w,
//                         decoration: const BoxDecoration(
//                             color: Color(0xffF6F6F6),
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: AssetImage(
//                               "assets/icons/msg.png",
//                             ))),
//                       ),
//                       ksizedbox5,
//                       Text(
//                         '4560',
//                         style: primaryfont.copyWith(
//                             fontSize: 14.sp,
//                             color: AppColors.kwhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         'Review',
//                         style: primaryfont.copyWith(
//                             fontSize: 14.sp,
//                             color: AppColors.kwhite,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 5),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: TabBar(
//                 labelColor: Colors.blue,
//                 unselectedLabelColor: Color(0xff9E9E9E),
//                 indicatorColor: AppColors.kblue,
//                 indicator: const UnderlineTabIndicator(
//                     borderSide: BorderSide(
//                       width: 4.0,
//                       color: AppColors.kblue,
//                     ),
//                     insets: EdgeInsets.symmetric(horizontal: 90.0)),
//                 tabs: [
//                   Tab(
//                     child: Text(
//                       "About",
//                       style: primaryfont.copyWith(
//                           fontSize: 16.sp, fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                   Tab(
//                     child: Text(
//                       "Review",
//                       style: primaryfont.copyWith(
//                           fontSize: 16.sp, fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Expanded(
//                 child: Container(
//               color: Colors.white,
//               child: TabBarView(children: [
//                 SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   padding: const EdgeInsets.only(right: 15, left: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ksizedbox20,
//                       Text(
//                         "About",
//                         style: primaryfont.copyWith(
//                             fontSize: 18.sp, fontWeight: FontWeight.w700),
//                       ),
//                       ksizedbox10,
//                       Text(
//                         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since...",
//                         style: primaryfont.copyWith(
//                             fontSize: 16.sp, fontWeight: FontWeight.w500),
//                       ),
//                       ksizedbox20,
//                       Text(
//                         "Driver Contact",
//                         style: primaryfont.copyWith(
//                             fontSize: 18.sp, fontWeight: FontWeight.w700),
//                       ),
//                       ksizedbox10,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Image.asset('assets/images/driverprofile.png'),
//                               Ksizedboxw10,
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Lee Wong',
//                                     style: primaryfont.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 15.5),
//                                   ),
//                                   Text(
//                                     'Two wheeler',
//                                     style: primaryfont.copyWith(
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 height: 45.h,
//                                 width: 45.w,
//                                 child: SvgPicture.asset(
//                                   'assets/icons/Layer 2.svg',
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                               Ksizedboxw10,
//                               GestureDetector(
//                                 onTap: () {
//                                   Get.to(DriverMessage());
//                                 },
//                                 child: Container(
//                                   height: 45.h,
//                                   width: 45.w,
//                                   child: SvgPicture.asset(
//                                     'assets/icons/Group 50.svg',
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                               ),
//                               Ksizedboxw10,
//                               Container(
//                                 height: 45.h,
//                                 width: 45.w,
//                                 child: SvgPicture.asset(
//                                   'assets/icons/Group 42029.svg',
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       ksizedbox20,
//                       Text(
//                         "Vechicle  Details",
//                         style: primaryfont.copyWith(
//                             fontSize: 18.sp, fontWeight: FontWeight.w700),
//                       ),
//                       ksizedbox10,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Bike Model",
//                             style: primaryfont.copyWith(
//                                 fontSize: 18.sp, fontWeight: FontWeight.w700),
//                           ),
//                           Text(
//                             "Tata Ace Closed",
//                             style: primaryfont.copyWith(
//                                 fontSize: 12.sp,
//                                 color: Color(0xff455A64),
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                       ksizedbox10,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Bike Number",
//                             style: primaryfont.copyWith(
//                                 fontSize: 18.sp, fontWeight: FontWeight.w700),
//                           ),
//                           Text(
//                             "TN-22-X-2101",
//                             style: primaryfont.copyWith(
//                                 fontSize: 12.sp,
//                                 color: Color(0xff455A64),
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   padding: EdgeInsets.only(left: 10, right: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ksizedbox20,
//                       Text(
//                         "Review",
//                         style: primaryfont.copyWith(
//                             fontSize: 18.sp, fontWeight: FontWeight.w700),
//                       ),
//                       ksizedbox20,
//                       ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: 10,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: EdgeInsets.only(bottom: 5),
//                               height: 150.h,
//                               width: size.width,
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Container(
//                                             height: 50.h,
//                                             width: 50.w,
//                                             child: Image.asset(
//                                                 "assets/icons/Ellipse 26.png"),
//                                           ),
//                                           Ksizedboxw10,
//                                           Text(
//                                             "Wasim",
//                                             style: primaryfont.copyWith(
//                                                 fontSize: 17.sp,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             "11 Months ago",
//                                             style: primaryfont.copyWith(
//                                                 color: const Color(0xff455A64),
//                                                 fontSize: 13.sp,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   ksizedbox5,
//                                   Text(
//                                     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since...",
//                                     style: primaryfont.copyWith(
//                                         fontSize: 13.sp,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   Divider(
//                                     color: Colors.black.withOpacity(.20),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           })
//                     ],
//                   ),
//                 )
//               ]),
//             ))

//             //  Container(
//             //   width: double.infinity,
//             //   height: size.height,
//             //   decoration: const BoxDecoration(color: AppColors.kblue),
//             //   child: SingleChildScrollView(
//             //     child: Column(
//             //       children: [
//             //         Container(
//             //           height: 310.h,
//             //           padding: EdgeInsets.only(top: 40.h, left: 15, right: 15),
//             //           child: Column(
//             //             children: [],
//             //           ),
//             //         ),
//             //         ksizedbox10,
//             //         Container(
//             //           height: size.height,
//             //           width: size.width,
//             //           decoration: const BoxDecoration(
//             //               color: AppColors.kwhite,
//             //               borderRadius: BorderRadius.only(
//             //                   topLeft: Radius.circular(17),
//             //                   topRight: Radius.circular(17))),
//             //           child: Padding(
//             //               padding: const EdgeInsets.only(right: 15, left: 15),
//             //               child: DefaultTabController(
//             //                 length: 2,
//             //                 child: Column(
//             //                   children: [
//             //                     Container(
//             //                       padding: EdgeInsets.symmetric(horizontal: 10),
//             //                       height: 50.h,
//             //                       color: Colors.white,
//             //                       child: TabBar(
//             //                         labelColor: Colors.blue,
//             //                         unselectedLabelColor: Color(0xff9E9E9E),
//             //                         indicatorColor: AppColors.kblue,
//             //                         indicator: const UnderlineTabIndicator(
//             //                             borderSide: BorderSide(
//             //                               width: 4.0,
//             //                               color: AppColors.kblue,
//             //                             ),
//             //                             insets:
//             //                                 EdgeInsets.symmetric(horizontal: 100.0)),
//             //                         tabs: [
//             //                           Tab(
//             //                             child: Text(
//             //                               "About",
//             //                               style: primaryfont.copyWith(
//             //                                   fontSize: 16.sp,
//             //                                   fontWeight: FontWeight.w600),
//             //                             ),
//             //                           ),
//             //                           Tab(
//             //                             child: Text(
//             //                               "Review",
//             //                               style: primaryfont.copyWith(
//             //                                   fontSize: 16.sp,
//             //                                   fontWeight: FontWeight.w600),
//             //                             ),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                     Expanded(
//             //                         child: Container(
//             //                       height: 100.h,
//             //                       child: TabBarView(
//             //                         children: [
//             //                           Column(
//             //                             crossAxisAlignment: CrossAxisAlignment.start,
//             //                             children: [
//             //                               ksizedbox20,
//             //                               Text(
//             //                                 "About",
//             //                                 style: primaryfont.copyWith(
//             //                                     fontSize: 18.sp,
//             //                                     fontWeight: FontWeight.w700),
//             //                               ),
//             //                               ksizedbox10,
//             //                               Text(
//             //                                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since...",
//             //                                 style: primaryfont.copyWith(
//             //                                     fontSize: 16.sp,
//             //                                     fontWeight: FontWeight.w500),
//             //                               ),
//             //                               ksizedbox20,
//             //                               Text(
//             //                                 "Driver Contact",
//             //                                 style: primaryfont.copyWith(
//             //                                     fontSize: 18.sp,
//             //                                     fontWeight: FontWeight.w700),
//             //                               ),
//             //                               ksizedbox10,
//             //                               Row(
//             //                                 mainAxisAlignment:
//             //                                     MainAxisAlignment.spaceBetween,
//             //                                 children: [
//             //                                   Row(
//             //                                     children: [
//             //                                       Image.asset(
//             //                                           'assets/images/driverprofile.png'),
//             //                                       Ksizedboxw10,
//             //                                       Column(
//             //                                         crossAxisAlignment:
//             //                                             CrossAxisAlignment.start,
//             //                                         children: [
//             //                                           Text(
//             //                                             'Lee Wong',
//             //                                             style: primaryfont.copyWith(
//             //                                                 fontWeight:
//             //                                                     FontWeight.w600,
//             //                                                 fontSize: 15.5),
//             //                                           ),
//             //                                           Text(
//             //                                             'Two wheeler',
//             //                                             style: primaryfont.copyWith(
//             //                                                 fontWeight:
//             //                                                     FontWeight.w500),
//             //                                           ),
//             //                                         ],
//             //                                       ),
//             //                                     ],
//             //                                   ),
//             //                                   Row(
//             //                                     children: [
//             //                                       Image.asset(
//             //                                           'assets/icons/Layer 2.png'),
//             //                                       Ksizedboxw10,
//             //                                       GestureDetector(
//             //                                         onTap: () {
//             //                                           Get.to(DriverMessage());
//             //                                         },
//             //                                         child: Image.asset(
//             //                                             'assets/icons/Group 50.png'),
//             //                                       ),
//             //                                       Ksizedboxw10,
//             //                                       Image.asset(
//             //                                           'assets/icons/Group 42029.png'),
//             //                                     ],
//             //                                   )
//             //                                 ],
//             //                               ),
//             //                               ksizedbox20,
//             //                               Text(
//             //                                 "Vechicle  Details",
//             //                                 style: primaryfont.copyWith(
//             //                                     fontSize: 18.sp,
//             //                                     fontWeight: FontWeight.w700),
//             //                               ),
//             //                               ksizedbox10,
//             //                               Row(
//             //                                 mainAxisAlignment:
//             //                                     MainAxisAlignment.spaceBetween,
//             //                                 children: [
//             //                                   Text(
//             //                                     "Bike Model",
//             //                                     style: primaryfont.copyWith(
//             //                                         fontSize: 18.sp,
//             //                                         fontWeight: FontWeight.w700),
//             //                                   ),
//             //                                   Text(
//             //                                     "Tata Ace Closed",
//             //                                     style: primaryfont.copyWith(
//             //                                         fontSize: 12.sp,
//             //                                         color: Color(0xff455A64),
//             //                                         fontWeight: FontWeight.w500),
//             //                                   ),
//             //                                 ],
//             //                               ),
//             //                               ksizedbox10,
//             //                               Row(
//             //                                 mainAxisAlignment:
//             //                                     MainAxisAlignment.spaceBetween,
//             //                                 children: [
//             //                                   Text(
//             //                                     "Bike Number",
//             //                                     style: primaryfont.copyWith(
//             //                                         fontSize: 18.sp,
//             //                                         fontWeight: FontWeight.w700),
//             //                                   ),
//             //                                   Text(
//             //                                     "TN-22-X-2101",
//             //                                     style: primaryfont.copyWith(
//             //                                         fontSize: 12.sp,
//             //                                         color: Color(0xff455A64),
//             //                                         fontWeight: FontWeight.w500),
//             //                                   ),
//             //                                 ],
//             //                               )
//             //                             ],
//             //                           ),
//             //                           Column(
//             //                             crossAxisAlignment: CrossAxisAlignment.start,
//             //                             children: [
//             //                               ksizedbox20,
//             //                               Text(
//             //                                 "Review",
//             //                                 style: primaryfont.copyWith(
//             //                                     fontSize: 18.sp,
//             //                                     fontWeight: FontWeight.w700),
//             //                               ),
//             //                               ListView.builder(
//             //                                   shrinkWrap: true,
//             //                                   itemCount: 3,
//             //                                   itemBuilder: (context, index) {
//             //                                     return Container(
//             //                                       margin: EdgeInsets.only(bottom: 5),
//             //                                       height: 150.h,
//             //                                       width: size.width,
//             //                                       child: Column(
//             //                                         children: [
//             //                                           Row(
//             //                                             mainAxisAlignment:
//             //                                                 MainAxisAlignment
//             //                                                     .spaceBetween,
//             //                                             children: [
//             //                                               Row(
//             //                                                 children: [
//             //                                                   Container(
//             //                                                     height: 50.h,
//             //                                                     width: 50.w,
//             //                                                     child: Image.asset(
//             //                                                         "assets/icons/Ellipse 26.png"),
//             //                                                   ),
//             //                                                   Ksizedboxw10,
//             //                                                   Text(
//             //                                                     "Wasim",
//             //                                                     style: primaryfont
//             //                                                         .copyWith(
//             //                                                             fontSize:
//             //                                                                 17.sp,
//             //                                                             fontWeight:
//             //                                                                 FontWeight
//             //                                                                     .w600),
//             //                                                   ),
//             //                                                 ],
//             //                                               ),
//             //                                               Row(
//             //                                                 children: [
//             //                                                   Text(
//             //                                                     "11 Months ago",
//             //                                                     style: primaryfont.copyWith(
//             //                                                         color: const Color(
//             //                                                             0xff455A64),
//             //                                                         fontSize: 13.sp,
//             //                                                         fontWeight:
//             //                                                             FontWeight
//             //                                                                 .w500),
//             //                                                   ),
//             //                                                 ],
//             //                                               )
//             //                                             ],
//             //                                           ),
//             //                                           ksizedbox5,
//             //                                           Text(
//             //                                             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since...",
//             //                                             style: primaryfont.copyWith(
//             //                                                 fontSize: 13.sp,
//             //                                                 fontWeight:
//             //                                                     FontWeight.w500),
//             //                                           ),
//             //                                           Divider(
//             //                                             color: Colors.black
//             //                                                 .withOpacity(.20),
//             //                                           ),
//             //                                         ],
//             //                                       ),
//             //                                     );
//             //                                   })
//             //                             ],
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ))
//             //                   ],
//             //                 ),
//             //               )),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
