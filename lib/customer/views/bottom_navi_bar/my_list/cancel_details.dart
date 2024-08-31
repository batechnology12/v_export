import 'package:dotted_border/dotted_border.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/model/get_cancelled_orders_model.dart';

class CancelDetails extends StatefulWidget {
  // String driverName;
  // String cancelPickAddress;
  // List<BookingDeliveryVehicleAddress> cancelDropAddress;
  // String bookingId;
  // String pickTime;
  // String deliveryTime;
  GetCancelledOrdersModelData getcancelledDataList;
  CancelDetails({super.key, required this.getcancelledDataList});

  @override
  State<CancelDetails> createState() => _CancelDetalsState();
}

class _CancelDetalsState extends State<CancelDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
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
          'Cancel Details',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xffF4F8FF),
                //  color: Color.fromARGB(255, 235, 232, 232),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   padding: EdgeInsets.only(
                      //       left: 10, right: 10, top: 15, bottom: 5),
                      //   width: size.width,
                      //   decoration: BoxDecoration(
                      //       color: AppColors.kwhite,
                      //       // boxShadow: <BoxShadow>[
                      //       //   BoxShadow(
                      //       //       offset: Offset(0.0, 0.75),
                      //       //       blurRadius: 4,
                      //       //       color: AppColors.kgrey)
                      //       // ],
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Image.asset(
                      //             "assets/icons/Ellipse 26 (1).png",
                      //             height: 50,
                      //             width: 50,
                      //           ),
                      //           SizedBox(
                      //             width: 20.h,
                      //           ),
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 widget.getcancelledDataList.driver!
                      //                     .firstName,
                      //                 style: primaryfont.copyWith(
                      //                     fontWeight: FontWeight.w600,
                      //                     color: Colors.black,
                      //                     fontSize: 17.sp),
                      //               ),
                      //               Text(
                      //                 "Vechcle Driver",
                      //                 style: primaryfont.copyWith(
                      //                     fontWeight: FontWeight.w500,
                      //                     color: Color(0xff455A64),
                      //                     fontSize: 13.sp),
                      //               ),
                      //               Row(
                      //                 children: [
                      //                   const Icon(
                      //                     Icons.star,
                      //                     color: Colors.yellow,
                      //                   ),
                      //                   Ksizedboxw10,
                      //                   Text(
                      //                     "3.5",
                      //                     style: primaryfont.copyWith(
                      //                         fontWeight: FontWeight.w600,
                      //                         color: Colors.black,
                      //                         fontSize: 16.sp),
                      //                   ),
                      //                 ],
                      //               )
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //       Row(
                      //         children: [
                      //           Container(
                      //             margin: EdgeInsets.only(bottom: 15),
                      //             height: 35.h,
                      //             width: 100.w,
                      //             alignment: Alignment.center,
                      //             decoration: BoxDecoration(
                      //                 color: Color(0xffFFBFBF),
                      //                 borderRadius: BorderRadius.circular(5)),
                      //             child: Text(
                      //               'Cancelled',
                      //               style: primaryfont.copyWith(
                      //                   fontWeight: FontWeight.w600,
                      //                   fontSize: 15,
                      //                   color: Color(0xffFF2D55)),
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      ksizedbox10,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.09),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Booking ID : ${widget.getcancelledDataList.bookingId}',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.5),
                                  ),
                                  Container(
                                    //   margin: EdgeInsets.only(bottom: 15),
                                    height: 35.h,
                                    width: 100.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFBFBF),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Cancelled',
                                      style: primaryfont.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Color(0xffFF2D55)),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {},
                                  //   child: Container(
                                  //     height: 35,
                                  //     width: 35,
                                  //     decoration: const BoxDecoration(
                                  //         color: Color(0xffF5F5F5),
                                  //         shape: BoxShape.circle),
                                  //     child: const Icon(
                                  //       Icons.arrow_forward_ios,
                                  //       color: Colors.black,
                                  //       size: 15,
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            Divider(),
                            ksizedbox10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0xff038484),
                                          ),
                                          Dash(
                                              direction: Axis.vertical,
                                              length: 55,
                                              dashLength: 5,
                                              dashColor: AppColors.kgrey),
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
                                          style: primaryfont.copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff455A64)),
                                        ),
                                        Container(
                                          width: 230.h,
                                          child: ExpandableText(
                                            "${widget.getcancelledDataList.senderUnitnoBlockno} ${widget.getcancelledDataList.pickupAddreess}, ${widget.getcancelledDataList.unitno}",
                                            expandText: 'show more',
                                            collapseText: 'show less',
                                            maxLines: 2,
                                            linkColor: Colors.blue,
                                            style: primaryfont.copyWith(
                                                color: const Color(0xff1E1E1E),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                        // ksizedbox5,
                                        // Text(
                                        //   widget.getcancelledDataList
                                        //       .pickuptimeFrom,
                                        //   style: primaryfont.copyWith(
                                        //       fontWeight: FontWeight.w700,
                                        //       fontSize: 13.sp,
                                        //       color: Color(0xff455A64)),
                                        // ),
                                        // ksizedbox5,
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.getcancelledDataList
                                    .bookingDeliveryAddresses.length,
                                itemBuilder: ((context, index) {
                                  BookingDeliveryVehicleAddress
                                      bookingdatalist = widget
                                          .getcancelledDataList
                                          .bookingDeliveryAddresses[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xffF74354),
                                              ),
                                              if (index !=
                                                  widget
                                                          .getcancelledDataList
                                                          .bookingDeliveryAddresses
                                                          .length -
                                                      1)
                                                Dash(
                                                    direction: Axis.vertical,
                                                    length: 50,
                                                    dashLength: 5,
                                                    dashColor: AppColors.kgrey),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Delivery Address',
                                                style: primaryfont.copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff455A64)),
                                              ),
                                              Container(
                                                width: 230.h,
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: ExpandableText(
                                                  "${bookingdatalist.unitnoBlockno}, ${bookingdatalist.address}, ${bookingdatalist.unitno}",
                                                  expandText: 'show more',
                                                  collapseText: 'show less',
                                                  maxLines: 2,
                                                  linkColor: Colors.blue,
                                                  style: primaryfont.copyWith(
                                                      color: const Color(
                                                          0xff1E1E1E),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp),
                                                ),
                                              ),
                                              // ksizedbox5,
                                              // widget.getcancelledDataList
                                              //             .bookingType ==
                                              //         "parcel"
                                              //     ? Text(
                                              //         widget
                                              //             .getcancelledDataList
                                              //             .bookingProducts
                                              //             .first
                                              //             .deliverytimeFrom,
                                              //         // widget.deliveryTime,
                                              //         style:
                                              //             primaryfont.copyWith(
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .w700,
                                              //                 fontSize: 13.sp,
                                              //                 color: Color(
                                              //                     0xff455A64)),
                                              //       )
                                              //     : Container(),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                })),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(bottom: 5),
                      //   width: size.width,
                      //   decoration: BoxDecoration(
                      //       color: AppColors.kwhite,
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 10, right: 10, top: 10),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'Booking ID : ${widget.bookingId}',
                      //               style: primaryfont.copyWith(
                      //                   fontWeight: FontWeight.w700,
                      //                   fontSize: 15.5),
                      //             ),
                      //           ],
                      //         ),
                      //         Divider(),
                      //         ksizedbox10,
                      //         Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             const Column(
                      //               children: [
                      //                 Icon(
                      //                   Icons.location_on,
                      //                   color: Color(0xff038484),
                      //                 ),
                      //                 Dash(
                      //                     direction: Axis.vertical,
                      //                     length: 85,
                      //                     dashLength: 5,
                      //                     dashColor: AppColors.kgrey),
                      //                 Icon(
                      //                   Icons.location_on,
                      //                   color: Color(0xffF74354),
                      //                 ),
                      //               ],
                      //             ),
                      //             SizedBox(
                      //               width: 5.w,
                      //             ),
                      //             Column(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'Pickup Address',
                      //                       style: primaryfont.copyWith(
                      //                           fontSize: 15.sp,
                      //                           fontWeight: FontWeight.w600,
                      //                           color: Color(0xff455A64)),
                      //                     ),
                      //                     Container(
                      //                       width: 230.h,
                      //                       child: ExpandableText(
                      //                         widget.cancelPickAddress,
                      //                         expandText: 'show more',
                      //                         collapseText: 'show less',
                      //                         maxLines: 3,
                      //                         linkColor: Colors.blue,
                      //                         style: primaryfont.copyWith(
                      //                             color:
                      //                                 const Color(0xff1E1E1E),
                      //                             fontWeight: FontWeight.w600,
                      //                             fontSize: 13.sp),
                      //                       ),
                      //                     ),
                      //                     ksizedbox5,
                      //                     Text(
                      //                       widget.pickTime,
                      //                       style: primaryfont.copyWith(
                      //                           fontWeight: FontWeight.w700,
                      //                           fontSize: 13.sp,
                      //                           color: Color(0xff455A64)),
                      //                     )
                      //                   ],
                      //                 ),
                      //                 SizedBox(
                      //                   height: 40.h,
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'Drop Address',
                      //                       style: primaryfont.copyWith(
                      //                           fontSize: 15.sp,
                      //                           fontWeight: FontWeight.w600,
                      //                           color: Color(0xff455A64)),
                      //                     ),
                      //                     Text(
                      //                       '338 Serangoon North ave 6',
                      //                       style: primaryfont.copyWith(
                      //                           color: Color(0xff1E1E1E),
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: 15.sp),
                      //                     ),
                      //                     Text(
                      //                       '2:30 PM',
                      //                       style: primaryfont.copyWith(
                      //                           fontWeight: FontWeight.w700,
                      //                           fontSize: 13.sp,
                      //                           color: Color(0xff455A64)),
                      //                     )
                      //                   ],
                      //                 )
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
