import 'package:date_format/date_format.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/model/get_completed_orders_model.dart';
import 'package:v_export/customer/model/get_ongoing_orders_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/booking_status.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/complete_details.dart';
import 'package:intl/intl.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_rating.dart';

class GetCompletedScreenData extends StatefulWidget {
  const GetCompletedScreenData({super.key});

  @override
  State<GetCompletedScreenData> createState() => _GetCompletedScreenDataState();
}

class _GetCompletedScreenDataState extends State<GetCompletedScreenData> {
  @override
  void initState() {
    super.initState();
    myListController.getCompletedOrdersUser("completed");
  }

  MyListController myListController = Get.put(MyListController());

  // String formatTime(String time) {
  //   DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
  //   String formattedTime = DateFormat("h a").format(parsedTime);
  //   return formattedTime;
  // }

  String formatTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);

      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          GetBuilder<MyListController>(builder: (_) {
            if (myListController.getCompletedOrdersLoading.isTrue) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 230),
                child: CircularProgressIndicator(),
              ));
            }
            if (myListController.getCompletedOrdersModelData.isEmpty) {
              return Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 200),
                      alignment: Alignment.center,
                      height: 200.h,
                      width: size.width,
                      decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(.09),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset("assets/images/Group 42002.png")));
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: myListController.getCompletedOrdersModelData.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  GetCompletedOrdersModelData getCompletedDatalist =
                      myListController.getCompletedOrdersModelData[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        //     Get.to(DriverRating(
                        //   bookingID:
                        //   getCompletedDatalist.
                        //      // parcelController.driverRatingBookingID.value ?? "",
                        // ));
                        // Get.to(CompleteDetails(
                        //     getCompletedData: getCompletedDatalist));
                      },
                      child: Container(
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
                                    'Booking ID : ${getCompletedDatalist.bookingId}',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.5),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            ksizedbox10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Color(0xff038484),
                                    ),
                                    Dash(
                                        direction: Axis.vertical,
                                        length: 50,
                                        dashLength: 5,
                                        dashColor: AppColors.kgrey),
                                  ],
                                ),
                                Ksizedboxw10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 310.w,
                                      // color: Colors.amber,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Pickup Address',
                                                style: primaryfont.copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff455A64)),
                                              ),
                                            ],
                                          ),
                                          getCompletedDatalist.bookingType ==
                                                  "vehicle"
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      getCompletedDatalist
                                                          .bookingTimeFromVehicle!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0xff455A64)),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      getCompletedDatalist
                                                          .pickuptimeFrom,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0xff455A64)),
                                                    ),
                                                    Text(
                                                      " to ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0xff455A64)),
                                                    ),
                                                    Text(
                                                      getCompletedDatalist
                                                          .pickuptimeTo,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0xff455A64)),
                                                    ),
                                                  ],
                                                )
                                        ],
                                      ),
                                    ),
                                    Text(getCompletedDatalist.pickupAddreess,
                                        style: primaryfont.copyWith(
                                            color: const Color(0xff1E1E1E),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp)),
                                  ],
                                ),
                              ],
                            ),
                            GetBuilder<MyListController>(builder: (_) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: getCompletedDatalist
                                      .bookingDeliveryAddresses.length,
                                  itemBuilder: ((context, index) {
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
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Color(0xffF74354),
                                                ),
                                                if (index !=
                                                    getCompletedDatalist
                                                            .bookingDeliveryAddresses
                                                            .length -
                                                        1)
                                                  const Dash(
                                                      direction: Axis.vertical,
                                                      length: 50,
                                                      dashLength: 5,
                                                      dashColor:
                                                          AppColors.kgrey),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 315.w,
                                                  // color: Colors.amber,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Delivery Address',
                                                            style: primaryfont.copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          // getCompletedDatalist.bookingType ==
                                                          //         "parcel"
                                                          //     ?
                                                          Text(
                                                            getCompletedDatalist
                                                                        .bookingType ==
                                                                    "parcel"
                                                                ? '${getCompletedDatalist.bookingProducts[index].deliverytimeFrom} to ${getCompletedDatalist.bookingProducts[index].deliverytimeTo}'
                                                                : getCompletedDatalist
                                                                    .bookingDeliveryAddresses[
                                                                        index]
                                                                    .deliveryAt,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: primaryfont.copyWith(
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: const Color(
                                                                    0xff455A64)),
                                                          ),
                                                          // : Container(),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 225.h,
                                                  // color: Colors.amber,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Text(
                                                      getCompletedDatalist
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
                                                              fontSize: 12.sp)),

                                                  // ExpandableText(
                                                  //   "${getCompletedDatalist.bookingDeliveryAddresses[index].address}",
                                                  //   expandText: 'show more',
                                                  //   collapseText: 'show less',
                                                  //   maxLines: 2,
                                                  //   linkColor: Colors.blue,
                                                  //   style: primaryfont.copyWith(
                                                  //       color: const Color(
                                                  //           0xff1E1E1E),
                                                  //       fontWeight:
                                                  //           FontWeight.w600,
                                                  //       fontSize: 12.sp),
                                                  // ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  }));
                            }),
                            ksizedbox10,
                            Divider(),
                            ksizedbox10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 65.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pickup Date',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        formatDate(
                                            DateTime.parse(getCompletedDatalist
                                                .bookingDate
                                                .toString()),
                                            [dd, '-', mm, '-', yyyy]),
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                      )
                                    ],
                                  ),
                                ),
                                getCompletedDatalist.bookingType == "parcel"
                                    ? Container(
                                        height: 65.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Delivery Date',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                              getCompletedDatalist
                                                  .bookingProducts[0]
                                                  .deliveryDate,
                                              style: primaryfont.copyWith(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  height: 65.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadius.circular(15.sp)),
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
                                        height: 2.h,
                                      ),
                                      Text(
                                        'Delivered',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff009200)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          }),
        ],
      ),
    );
  }
}
