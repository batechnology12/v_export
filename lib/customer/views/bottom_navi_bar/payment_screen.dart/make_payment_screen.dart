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

class MakePayment extends StatefulWidget {
  String bookingid;
  String totalAmount;
  MakePayment({super.key, required this.bookingid, required this.totalAmount});

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  WalletController walletController = Get.put(WalletController());

  String name = "";
  List paymentlist = [];
  bool isClicked = false;
  bool walletCheck = false;
  bool sufficientBalance = false;
  String selectedPaymentMode = "";

  @override
  void initState() {
    accountController.getProfile();
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getstpeed();
      await walletController.walletAPi() ?? 0.0;
      await calculateBookingValue();
      setState(() {});
    });
  }

  getstpeed() async {
    final prefs = await SharedPreferences.getInstance();
    String? type = prefs.getString('type');
    setState(() {
      if (type == "client") {
        paymentlist = [
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
        paymentlist = [
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
                                            itemCount: paymentlist.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i < isCheck1.length;
                                                        i++) {
                                                      isCheck1[i] = i == index;
                                                    }
                                                    selectedPaymentMode =
                                                        paymentlist[index]
                                                            ["mode"];
                                                    if (index == 1) {
                                                      showListViewDialog(
                                                          context);
                                                    }
                                                    isClicked = true;
                                                  });
                                                  if (index == 0 &&
                                                      double.parse(walletController
                                                              .walletDataList
                                                              .last
                                                              .walletBalance) >=
                                                          double.parse(widget
                                                              .totalAmount)) {
                                                    walletCheck = true;
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
                                                            paymentlist[index]
                                                                ["image"],
                                                          ),
                                                          Ksizedboxw10,
                                                          Text(
                                                            paymentlist[index]
                                                                ["name"],
                                                            style: primaryfont
                                                                .copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Color(
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
                                      height: sufficientBalance == false
                                          ? 50.h
                                          : 270.h,
                                      child: Column(
                                        mainAxisAlignment: sufficientBalance ==
                                                false
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.spaceBetween,
                                        children: [
                                          // walletController.walletDataList
                                          //             .isNotEmpty &&
                                          //         walletCheck == true &&
                                          //         sufficientBalance == true &&
                                          //         double.parse(walletController
                                          //                     .walletDataList
                                          //                     .isNotEmpty
                                          //                 ? walletController
                                          //                     .walletDataList
                                          //                     .last
                                          //                     .walletBalance
                                          //                 : "0.00") >=
                                          //             double.parse(
                                          //                 widget.totalAmount)
                                          if (sufficientBalance)
                                            // ? Container()
                                            // :
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
                                                        "You do not have Sufficient fund in wallet, Top up your wallet balance${walletController.walletDataList.last.walletBalance}",
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
                                                        if (selectedPaymentMode ==
                                                                "WALLET" ||
                                                            selectedPaymentMode ==
                                                                "ONLINE") {
                                                          if (walletCheck ==
                                                              true) {
                                                            print(
                                                                "wallet - online");
                                                            parcelController
                                                                .updateBookingSatusApi(
                                                                    widget
                                                                        .bookingid,
                                                                    selectedPaymentMode);
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
                                                        } else if (isClicked ==
                                                                true &&
                                                            selectedPaymentMode ==
                                                                "COD") {
                                                          print("COD - cash");
                                                          parcelController
                                                              .updateBookingSatusApi(
                                                                  widget
                                                                      .bookingid,
                                                                  selectedPaymentMode);
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
                                                            'Make Payment  \$${widget.totalAmount}',
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

  Future<void> calculateBookingValue() async {
    if (walletController.walletDataList.isNotEmpty) {
      double walletBalance =
          double.tryParse(walletController.walletDataList.last.walletBalance) ??
              0.0;
      double totalAmount = double.tryParse(widget.totalAmount) ?? 0.0;
      setState(() {
        sufficientBalance = walletBalance < totalAmount;
        walletCheck = walletBalance >= totalAmount;
      });
    }
  }

  void showListViewDialog(BuildContext context) {
    int isSelected = -1;
    bool isChecked = false;

    selected(int value) {
      setState(() {
        isSelected = value;
        isChecked = true;
      });
    }

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
                            if (isChecked == true) {
                              parcelController.senderReceiverApi(
                                  widget.bookingid,
                                  isSelected == 0 ? "sender" : "receiver");
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
}



// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:svg_flutter/svg_flutter.dart';
// import 'package:v_export/constant/app_colors.dart';
// import 'package:v_export/constant/app_font.dart';
// import 'package:v_export/constant/common_container.dart';
// import 'package:v_export/customer/controller/account_controller.dart';
// import 'package:v_export/customer/controller/auth_controller.dart';
// import 'package:v_export/customer/controller/easebuzz_controller.dart';
// import 'package:v_export/customer/controller/parcel_controller.dart';
// import 'package:v_export/customer/controller/wallet_controller.dart';
// import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
// import 'package:v_export/customer/views/bottom_navi_bar/package_send/searching_ride_screen.dart';
// import 'package:v_export/customer/views/bottom_navi_bar/payment_screen.dart/placed_order.dart';

// class MakePayment extends StatefulWidget {
//   String parceID;
//   String totalAmount;
//   MakePayment({super.key, required this.parceID, required this.totalAmount});

//   @override
//   State<MakePayment> createState() => _MakePaymentState();
// }

// class _MakePaymentState extends State<MakePayment> {
//   WalletController walletController = Get.put(WalletController());

//   String name = "";
//   List paymentlist = [];
//   bool isClicked = false;
//   bool walletCheck = false;
//   bool sufficientBalance = false;
//     String selectedPaymentMode = "";

//   @override
//   void initState() {
//     accountController.getProfile();
//     super.initState();
//     walletController.walletAPi() ?? 0.0;
//     gettype();
//   }

//   void gettype() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? type = prefs.getString('type');
//     print("763wre837e-------------type-----------");
//     print(type);
//     setState(() {
//       if (type == "client") {
//         paymentlist = [
//          {
//             "image": "assets/images/Vector.svg",
//             "name": "Wallet",
//             "mode": "WALLET"
//           },
//           {
//             "image": "assets/images/Group (1).svg",
//             "name": "Cash on Delivery",
//             "mode": "COD"
//           },
//         ];
//       } else {
//         paymentlist = [
//            {
//             "image": "assets/images/Vector.svg",
//             "name": "Wallet",
//             "mode": "WALLET"
//           },
//           {
//             "image": "assets/images/Group (1).svg",
//             "name": "Cash on Delivery",
//             "mode": "COD"
//           },
//           {
//             "image": "assets/images/fi_13729040.svg",
//             "name": "Corporate Account",
//             "mode": "ONLINE"
//           },
//         ];
//       }
//        if (walletController.walletDataList.isNotEmpty) {
//         double walletBalance = double.tryParse(
//                 walletController.walletDataList.last.walletBalance) ??
//             0.0;
//         double totalAmount = double.tryParse(widget.totalAmount) ?? 0.0;
//         setState(() {
//           sufficientBalance = walletBalance < totalAmount;
//           walletCheck = walletBalance >= totalAmount;
//         });
//       }
//     });
//     print("-------------name-----------");
//   }

//   final formKey = GlobalKey<FormState>();

//   final easebuzzController = Get.put(EasebuszzController());
//   ParcelController parcelController = Get.put(ParcelController());
//   AuthController authController = Get.put(AuthController());
//   AccountController accountController = Get.put(AccountController());

//   List<bool> isCheck = List<bool>.filled(5, false);

//   //String payment_mode = "";

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: AppColors.kblue,
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: const Padding(
//             padding: EdgeInsets.only(left: 10),
//             child: Icon(
//               Icons.arrow_back_ios_new_sharp,
//               color: AppColors.kwhite,
//               size: 17,
//             ),
//           ),
//         ),
//         title: Text(
//           'Make Payment',
//           style: primaryfont.copyWith(
//               fontSize: 19.sp,
//               color: Color(0xffF4F8FF),
//               fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: GetBuilder(
//         builder: (_) {

//           return  walletController.walletDataList.isEmpty
//             ? Center(child: CircularProgressIndicator())
//             :
//            Form(
//             key: formKey,
//             child: Container(
//               width: double.infinity,
//               height: size.height,
//               decoration: const BoxDecoration(
//                 color: AppColors.kblue,
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.kblue,
//                     AppColors.kwhite,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: size.height,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                         color: Color(0xffF4F8FF),
//                       ),
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.only(left: 20, right: 20, top: 20),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: paymentlist.length,
//                                   itemBuilder: (context, index) {
//                                     // if (index == 0) {
//                                     //   payment_mode = "WALLET";
//                                     // } else if (index == 2) {
//                                     //   payment_mode = "ONLINE";
//                                     // } else if (index == 1) {
//                                     //   payment_mode = "COD";
//                                     // }
          
//                                     return GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           for (int i = 0; i < isCheck.length; i++) {
//                                             isCheck[i] = i == index;
//                                           }
//                                             selectedPaymentMode =
//                                                         paymentlist[index]
//                                                             ["mode"];

//                                           if (index == 1) {
//                                             showListViewDialog(context);
//                                           }
//                                           isClicked = true;
//                                         });
//                                          if (index == 0 &&
//                                                       double.parse(walletController
//                                                               .walletDataList
//                                                               .last
//                                                               .walletBalance) >=
//                                                           double.parse(widget.totalAmount
//                                                               )) {
//                                                     walletCheck = true;
//                                                   }
//                                       },
//                                       child: Container(
//                                         padding:
//                                             EdgeInsets.symmetric(horizontal: 10),
//                                         margin: EdgeInsets.only(bottom: 10),
//                                         height: 45,
//                                         color: Color(0xffF4F8FF),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 SvgPicture.asset(
//                                                   paymentlist[index]["image"],
//                                                 ),
//                                                 Ksizedboxw10,
//                                                 Ksizedboxw10,
//                                                 Text(
//                                                   paymentlist[index]["name"],
//                                                   style: primaryfont.copyWith(
//                                                       fontSize: 14.sp,
//                                                       color: Color(0xff455A64)),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   height: 20,
//                                                   width: 20,
//                                                   decoration: BoxDecoration(
//                                                       color: isCheck[index] == true
//                                                           ? AppColors.kblue
//                                                           : Colors.transparent,
//                                                       border: Border.all(
//                                                           color: Colors.black
//                                                               .withOpacity(.32)),
//                                                       shape: BoxShape.circle),
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   })
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child:  walletController.walletDataList.last
//                                           .walletBalance.isEmpty ||
//                                       walletController.walletDataList.last
//                                           .walletBalance.isEmpty
//                                   ? CircularProgressIndicator()
//                                   : Container(
//                                       margin: EdgeInsets.only(bottom: 5),
//                                       height: sufficientBalance == false
//                                           ? 50.h
//                                           : 270.h,
//                                       child: Column(
//                                         mainAxisAlignment: sufficientBalance ==
//                                                 false
//                                             ? MainAxisAlignment.end
//                                             : MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           // walletController.walletDataList
//                                           //             .isNotEmpty &&
//                                           //         walletCheck == true &&
//                                           //         sufficientBalance == true &&
//                                           //         double.parse(walletController
//                                           //                     .walletDataList
//                                           //                     .isNotEmpty
//                                           //                 ? walletController
//                                           //                     .walletDataList
//                                           //                     .last
//                                           //                     .walletBalance
//                                           //                 : "0.00") >=
//                                           //             double.parse(
//                                           //                 widget.totalAmount)
//                                           if (sufficientBalance)
//                                             // ? Container()
//                                             // :
//                                             GestureDetector(
//                                               onTap: () {},
//                                               child: Container(
//                                                 height: 165.h,
//                                                 width: double.infinity,
//                                                 decoration: BoxDecoration(
//                                                     color: Color(0xffF4F8FF),
//                                                     border: Border.all(
//                                                         width: 1,
//                                                         color: Colors.grey),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10)),
//                                                 child: Column(
//                                                   children: [
//                                                     ksizedbox5,
//                                                     Container(
//                                                       height: 40.h,
//                                                       width: 40.w,
//                                                       child: Image.asset(
//                                                         "assets/icons/exclamation.png",
//                                                         color: Colors.orange,
//                                                       ),
//                                                     ),
//                                                     Text("Warning",
//                                                         style: secondoryfont
//                                                             .copyWith(
//                                                                 color:
//                                                                     Colors.red,
//                                                                 fontSize:
//                                                                     20.sp)),
//                                                     const Padding(
//                                                       padding:
//                                                           EdgeInsets.symmetric(
//                                                               horizontal: 10),
//                                                       child: Text(
//                                                         "You do not have Sufficient fund in wallet, Top your wallet balance",
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                       ),
//                                                     ),
//                                                     ksizedbox5,
//                                                     InkWell(
//                                                       onTap: () {
//                                                         Get.offAll(
//                                                             BottomNavigationScreen(
//                                                                 indexes: 2));
//                                                       },
//                                                       child: Container(
//                                                         height: 35.h,
//                                                         width: 100.w,
//                                                         decoration: BoxDecoration(
//                                                             color:
//                                                                 AppColors.kblue,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         8)),
//                                                         child: Center(
//                                                           child: Text(
//                                                             'Top up',
//                                                             style: primaryfont.copyWith(
//                                                                 fontSize: 12.sp,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 color: AppColors
//                                                                     .kwhite),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                           Obx(() {
//                             return Container(
//                               height: 50.h,
//                               width: MediaQuery.of(context).size.width,
//                               child: parcelController
//                                       .updateBookingStatusLoading.isTrue
//                                   ? Container(
//                                       height: 50.h,
//                                       width: size.width,
//                                       decoration: BoxDecoration(
//                                           //  color: Colors.white,
//                                           borderRadius: BorderRadius.circular(30)),
//                                       child: Center(
//                                           child: CircularProgressIndicator(
//                                         color: AppColors.kblue,
//                                       )),
//                                     )
//                                   :  GestureDetector(
//                                                       onTap: () {
//                                                         if (selectedPaymentMode ==
//                                                                 "WALLET" ||
//                                                             selectedPaymentMode ==
//                                                                 "ONLINE") {
//                                                           if (walletCheck ==
//                                                               true) {
//                                                             print(
//                                                                 "wallet - online");
//                                                             easebuzzController
//                                                                 .tablepayUseingEaseBuzzSubs(
//                                                                     bookingid:
//                                                                         widget.parceID
//                                                                             ,
//                                                                     payment_mode1:
//                                                                         selectedPaymentMode);
//                                                           } else {
//                                                             Get.snackbar(
//                                                                 "Payment Failed",
//                                                                 "You do not have sufficient balance in your wallet",
//                                                                 colorText:
//                                                                     AppColors
//                                                                         .kwhite,
//                                                                 backgroundColor:
//                                                                     Colors.red,
//                                                                 snackPosition:
//                                                                     SnackPosition
//                                                                         .BOTTOM);
//                                                           }
//                                                         } else if (isClicked ==
//                                                                 true &&
//                                                             selectedPaymentMode ==
//                                                                 "COD") {
//                                                           print("COD - cash");
//                                                           parcelController
//                                                               .updateBookingSatusApi(
//                                                                   widget
//                                                                       .parceID,
//                                                                   selectedPaymentMode);
//                                                         } else {
//                                                           Get.snackbar(
//                                                               "Please select the Payment Mode",
//                                                               "Please try again!",
//                                                               colorText:
//                                                                   AppColors
//                                                                       .kwhite,
//                                                               backgroundColor:
//                                                                   Colors.red,
//                                                               snackPosition:
//                                                                   SnackPosition
//                                                                       .BOTTOM);
//                                                         }
//                                                       },
//                                                       child: Container(
//                                                         height: 50.h,
//                                                         width: size.width,
//                                                         decoration: BoxDecoration(
//                                                             color:
//                                                                 AppColors.kblue,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         30)),
//                                                         child: Center(
//                                                           child: Text(
//                                                             'Make Payment  \$${widget.totalAmount}',
//                                                             style: primaryfont.copyWith(
//                                                                 fontSize: 16.sp,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: AppColors
//                                                                     .kwhite),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       ),
//     );
//   }

//   void showListViewDialog(BuildContext context) {
//     int isSelected = -1;
//     bool checked = false;
//     selected(int value) {
//       setState(() {
//         isSelected = value;
//         checked = true;
//       });
//     }

//     // int SelectedCheck = 0;
//     // isCheckselected(int value) {
//     //   setState(() {
//     //     SelectedCheck = value;
//     //   });
//     // }
//     // bool isChecked = false;

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Center(
//               child: Dialog(
//                 insetPadding: EdgeInsets.symmetric(horizontal: 25),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.all(15.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 'Collect Payment From',
//                                 style: primaryfont.copyWith(
//                                     fontSize: 18.sp,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: const Icon(
//                               Icons.cancel_outlined,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                       ksizedbox30,
//                       Padding(
//                         padding: const EdgeInsets.only(left: 25, right: 30),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selected(0);
//                                     });
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(20),
//                                     height: 120,
//                                     width: 120,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: isSelected == 0
//                                               ? AppColors.kblue
//                                               : Colors.grey.withOpacity(.30),
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Image.asset(
//                                       "assets/images/OBJECTS.png",
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selected(1);
//                                     });
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(20),
//                                     height: 120,
//                                     width: 120,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: isSelected == 1
//                                               ? AppColors.kblue
//                                               : Colors.grey.withOpacity(.30),
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Image.asset(
//                                       "assets/images/Group (3).png",
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             ksizedbox10,
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selected(0);
//                                     });
//                                   },
//                                   child: Container(
//                                       margin: EdgeInsets.only(right: 20),
//                                       width: 25.0,
//                                       height: 25.0,
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                         color: isSelected == 0
//                                             ? AppColors.kblue
//                                             : Colors.grey.withOpacity(.30),
//                                         borderRadius:
//                                             BorderRadius.circular(15.0),
//                                         border: Border.all(
//                                           color: isSelected == 0
//                                               ? AppColors.kblue
//                                               : Colors.grey.withOpacity(.30),
//                                           width: 2.0,
//                                         ),
//                                       ),
//                                       child:
//                                           // isSelected == 0
//                                           //     ?
//                                           Icon(
//                                         Icons.check,
//                                         color: isSelected == 0
//                                             ? Colors.white
//                                             : Colors.white,
//                                         size: 15.0,
//                                       )
//                                       //  : null,
//                                       ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selected(1);
//                                     });
//                                   },
//                                   child: Container(
//                                       width: 25.0,
//                                       height: 25.0,
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                         color: isSelected == 1
//                                             ? AppColors.kblue
//                                             : Colors.grey.withOpacity(.30),
//                                         borderRadius:
//                                             BorderRadius.circular(15.0),
//                                         border: Border.all(
//                                           color: isSelected == 1
//                                               ? AppColors.kblue
//                                               : Colors.grey.withOpacity(.30),
//                                           width: 2.0,
//                                         ),
//                                       ),
//                                       child:
//                                           //  isSelected == 1
//                                           //     ?
//                                           Icon(
//                                         Icons.check,
//                                         color: isSelected == 1
//                                             ? Colors.white
//                                             : Colors.white,
//                                         size: 15.0,
//                                       )
//                                       // : null,
//                                       ),
//                                 ),
//                               ],
//                             ),
//                             ksizedbox10,
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     child: Text("Sender",
//                                         style: primaryfont.copyWith(
//                                           fontSize: 16.sp,
//                                           color: isSelected == 0
//                                               ? AppColors.kblue
//                                               : Colors.black,
//                                           fontWeight: FontWeight.w600,
//                                         )),
//                                   ),
//                                   Text("Receiver",
//                                       style: primaryfont.copyWith(
//                                         fontSize: 16.sp,
//                                         color: isSelected == 1
//                                             ? AppColors.kblue
//                                             : Colors.black,
//                                         fontWeight: FontWeight.w600,
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       ksizedbox30,
//                       TextButton(
//                           onPressed: () {
//                             if (checked == true) {
//                               parcelController.senderReceiverApi(widget.parceID,
//                                   isSelected == 0 ? "sender" : "receiver");
//                               Get.back();
//                             } else {
//                               Get.snackbar("Please select the Payment Mode",
//                                   "Please try again!",
//                                   colorText: AppColors.kwhite,
//                                   backgroundColor: Colors.red,
//                                   snackPosition: SnackPosition.BOTTOM);
//                             }
//                           },
//                           child: CommonContainer(
//                             name: 'Submit',
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
