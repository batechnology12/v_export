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
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/get_ongoing_orders_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/booking_status.dart';
import 'package:intl/intl.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/driver_details_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/ongoing_driver_details_screen.dart';

class GetOngoingScreenData extends StatefulWidget {
  const GetOngoingScreenData({super.key});

  @override
  State<GetOngoingScreenData> createState() => _GetOngoingScreenDataState();
}

class _GetOngoingScreenDataState extends State<GetOngoingScreenData> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      myListController.getOngoingOrdersUser("ongoing");
      myListController.update();
      setState(() {});
    });
  }

  MyListController myListController = Get.put(MyListController());
  ParcelController parcelController = Get.put(ParcelController());

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
            if (myListController.getOngoingOrdersLoading.isTrue) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 230),
                child: CircularProgressIndicator(
                  color: AppColors.kblue,
                ),
              ));
            }
            if (myListController.getOngoingOrdersModelData.isEmpty) {
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
                itemCount: myListController.getOngoingOrdersModelData.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  GetOngoingOrdersModelData getongoingdatalist =
                      myListController.getOngoingOrdersModelData[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(OngoingDriverDetailsScreen(
                            getOngoingOrdersModelDataList: getongoingdatalist));
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Booking ID : ${getongoingdatalist.bookingId}',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.sp),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(OngoingDriverDetailsScreen(
                                          getOngoingOrdersModelDataList:
                                              getongoingdatalist));
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: const BoxDecoration(
                                          // color: Colors.amber,
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
                            // ksizedbox10,
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
                                          getongoingdatalist.bookingType ==
                                                  "vehicle"
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      getongoingdatalist
                                                          .bookingTimeFromVehicle!,
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      getongoingdatalist
                                                          .bookingProducts
                                                          .first
                                                          .pickuptimeFrom,
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    Text(
                                                      " to ",
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                    Text(
                                                      getongoingdatalist
                                                          .bookingProducts
                                                          .first
                                                          .pickuptimeTo,
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xff455A64)),
                                                    ),
                                                  ],
                                                )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      getongoingdatalist.pickupAddreess,
                                      style: primaryfont.copyWith(
                                          color: const Color(0xff1E1E1E),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GetBuilder<MyListController>(builder: (_) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: getongoingdatalist
                                      .bookingDeliveryAddresses.length,
                                  itemBuilder: ((context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                getongoingdatalist
                                                        .bookingDeliveryAddresses
                                                        .length -
                                                    1)
                                              const Dash(
                                                  direction: Axis.vertical,
                                                  length: 50,
                                                  dashLength: 5,
                                                  dashColor: AppColors.kgrey),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 310.w,
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
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff455A64)),
                                                      ),
                                                    ],
                                                  ),
                                                  getongoingdatalist
                                                              .bookingType ==
                                                          "vehicle"
                                                      ? Row(
                                                          children: [Text("")],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              getongoingdatalist
                                                                  .bookingProducts
                                                                  .first
                                                                  .deliverytimeFrom,
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                            ),
                                                            Text(
                                                              " to ",
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                            ),
                                                            Text(
                                                              getongoingdatalist
                                                                  .bookingProducts
                                                                  .first
                                                                  .deliverytimeTo,
                                                              style: primaryfont.copyWith(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xff455A64)),
                                                            ),
                                                          ],
                                                        )
                                                ],
                                              ),
                                            ),
                                            // Container(
                                            //   width: 230.h,
                                            //   padding: const EdgeInsets.only(
                                            //       bottom: 0),
                                            //   child:
                                            Text(
                                                getongoingdatalist
                                                    .bookingDeliveryAddresses[
                                                        index]
                                                    .address,
                                                style: primaryfont.copyWith(
                                                    color:
                                                        const Color(0xff1E1E1E),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp)),
                                            // ExpandableText(
                                            //   getongoingdatalist
                                            //       .bookingDeliveryAddresses[
                                            //           index]
                                            //       .address,
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
                                            // ),
                                          ],
                                        )
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
                                            DateTime.parse(getongoingdatalist
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
                                getongoingdatalist.bookingType == "parcel"
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
                                              getongoingdatalist
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
                                      getongoingdatalist.isConfirmed == "0"
                                          ? Text(
                                              'Ongoing',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff0072E8)),
                                            )
                                          : Text(
                                              'Assigned',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff0072E8)),
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
