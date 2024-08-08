import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/searching_ride_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/placed_order.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({super.key});

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  final formKey = GlobalKey<FormState>();
  final easebuzzController = Get.find<EasebuszzController>();

  List paymentlist = [
    {"image": "assets/images/Vector.svg", "name": "Wallet"},
    //  {"image": "assets/images/Group 43.svg", "name": "Credit & Debit Card"},
    //  {"image": "assets/images/Group.svg", "name": "QR Code"},
    {"image": "assets/images/fi_13729040.svg", "name": "Corporate Account"},
    {"image": "assets/images/Group (1).svg", "name": "Cash on Delivery"},
  ];

  List<bool> isCheck = List<bool>.filled(5, false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.kwhite,
            ),
          ),
        ),
        title: Text(
          'Make Payment',
          style: primaryfont.copyWith(
              fontSize: 21.sp,
              color: Color(0xffF4F8FF),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          height: size.height,
          decoration: const BoxDecoration(
            color: AppColors.kblue,
            gradient: LinearGradient(
              colors: [
                AppColors.kblue,
                AppColors.kwhite,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Color(0xffF4F8FF),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: paymentlist.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      for (int i = 0; i < isCheck.length; i++) {
                                        isCheck[i] = i == index;
                                      }
                                      if (index == 2) {
                                        showListViewDialog(context);
                                      } else {
                                        easebuzzController
                                            .tablepayUseingEaseBuzzSubs();
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: 45,
                                    color: Color(0xffF4F8FF),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              paymentlist[index]["image"],
                                            ),
                                            Ksizedboxw10,
                                            Ksizedboxw10,
                                            Text(
                                              paymentlist[index]["name"],
                                              style: primaryfont.copyWith(
                                                  fontSize: 14.sp,
                                                  color: Color(0xff455A64)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: isCheck[index] == true
                                                      ? AppColors.kblue
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(.32)),
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showListViewDialog(BuildContext context) {
    int isSelected = -1;

    selected(int value) {
      setState(() {
        isSelected = value;
      });
    }

    // int SelectedCheck = 0;
    // isCheckselected(int value) {
    //   setState(() {
    //     SelectedCheck = value;
    //   });
    // }
    bool isChecked = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Collect Payment From',
                                style: primaryfont.copyWith(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      ksizedbox30,
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected(0);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected == 0
                                              ? AppColors.kblue
                                              : Colors.grey.withOpacity(.30),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(
                                      "assets/images/OBJECTS.png",
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected(1);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected == 1
                                              ? AppColors.kblue
                                              : Colors.grey.withOpacity(.30),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(
                                      "assets/images/Group (3).png",
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ksizedbox10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected(0);
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      width: 25.0,
                                      height: 25.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected == 0
                                            ? AppColors.kblue
                                            : Colors.grey.withOpacity(.30),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: isSelected == 0
                                              ? AppColors.kblue
                                              : Colors.grey.withOpacity(.30),
                                          width: 2.0,
                                        ),
                                      ),
                                      child:
                                          // isSelected == 0
                                          //     ?
                                          Icon(
                                        Icons.check,
                                        color: isSelected == 0
                                            ? Colors.white
                                            : Colors.white,
                                        size: 15.0,
                                      )
                                      //  : null,
                                      ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected(1);
                                    });
                                  },
                                  child: Container(
                                      width: 25.0,
                                      height: 25.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected == 1
                                            ? AppColors.kblue
                                            : Colors.grey.withOpacity(.30),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: isSelected == 1
                                              ? AppColors.kblue
                                              : Colors.grey.withOpacity(.30),
                                          width: 2.0,
                                        ),
                                      ),
                                      child:
                                          //  isSelected == 1
                                          //     ?
                                          Icon(
                                        Icons.check,
                                        color: isSelected == 1
                                            ? Colors.white
                                            : Colors.white,
                                        size: 15.0,
                                      )
                                      // : null,
                                      ),
                                ),
                              ],
                            ),
                            ksizedbox10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text("Sender",
                                        style: primaryfont.copyWith(
                                          fontSize: 16.sp,
                                          color: isSelected == 0
                                              ? AppColors.kblue
                                              : Colors.black,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  Text("Receiver",
                                      style: primaryfont.copyWith(
                                        fontSize: 16.sp,
                                        color: isSelected == 1
                                            ? AppColors.kblue
                                            : Colors.black,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ksizedbox30,
                      TextButton(
                          onPressed: () {
                            Get.to(PlacedOrder());
                          },
                          child: CommonContainer(
                            name: 'Submit',
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
