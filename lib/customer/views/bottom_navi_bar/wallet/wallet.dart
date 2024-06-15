import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool isTopup = false;

  isCheck(bool? value) {
    setState(() {
      isTopup = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          InkWell(
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
                                Text(
                                  'Today',
                                  style: primaryfont.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                ListView.builder(
                                    itemCount: 6,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
                                        //  height: 100.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7, top: 7),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Money Added to wallet",
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Text(
                                                          '24 September | 7:30 AM',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  color: Color(
                                                                      0xff939598),
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Txn Id : KB9787987746G',
                                                        style: primaryfont
                                                            .copyWith(
                                                                color: Color(
                                                                    0xff939598),
                                                                fontSize: 13.sp,
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '+\$50.00',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xff00A8AC),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    Text(
                                                      'Balance \$ 1200.00',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xff939598),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                ksizedbox10,
                                Text(
                                  'Yesterday',
                                  style: primaryfont.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                ListView.builder(
                                    itemCount: 6,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
                                        //  height: 100.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7, top: 7),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Money Added to wallet",
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Text(
                                                          '24 September | 7:30 AM',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  color: Color(
                                                                      0xff939598),
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Txn Id : KB9787987746G',
                                                        style: primaryfont
                                                            .copyWith(
                                                                color: Color(
                                                                    0xff939598),
                                                                fontSize: 13.sp,
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '+\$50.00',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xffEA4747),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    Text(
                                                      'Balance \$ 1200.00',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xff939598),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 260, right: 10),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Today',
                                  style: primaryfont.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                ListView.builder(
                                    itemCount: 6,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
                                        //  height: 100.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7, top: 7),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Money Added to wallet",
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Text(
                                                          '24 September | 7:30 AM',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  color: Color(
                                                                      0xff939598),
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Txn Id : KB9787987746G',
                                                        style: primaryfont
                                                            .copyWith(
                                                                color: Color(
                                                                    0xff939598),
                                                                fontSize: 13.sp,
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '+\$50.00',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xff00A8AC),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    Text(
                                                      'Balance \$ 1200.00',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xff939598),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                ksizedbox10,
                                Text(
                                  'Yesterday',
                                  style: primaryfont.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                ListView.builder(
                                    itemCount: 6,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
                                        //  height: 100.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7, top: 7),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Money Added to wallet",
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Text(
                                                          '24 September | 7:30 AM',
                                                          style: primaryfont
                                                              .copyWith(
                                                                  color: Color(
                                                                      0xff939598),
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Txn Id : KB9787987746G',
                                                        style: primaryfont
                                                            .copyWith(
                                                                color: Color(
                                                                    0xff939598),
                                                                fontSize: 13.sp,
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '+\$50.00',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xffEA4747),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    Text(
                                                      'Balance \$ 1200.00',
                                                      style:
                                                          primaryfont.copyWith(
                                                              color: Color(
                                                                  0xff939598),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
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
              child: Container(
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
                            Text(
                              '\$ 125.00',
                              style: primaryfont.copyWith(
                                  color: Color(0xffffffff),
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(
                            "assets/icons/Group (2).png",
                            color: AppColors.kblue,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 45.h,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 7),
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
                        Container(
                          height: 45.h,
                          width: 70.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            '+100.00',
                            style: primaryfont.copyWith(
                                color: Color(0xffffffff),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: 45.h,
                          width: 70.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            '+200.00',
                            style: primaryfont.copyWith(
                                color: Color(0xffffffff),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: 45.h,
                          width: 70.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            '+300.00',
                            style: primaryfont.copyWith(
                                color: Color(0xffffffff),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: 45.h,
                          width: 70.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            '+400.00',
                            style: primaryfont.copyWith(
                                color: Color(0xffffffff),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    ksizedbox20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Top up',
                                style: primaryfont.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kwhite),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
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
              ),
            ),
          if (isTopup == false)
            Positioned(
              top: 5,
              left: 20,
              child: Container(
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
                              '\$ 00.00',
                              style: primaryfont.copyWith(
                                  color: Color(0xffffffff),
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(
                            "assets/icons/Group (2).png",
                            color: AppColors.kblue,
                          ),
                        )
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
                            width: 150.w,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Top up',
                                style: primaryfont.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.kwhite),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                'Withdraw',
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
              ),
            ),
        ],
      ),
    );
  }
}
