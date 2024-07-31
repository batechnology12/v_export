import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/model/get_ongoing_orders_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/booking_status.dart';
import 'package:intl/intl.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/cancel_details.dart';

class GetCancelledScreenData extends StatefulWidget {
  const GetCancelledScreenData({super.key});

  @override
  State<GetCancelledScreenData> createState() => _GetCancelledScreenDataState();
}

class _GetCancelledScreenDataState extends State<GetCancelledScreenData> {
  MyListController myListController = Get.find<MyListController>();

  @override
  void initState() {
    super.initState();
    myListController.getCancelledOrderUser("canceled");
  }

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          // Center(
          //     child: Container(
          //         alignment: Alignment.center,
          //         height: 200.h,
          //         width: size.width,
          //         decoration: BoxDecoration(
          //           color: Colors.grey.withOpacity(.09),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: Image.asset(
          //             "assets/images/No Data Found.jpeg"))),

          GetBuilder<MyListController>(builder: (context) {
            if (myListController.getCancelledOrdersLoading.isTrue) {
              return Center(child: CircularProgressIndicator());
            }

            if (myListController.getCancelledOrdersModelData.isEmpty) {
              return Center(
                  child: Container(
                      alignment: Alignment.center,
                      height: 200.h,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.09),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset("assets/images/Group 42002.png")));
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: myListController.getCancelledOrdersModelData.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.09),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(bottom: 10, top: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Booking ID : ${myListController.getCancelledOrdersModelData[index].bookingId}',
                                style: primaryfont.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.5),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(CancelDetals());
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffF5F5F5),
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
                          Divider(),
                          ksizedbox10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Color(0xff038484),
                                      ),
                                      Dash(
                                          direction: Axis.vertical,
                                          length: 100,
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
                                            'Pickup Details',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Container(
                                            width: 200.h,
                                            child: Text(
                                              myListController
                                                  .getCancelledOrdersModelData[
                                                      index]
                                                  .pickupAddreess!,
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff1E1E1E),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp),
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
                                            "Delivery Details",
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Container(
                                            width: 200.h,
                                            child: Text(
                                              myListController
                                                  .getCancelledOrdersModelData[
                                                      index]
                                                  .bookingDeliveryAddresses[
                                                      index]
                                                  .address
                                                  .toString(),
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff1E1E1E),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp),
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
                                    height: 150.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${myListController.getCancelledOrdersModelData[index].bookingProducts[index].pickuptimeFrom} to ${myListController.getCancelledOrdersModelData[index].bookingProducts[index].pickuptimeTo}',

                                          // '${formatTime(myListController.getCancelledOrdersModelData[index].bookingProducts[index].pickuptimeFrom)} to ${formatTime(myListController.getCancelledOrdersModelData[index].bookingProducts[index].pickuptimeTo)}',
                                          style: primaryfont.copyWith(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff455A64)),
                                        ),
                                        Text(
                                          '${myListController.getCancelledOrdersModelData[index].bookingProducts[index].deliverytimeFrom} to ${myListController.getCancelledOrdersModelData[index].bookingProducts[index].deliverytimeTo}',

                                          // '${formatTime(myListController.getCancelledOrdersModelData[index].bookingProducts[index].deliverytimeFrom)} to ${formatTime(myListController.getCancelledOrdersModelData[index].bookingProducts[index].deliverytimeTo)}',
                                          style: primaryfont.copyWith(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
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
                                      // myListController
                                      //     .getCancelledOrdersModelData[
                                      //         index]
                                      //     .bookingDate
                                      //     .toString(),
                                      formatDate(
                                          DateTime.parse(myListController
                                              .getCancelledOrdersModelData[
                                                  index]
                                              .bookingDate
                                              .toString()),
                                          [dd, '-', mm, '-', yyyy]),
                                      style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
                                      'Delivery Date',
                                      style: primaryfont.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      myListController
                                          .getCancelledOrdersModelData[index]
                                          .bookingProducts[index]
                                          .deliveryDate
                                          .toString(),
                                      // formatDate(
                                      //     DateTime.parse(
                                      //         myListController
                                      //             .getCancelledOrdersModelData[
                                      //                 index]
                                      //             .bookingProducts[index]
                                      //             .deliveryDate
                                      //             .toString()),
                                      //     [
                                      //       dd,
                                      //       '-',
                                      //       mm,
                                      //       '-',
                                      //       yyyy
                                      //     ]),
                                      style: primaryfont.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 65.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15.sp)),
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
                                      'Cancelled',
                                      style: primaryfont.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
