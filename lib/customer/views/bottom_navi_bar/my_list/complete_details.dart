import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/my_list_controller.dart';
import 'package:v_export/customer/model/get_completed_orders_model.dart';

class CompleteDetails extends StatefulWidget {
  GetCompletedOrdersModelData getCompletedlist;
  CompleteDetails({super.key, required this.getCompletedlist});

  @override
  State<CompleteDetails> createState() => _CompleteDetailsState();
}

class _CompleteDetailsState extends State<CompleteDetails> {
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
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Deliver Details',
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
              decoration: BoxDecoration(
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
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 5),
                        width: size.width,
                        decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/icons/Ellipse 26 (1).png",
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  width: 20.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.getCompletedlist.driver.firstName,
                                      style: primaryfont.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 17.sp),
                                    ),
                                    Text(
                                      "Vechcle Driver",
                                      style: primaryfont.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff455A64),
                                          fontSize: 13.sp),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Ksizedboxw10,
                                        Text(
                                          "3.5",
                                          style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 16.sp),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  height: 35.h,
                                  width: 100.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xffBFFFC1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Delivered',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color(0xff009200)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      ksizedbox10,
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        width: size.width,
                        decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Booking ID : ${widget.getCompletedlist.bookingId}',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.5),
                                  ),
                                ],
                              ),
                              Divider(),
                              ksizedbox10,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Column(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Color(0xff038484),
                                      ),
                                      Dash(
                                          direction: Axis.vertical,
                                          length: 170,
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
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Container(
                                            width: 300.w,
                                            child: Text(
                                              widget.getCompletedlist
                                                  .pickupAddreess,
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff1E1E1E),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.sp),
                                            ),
                                          ),
                                          Text(
                                            "${widget.getCompletedlist.bookingProducts.first.pickuptimeFrom} To ${widget.getCompletedlist.bookingProducts.first.pickuptimeTo}",
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13.sp,
                                                color: Color(0xff455A64)),
                                          )
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
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Container(
                                            width: 300.w,
                                            child: Text(
                                              widget
                                                  .getCompletedlist
                                                  .bookingDeliveryAddresses
                                                  .first
                                                  .address,
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff1E1E1E),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.sp),
                                            ),
                                          ),
                                          Text(
                                            "${widget.getCompletedlist.bookingProducts.first.deliverytimeFrom} To ${widget.getCompletedlist.bookingProducts.first.deliverytimeTo}",
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13.sp,
                                                color: Color(0xff455A64)),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              ksizedbox10,
                            ],
                          ),
                        ),
                      ),
                      ksizedbox10,
                      Container(
                        width: size.width,
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            //  boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //       offset: Offset(0.0, 0.75),
                            //       blurRadius: 2,
                            //       color: AppColors.kgrey)
                            // ],
                            borderRadius: BorderRadius.circular(17)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Bill Details',
                                    style: primaryfont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              ksizedbox5,
                              Divider(),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Fees',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  Text(
                                    '+22.00',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  )
                                ],
                              ),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Additional Surcharge',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  Text(
                                    '+0.00',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  )
                                ],
                              ),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Manpower Service',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  Text(
                                    '+30.00',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  )
                                ],
                              ),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Post Invoice',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  Text(
                                    '+1.00',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  )
                                ],
                              ),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Fragil Item',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  Text(
                                    '+3.0',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  )
                                ],
                              ),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'GST',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  Text(
                                    '18%',
                                    style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  )
                                ],
                              ),
                              ksizedbox20,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: primaryfont.copyWith(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '+65.0',
                                    style: primaryfont.copyWith(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ksizedbox10,
                      Container(
                        padding: EdgeInsets.only(bottom: 15),
                        width: size.width,
                        decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            // boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //       offset: Offset(0.0, 0.95),
                            //       blurRadius: 4,
                            //       color: AppColors.kgrey)
                            // ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment Method',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff1E1E1E),
                                        fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              Divider(),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cash',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 16.sp),
                                  ),
                                  Text(
                                    '+65.0',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              ksizedbox10,
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(5),
                                dashPattern: [6, 6],
                                color: AppColors.kblue,
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    height: 45.h,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xffE5F2FF),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Get Invoice Copy',
                                            style: primaryfont.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Color(0xff1204D4),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Color(0xff1204D4),
                                          ),
                                        ])),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ksizedbox30,
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
