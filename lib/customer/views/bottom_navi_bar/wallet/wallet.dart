import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/easebuzz_controller.dart';
import 'package:v_export/customer/controller/wallet_controller.dart';
import 'package:v_export/customer/model/wallet_model.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';
import 'package:intl/intl.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final TextEditingController amountController = TextEditingController();
  WalletController walletController = Get.put(WalletController());
  EasebuszzController easebuszzController = Get.put(EasebuszzController());

  final easebuzzController = Get.put(EasebuszzController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await walletController.walletAPi();
      setState(() {});
    });
  }

  void updateAmount(String amount) {
    setState(() {
      amountController.text = amount;
    });
  }

  bool isTopup = false;

  isCheck(bool? value) {
    setState(() {
      isTopup = value!;
    });
  }

  String formatTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);

      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return '$e';
    }
  }

  String formatingDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatingMonth(DateTime date) {
    return DateFormat('dd-MMMM').format(date);
  }

  String dateShowing(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final today = DateTime.now().toLocal();
    final yesterday = today.subtract(Duration(days: 1)).toLocal();

    final dateToShow = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final todayDate = DateTime(today.year, today.month, today.day);
    final yesterdayDate =
        DateTime(yesterday.year, yesterday.month, yesterday.day);

    if (dateToShow.isAtSameMomentAs(todayDate)) {
      return "Today";
    } else if (dateToShow.isAtSameMomentAs(yesterdayDate)) {
      return "Yesterday";
    } else {
      return formatter.format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime? lastDateDisplayed;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: Container(),
        title: Text(
          'Wallet',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(NotificationView());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/icons/notification_icon.png',
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 80.h),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xffF4F8FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: isTopup == false
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 140, right: 10),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetBuilder<WalletController>(builder: (_) {
                                  return walletController.walletDataList.isEmpty
                                      ? const Center(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: walletController
                                              .walletDataList
                                              .last
                                              .walletHistory
                                              .length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            WalletHistory walletHistory =
                                                walletController.walletDataList
                                                    .last.walletHistory[index];

                                            DateTime walletDate =
                                                walletHistory.createdAt;

                                            String dateShow =
                                                dateShowing(walletDate);

                                            // Check if the date is different from the last displayed date
                                            bool showDate =
                                                lastDateDisplayed == null ||
                                                    !isSameDate(
                                                        lastDateDisplayed!,
                                                        walletDate);

                                            if (showDate) {
                                              lastDateDisplayed = walletDate;
                                            }
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ksizedbox15,
                                                if (showDate)
                                                  Text(
                                                    dateShow,
                                                    style: primaryfont.copyWith(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 3),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5,
                                                          right: 10,
                                                          top: 5,
                                                          bottom: 5),
                                                  //  height: 100.h,
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 7,
                                                                    top: 7),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Money Added to wallet",
                                                                  style: primaryfont.copyWith(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              5),
                                                                  child: Text(
                                                                    // walletHistory
                                                                    //     .createdAt
                                                                    //     .toString(),
                                                                    '${formatingMonth(walletHistory.createdAt)} | ${formatTime(walletHistory.createdAt.toString())}',
                                                                    style: primaryfont.copyWith(
                                                                        color: Color(
                                                                            0xff939598),
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Txn Id :${walletHistory.referenceNumber}',
                                                                  style: primaryfont.copyWith(
                                                                      color: Color(
                                                                          0xff939598),
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                walletHistory
                                                                            .transactionType ==
                                                                        "credit"
                                                                    ? '+\$${walletHistory.amount}'
                                                                    : '-\$${walletHistory.amount}',
                                                                style: primaryfont.copyWith(
                                                                    color: walletHistory.transactionType ==
                                                                            "credit"
                                                                        ? const Color(
                                                                            0xff00A8AC)
                                                                        : Colors
                                                                            .red,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                }),
                              ],
                            ),
                          ),
                        )
                      :
                      //Text("data")

                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 260, right: 10),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ksizedbox10,
                                GetBuilder<WalletController>(
                                    builder: (context) {
                                  return walletController.walletDataList.isEmpty
                                      ? const Center(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: walletController
                                              .walletDataList
                                              .last
                                              .walletHistory
                                              .length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            WalletHistory walletHistorylist =
                                                walletController.walletDataList
                                                    .last.walletHistory[index];

                                            DateTime walletDates =
                                                walletHistorylist.createdAt;

                                            String dateShows =
                                                dateShowing(walletDates);

                                            // Check if the date is different from the last displayed date
                                            bool showDates =
                                                lastDateDisplayed == null ||
                                                    !isSameDate(
                                                        lastDateDisplayed!,
                                                        walletDates);

                                            if (showDates) {
                                              lastDateDisplayed = walletDates;
                                            }
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ksizedbox15,
                                                if (showDates)
                                                  Text(
                                                    dateShows,
                                                    // formatingDate(
                                                    //     walletHistorylist
                                                    //         .createdAt),
                                                    style: primaryfont.copyWith(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 3),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5,
                                                          right: 10,
                                                          top: 5,
                                                          bottom: 5),
                                                  //  height: 100.h,
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 7,
                                                                    top: 7),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Money Added to wallet",
                                                                  style: primaryfont.copyWith(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              5),
                                                                  child: Text(
                                                                    '${formatingMonth(walletHistorylist.createdAt)} | ${formatTime(walletHistorylist.createdAt.toString())}',
                                                                    style: primaryfont.copyWith(
                                                                        color: Color(
                                                                            0xff939598),
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Txn Id :${walletHistorylist.referenceNumber}',
                                                                  style: primaryfont.copyWith(
                                                                      color: Color(
                                                                          0xff939598),
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                '+\$${walletHistorylist.amount}',
                                                                style: primaryfont.copyWith(
                                                                    color: const Color(
                                                                        0xff00A8AC),
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              // Text(
                                                              //   'Balance \$ 1200.00',
                                                              //   style:
                                                              //       primaryfont.copyWith(
                                                              //           color: Color(
                                                              //               0xff939598),
                                                              //           fontSize: 12.sp,
                                                              //           fontWeight:
                                                              //               FontWeight
                                                              //                   .w500),
                                                              // ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                }),
                              ],
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
          if (isTopup == true)
            Positioned(
              top: 5,
              left: 20,
              child: GetBuilder<WalletController>(builder: (_) {
                return walletController.walletDataList.isEmpty
                    ? CircularProgressIndicator()
                    : Container(
                        padding: EdgeInsets.all(20),
                        //height: 250.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/icons/card.png",
                                ),
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Wallet Balance',
                                      style: primaryfont.copyWith(
                                          color: Color(0xffffffff),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    walletController.walletDataList.last
                                            .walletBalance.isEmpty
                                        ? Text("No data")
                                        : Text(
                                            // "",
                                            '\$${walletController.walletDataList.last.walletBalance}',
                                            style: primaryfont.copyWith(
                                                color: Color(0xffffffff),
                                                fontSize: 26.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ],
                                ),
                                Container(
                                  height: 45.h,
                                  width: 45.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    child: SvgPicture.asset(
                                      "assets/icons/Group 56.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ksizedbox10,
                            Container(
                              height: 45.h,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 7),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            ksizedbox20,
                            Text(
                              'Bonus adding amount \$25',
                              style: primaryfont.copyWith(
                                  color: Color(0xffffffff),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            ksizedbox20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    updateAmount("100");
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 70.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      '+100.00',
                                      style: primaryfont.copyWith(
                                          color: Color(0xffffffff),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    updateAmount("200");
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 70.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      '+200.00',
                                      style: primaryfont.copyWith(
                                          color: Color(0xffffffff),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    updateAmount("300");
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 70.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      '+300.00',
                                      style: primaryfont.copyWith(
                                          color: Color(0xffffffff),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    updateAmount("400");
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 70.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      '+400.00',
                                      style: primaryfont.copyWith(
                                          color: Color(0xffffffff),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ksizedbox20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  return walletController.topupLoading.isTrue
                                      ? Container(
                                          height: 50.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.white,
                                          )),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            easebuszzController
                                                .tablepayUseingEaseBuzzSubs(
                                                    bookingid: "",
                                                    payment_mode1: "off",
                                                    amount:
                                                        amountController.text);
                                          },
                                          child: Container(
                                            height: 50.h,
                                            width: 150.w,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: Text(
                                                'Top up',
                                                style: primaryfont.copyWith(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.kwhite),
                                              ),
                                            ),
                                          ),
                                        );
                                }),
                                InkWell(
                                  onTap: () {
                                    amountController.clear();
                                    isTopup = false;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: primaryfont.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.kwhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
              }),
            ),
          if (isTopup == false)
            Positioned(
              top: 5,
              left: 20,
              child: GetBuilder<WalletController>(builder: (context) {
                return walletController.walletDataList.isEmpty
                    ? CircularProgressIndicator()
                    : Container(
                        padding: EdgeInsets.all(20),
                        height: 200.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/icons/card.png",
                                ),
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Wallet Balance',
                                      style: primaryfont.copyWith(
                                          color: Color(0xffffffff),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      // "",
                                      walletController.walletDataList.last
                                              .walletBalance.isNotEmpty
                                          ? '\$${walletController.walletDataList.last.walletBalance}'
                                          : "Loading...",
                                      style: primaryfont.copyWith(
                                          color: Color(0xffffffff),
                                          fontSize: 26.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 45.h,
                                  width: 45.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    child: SvgPicture.asset(
                                      "assets/icons/Group 56.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isTopup = true;
                                    });
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        'Top up',
                                        style: primaryfont.copyWith(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.kwhite),
                                      ),
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {},
                                //   child: Container(
                                //     height: 50.h,
                                //     width: 150.w,
                                //     decoration: BoxDecoration(
                                //         color: Colors.black,
                                //         borderRadius: BorderRadius.circular(8)),
                                //     child: Center(
                                //       child: Text(
                                //         'Withdraw',
                                //         style: primaryfont.copyWith(
                                //             fontSize: 17,
                                //             fontWeight: FontWeight.w500,
                                //             color: AppColors.kwhite),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      );
              }),
            ),
        ],
      ),
    );
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
