import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/controller/wallet_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/searching_ride_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/placed_order.dart';

class MakePayment2 extends StatefulWidget {
  String vehiclebookingid;
  String totalAmountVehicle;
  MakePayment2(
      {super.key,
      required this.vehiclebookingid,
      required this.totalAmountVehicle});

  @override
  State<MakePayment2> createState() => _MakePayment2State();
}

class _MakePayment2State extends State<MakePayment2> {
  WalletController walletController = Get.put(WalletController());
  EasebuszzController easebuzz_controller = Get.put(EasebuszzController());

  String name1 = "";
  List paymentlist1 = [];
  bool isClicked1 = false;
  bool walletCheck1 = false;
  bool sufficientBalance1 = false;
  String selectedPaymentMode1 = "";
  bool isChecked1 = false;
  int isSelected1 = -1;

  selected(int value) {
    setState(() {
      isSelected1 = value;
      isChecked1 = true;
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getstpeed();
      await walletController.walletAPi() ?? 0.0;
      await calculateValue();
      setState(() {});
    });
  }

  String type = "";

  getstpeed() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? type = prefs.getString('type');
    setState(() {
      if (accountController.getUserData!.role == "client") {
        paymentlist1 = [
          {
            "image": "assets/images/Vector.svg",
            "name": "Wallet",
            "mode": "WALLET"
          },
          {
            "image": "assets/images/Group (1).svg",
            "name": "Cash on Delivery",
            "mode": "COD"
          },
        ];
      } else {
        paymentlist1 = [
          {
            "image": "assets/images/Vector.svg",
            "name": "Wallet",
            "mode": "WALLET"
          },
          {
            "image": "assets/images/Group (1).svg",
            "name": "Cash on Delivery",
            "mode": "COD"
          },
          {
            "image": "assets/images/fi_13729040.svg",
            "name": "Corporate Account",
            "mode": "ONLINE"
          },
        ];
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  final easebuzzController = Get.put(EasebuszzController());
  ParcelController parcelController = Get.put(ParcelController());
  AccountController accountController = Get.put(AccountController());

  List<bool> isCheck1 = List<bool>.filled(5, false);

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
              size: 17,
            ),
          ),
        ),
        title: Text(
          'Make Payment',
          style: primaryfont.copyWith(
              fontSize: 19.sp,
              color: Color(0xffF4F8FF),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: GetBuilder<WalletController>(builder: (_) {
        return walletController.walletDataList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: formKey,
                child: Container(
                  width: double.infinity,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: AppColors.kblue,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.kblue,
                        Color(0xffF4F8FF),
                        Color(0xffF4F8FF),
                      ],
                      stops: [0.0, 0.1, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: walletController
                          .walletDataList.last.walletBalance.isEmpty
                      ? CircularProgressIndicator()
                      : Column(
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
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: paymentlist1.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i < isCheck1.length;
                                                        i++) {
                                                      isCheck1[i] = i == index;
                                                    }
                                                    selectedPaymentMode1 =
                                                        paymentlist1[index]
                                                            ["mode"];
                                                    if (index == 1) {
                                                      showListViewDialog(
                                                          context);
                                                    }
                                                    isClicked1 = true;
                                                  });

                                                  if (index == 0 &&
                                                      double.parse(walletController
                                                              .walletDataList
                                                              .last
                                                              .walletBalance) >=
                                                          double.parse(widget
                                                              .totalAmountVehicle)) {
                                                    walletCheck1 = true;
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  height: 45,
                                                  color: Color(0xffF4F8FF),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            paymentlist1[index]
                                                                ["image"],
                                                          ),
                                                          Ksizedboxw10,
                                                          Text(
                                                            paymentlist1[index]
                                                                ["name"],
                                                            style: primaryfont.copyWith(
                                                                fontSize: 14.sp,
                                                                color: const Color(
                                                                    0xff455A64)),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration: BoxDecoration(
                                                                color: isCheck1[
                                                                            index] ==
                                                                        true
                                                                    ? AppColors
                                                                        .kblue
                                                                    : Colors
                                                                        .transparent,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .32)),
                                                                shape: BoxShape
                                                                    .circle),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: walletController.walletDataList.last
                                          .walletBalance.isEmpty ||
                                      walletController.walletDataList.last
                                          .walletBalance.isEmpty
                                  ? CircularProgressIndicator()
                                  : Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      height: sufficientBalance1 == false
                                          ? 50.h
                                          : 270.h,
                                      child: Column(
                                        mainAxisAlignment: sufficientBalance1 ==
                                                false
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (sufficientBalance1)
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 165.h,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF4F8FF),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  children: [
                                                    ksizedbox5,
                                                    Container(
                                                      height: 40.h,
                                                      width: 40.w,
                                                      child: Image.asset(
                                                        "assets/icons/exclamation.png",
                                                        color: Colors.orange,
                                                      ),
                                                    ),
                                                    Text("Warning",
                                                        style: secondoryfont
                                                            .copyWith(
                                                                color:
                                                                    Colors.red,
                                                                fontSize:
                                                                    20.sp)),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        "You do not have Sufficient fund in wallet, Top up your wallet balance \$${walletController.walletDataList.last.walletBalance}",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    ksizedbox5,
                                                    InkWell(
                                                      onTap: () {
                                                        Get.offAll(
                                                            BottomNavigationScreen(
                                                                indexes: 2));
                                                      },
                                                      child: Container(
                                                        height: 35.h,
                                                        width: 100.w,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColors.kblue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: Center(
                                                          child: Text(
                                                            'Top up',
                                                            style: primaryfont.copyWith(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .kwhite),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          Obx(() {
                                            return Container(
                                              height: 50.h,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: parcelController
                                                      .updateBookingStatusLoading
                                                      .isTrue
                                                  ? Container(
                                                      height: 50.h,
                                                      width: size.width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        color: AppColors.kblue,
                                                      )),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        if (selectedPaymentMode1 ==
                                                            "WALLET") {
                                                          if (walletCheck1 ==
                                                              true) {
                                                            print(
                                                                "wallet - online");

                                                            parcelController
                                                                .updateBookingSatusApi(
                                                                    widget
                                                                        .vehiclebookingid,
                                                                    selectedPaymentMode1);
                                                          } else {
                                                            Get.snackbar(
                                                                "Payment Failed",
                                                                "You do not have sufficient balance in your wallet",
                                                                colorText:
                                                                    AppColors
                                                                        .kwhite,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                snackPosition:
                                                                    SnackPosition
                                                                        .BOTTOM);
                                                          }
                                                        } else if (isClicked1 ==
                                                                true &&
                                                            // isChecked1 ==
                                                            //     true &&
                                                            selectedPaymentMode1 ==
                                                                "COD") {
                                                          print("COD - cash");
                                                          if (isChecked1 ==
                                                              true) {
                                                            print(
                                                                "selcted code ");
                                                            parcelController
                                                                .updateBookingSatusApi(
                                                                    widget
                                                                        .vehiclebookingid,
                                                                    selectedPaymentMode1);
                                                          } else {
                                                            Get.snackbar(
                                                                "Please select the Sender or receiver in COD",
                                                                "Please try again!",
                                                                colorText:
                                                                    AppColors
                                                                        .kwhite,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                snackPosition:
                                                                    SnackPosition
                                                                        .BOTTOM);
                                                          }
                                                        } else if (selectedPaymentMode1 ==
                                                            "ONLINE") {
                                                          print(
                                                              "ONLINE PAYMENT---------------");
                                                          easebuzz_controller
                                                              .tablepayUseingEaseBuzzSubs(
                                                                  bookingid: widget
                                                                      .vehiclebookingid,
                                                                  payment_mode1:
                                                                      "ONLINE",
                                                                  amount: widget
                                                                      .totalAmountVehicle);
                                                        } else {
                                                          Get.snackbar(
                                                              "Please select the Payment Mode",
                                                              "Please try again!",
                                                              colorText:
                                                                  AppColors
                                                                      .kwhite,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 50.h,
                                                        width: size.width,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColors.kblue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        child: Center(
                                                          child: Text(
                                                            'Make Payment  \$${widget.totalAmountVehicle}',
                                                            style: primaryfont.copyWith(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .kwhite),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                ),
              );
      }),
    );
  }

  Future<void> calculateValue() async {
    if (walletController.walletDataList.isNotEmpty) {
      double walletBalance1 =
          double.tryParse(walletController.walletDataList.last.walletBalance) ??
              0.0;
      double totalAmount1 = double.tryParse(widget.totalAmountVehicle) ?? 0.0;
      setState(() {
        sufficientBalance1 = walletBalance1 < totalAmount1;
        walletCheck1 = walletBalance1 >= totalAmount1;
      });
    }
  }

  void showListViewDialog(BuildContext context) {
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
                          Text(
                            'Collect Payment From',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
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
                      SizedBox(height: 30),
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
                                        color: isSelected1 == 0
                                            ? Colors.blue
                                            : Colors.grey.withOpacity(.30),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
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
                                        color: isSelected1 == 1
                                            ? Colors.blue
                                            : Colors.grey.withOpacity(.30),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset(
                                      "assets/images/Group (3).png",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
                                      color: isSelected1 == 0
                                          ? Colors.blue
                                          : Colors.grey.withOpacity(.30),
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                        color: isSelected1 == 0
                                            ? Colors.blue
                                            : Colors.grey.withOpacity(.30),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: isSelected1 == 0
                                          ? Colors.white
                                          : Colors.white,
                                      size: 15.0,
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
                                    width: 25.0,
                                    height: 25.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected1 == 1
                                          ? Colors.blue
                                          : Colors.grey.withOpacity(.30),
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                        color: isSelected1 == 1
                                            ? Colors.blue
                                            : Colors.grey.withOpacity(.30),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: isSelected1 == 1
                                          ? Colors.white
                                          : Colors.white,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Sender",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isSelected1 == 0
                                            ? Colors.blue
                                            : Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Receiver",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isSelected1 == 1
                                          ? Colors.blue
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      TextButton(
                          onPressed: () {
                            if (isChecked1 == true) {
                              parcelController.senderReceiverApi(
                                  widget.vehiclebookingid,
                                  isSelected1 == 0 ? "sender" : "receiver");
                              Get.back();
                            } else {
                              Get.snackbar("Please select the Payment Mode",
                                  "Please try again!",
                                  colorText: AppColors.kwhite,
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.BOTTOM);
                            }
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

  // void showListViewDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return Center(
  //             child: Dialog(
  //               insetPadding: EdgeInsets.symmetric(horizontal: 25),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20.0),
  //               ),
  //               child: Container(
  //                 padding: EdgeInsets.all(15.0),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Text(
  //                               'Collect Payment From',
  //                               style: primaryfont.copyWith(
  //                                   fontSize: 18.sp,
  //                                   color: Colors.black,
  //                                   fontWeight: FontWeight.w600),
  //                             ),
  //                           ],
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             Get.back();
  //                           },
  //                           child: const Icon(
  //                             Icons.cancel_outlined,
  //                             color: Colors.red,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     ksizedbox30,
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 25, right: 30),
  //                       child: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   setState(() {
  //                                     selected(0);
  //                                   });
  //                                 },
  //                                 child: Container(
  //                                   padding: EdgeInsets.all(20),
  //                                   height: 120,
  //                                   width: 120,
  //                                   decoration: BoxDecoration(
  //                                       border: Border.all(
  //                                         color: isSelected1 == 0
  //                                             ? AppColors.kblue
  //                                             : Colors.grey.withOpacity(.30),
  //                                       ),
  //                                       borderRadius:
  //                                           BorderRadius.circular(10)),
  //                                   child: Image.asset(
  //                                     "assets/images/OBJECTS.png",
  //                                   ),
  //                                 ),
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   setState(() {
  //                                     selected(1);
  //                                   });
  //                                 },
  //                                 child: Container(
  //                                   padding: EdgeInsets.all(20),
  //                                   height: 120,
  //                                   width: 120,
  //                                   decoration: BoxDecoration(
  //                                       border: Border.all(
  //                                         color: isSelected1 == 1
  //                                             ? AppColors.kblue
  //                                             : Colors.grey.withOpacity(.30),
  //                                       ),
  //                                       borderRadius:
  //                                           BorderRadius.circular(10)),
  //                                   child: Image.asset(
  //                                     "assets/images/Group (3).png",
  //                                   ),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                           ksizedbox10,
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                             children: [
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   setState(() {
  //                                     selected(0);
  //                                   });
  //                                 },
  //                                 child: Container(
  //                                     margin: EdgeInsets.only(right: 20),
  //                                     width: 25.0,
  //                                     height: 25.0,
  //                                     alignment: Alignment.center,
  //                                     decoration: BoxDecoration(
  //                                       color: isSelected1 == 0
  //                                           ? AppColors.kblue
  //                                           : Colors.grey.withOpacity(.30),
  //                                       borderRadius:
  //                                           BorderRadius.circular(15.0),
  //                                       border: Border.all(
  //                                         color: isSelected1 == 0
  //                                             ? AppColors.kblue
  //                                             : Colors.grey.withOpacity(.30),
  //                                         width: 2.0,
  //                                       ),
  //                                     ),
  //                                     child:
  //                                         // isSelected == 0
  //                                         //     ?
  //                                         Icon(
  //                                       Icons.check,
  //                                       color: isSelected1 == 0
  //                                           ? Colors.white
  //                                           : Colors.white,
  //                                       size: 15.0,
  //                                     )
  //                                     //  : null,
  //                                     ),
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   setState(() {
  //                                     selected(1);
  //                                   });
  //                                 },
  //                                 child: Container(
  //                                     width: 25.0,
  //                                     height: 25.0,
  //                                     alignment: Alignment.center,
  //                                     decoration: BoxDecoration(
  //                                       color: isSelected1 == 1
  //                                           ? AppColors.kblue
  //                                           : Colors.grey.withOpacity(.30),
  //                                       borderRadius:
  //                                           BorderRadius.circular(15.0),
  //                                       border: Border.all(
  //                                         color: isSelected1 == 1
  //                                             ? AppColors.kblue
  //                                             : Colors.grey.withOpacity(.30),
  //                                         width: 2.0,
  //                                       ),
  //                                     ),
  //                                     child:
  //                                         //  isSelected == 1
  //                                         //     ?
  //                                         Icon(
  //                                       Icons.check,
  //                                       color: isSelected1 == 1
  //                                           ? Colors.white
  //                                           : Colors.white,
  //                                       size: 15.0,
  //                                     )
  //                                     // : null,
  //                                     ),
  //                               ),
  //                             ],
  //                           ),
  //                           ksizedbox10,
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(horizontal: 16),
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(left: 20),
  //                                   child: Text("Sender",
  //                                       style: primaryfont.copyWith(
  //                                         fontSize: 16.sp,
  //                                         color: isSelected1 == 0
  //                                             ? AppColors.kblue
  //                                             : Colors.black,
  //                                         fontWeight: FontWeight.w600,
  //                                       )),
  //                                 ),
  //                                 Text("Receiver",
  //                                     style: primaryfont.copyWith(
  //                                       fontSize: 16.sp,
  //                                       color: isSelected1 == 1
  //                                           ? AppColors.kblue
  //                                           : Colors.black,
  //                                       fontWeight: FontWeight.w600,
  //                                     )),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     ksizedbox30,
  //                     TextButton(
  //                         onPressed: () {
  //                           if (isChecked1 == true) {
  //                             parcelController.senderReceiverApi(
  //                                 widget.vehiclebookingid,
  //                                 isSelected1 == 0 ? "sender" : "receiver");
  //                             Get.back();
  //                           } else {
  //                             Get.snackbar("Please select the Payment Mode",
  //                                 "Please try again!",
  //                                 colorText: AppColors.kwhite,
  //                                 backgroundColor: Colors.red,
  //                                 snackPosition: SnackPosition.BOTTOM);
  //                           }
  //                         },
  //                         child: CommonContainer(
  //                           name: 'Submit',
  //                         )),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
