import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';

class BookingDetailsContainerWidget extends StatefulWidget {
  const BookingDetailsContainerWidget({super.key});

  @override
  State<BookingDetailsContainerWidget> createState() =>
      _BookingDetailsContainerWidgetState();
}

class _BookingDetailsContainerWidgetState
    extends State<BookingDetailsContainerWidget> {
  var couponController = TextEditingController();

  final easebuzzController = Get.find<EasebuszzController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.kwhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17), topRight: Radius.circular(17))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: size.width,
                  decoration: BoxDecoration(
                      color: AppColors.kwhite,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            offset: Offset(0.0, 0.75),
                            blurRadius: 3,
                            color: AppColors.kgrey)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Booking Details',
                              style: primaryfont.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 16.5),
                            ),
                          ],
                        ),
                        Divider(),
                        ksizedbox5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pickup details',
                              style: primaryfont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '25/04/2024',
                              style: primaryfont.copyWith(
                                  color: Color(0xff455A64),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '2PM to 5PM',
                              style: primaryfont.copyWith(
                                  color: Color(0xff455A64),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '338C Anchorvale Cresent, 543338',
                            style: primaryfont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        ksizedbox5,
                        Divider(),
                        ksizedbox5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery details',
                              style: primaryfont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '25/04/2024',
                              style: primaryfont.copyWith(
                                  color: Color(0xff455A64),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '3PM to 6PM',
                              style: primaryfont.copyWith(
                                  color: Color(0xff455A64),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '338 Serangoon North ave 6, 543338',
                            style: primaryfont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        ksizedbox10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Type :',
                              style: primaryfont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '3 hours Delivery',
                              style: primaryfont.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff455A64)),
                            )
                          ],
                        ),
                        ksizedbox5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vechicle Mode :',
                              style: primaryfont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'All',
                              style: primaryfont.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff455A64)),
                            )
                          ],
                        ),
                        ksizedbox5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Parcel Weight :',
                              style: primaryfont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '1Kg',
                              style: primaryfont.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff455A64)),
                            )
                          ],
                        ),
                        ksizedbox5,
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Additional Services :',
                              style: primaryfont.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            Text(
                              'No',
                              style: primaryfont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        ksizedbox5,
                        Divider(),
                        ksizedbox5,
                        Text(
                          'Driver Notes',
                          style: primaryfont.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            'Call me before reaching and wait at lobby 6B',
                            style: primaryfont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        ksizedbox20,
                      ],
                    ),
                  ),
                ),
                ksizedbox20,
                Container(
                  height: 120,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: AppColors.kwhite,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            offset: Offset(0.0, 0.75),
                            blurRadius: 2,
                            color: AppColors.kgrey)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apply Coupon',
                          style: primaryfont.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        ksizedbox10,
                        ksizedbox5,
                        Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: couponController,
                            decoration: InputDecoration(
                                suffix: Padding(
                                  padding: const EdgeInsets.only(bottom: 9),
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        'Apply',
                                        style: primaryfont.copyWith(
                                          color: AppColors.kwhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ksizedbox20,
                Container(
                  height: 300,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: AppColors.kwhite,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(0.0, 0.75),
                            blurRadius: 2,
                            color: AppColors.kgrey)
                      ],
                      borderRadius: BorderRadius.circular(17)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Payment Details',
                              style: primaryfont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        ksizedbox5,
                        Divider(),
                        ksizedbox10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )
              ]),
            ),
            ksizedbox40,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                  onTap: () {
                    easebuzzController.tablepayUseingEaseBuzzSubs();
                  },
                  child: CommonContainer(
                    name: "Confirm Payment",
                  )),
            ),
            ksizedbox20,
          ],
        ),
      ),
    );
  }
}
