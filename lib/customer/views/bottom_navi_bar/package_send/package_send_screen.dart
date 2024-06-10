import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/schedule_container_widget.dart';
import 'package:v_export/customer/views/bottom_navi_bar/schedule_delivery.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';

class PackageSendScreen extends StatefulWidget {
  const PackageSendScreen({super.key});

  @override
  State<PackageSendScreen> createState() => _PackageSendScreenState();
}

class _PackageSendScreenState extends State<PackageSendScreen> {
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: AppColors.kblue,
          // gradient: LinearGradient(
          //   colors: [
          //     AppColors.kblue,
          //     AppColors.kwhite,
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: Column(
          children: [
            Container(
              height: size.height * 0.15,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: AppColors.kwhite,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.25),
                    child: Text(
                      'Booking Parcel',
                      style: primaryfont.copyWith(
                          fontSize: 19.sp,
                          color: AppColors.kwhite,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                  color: AppColors.kwhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 5,
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 200.0 * homeController.entries.length,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: AppColors.kwhite,
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      offset: Offset(0.0, 0.75),
                                      blurRadius: 1,
                                      color: AppColors.kgrey)
                                ],
                                borderRadius: BorderRadius.circular(5)),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: homeController.entries.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    // SizedBox(height: 20),
                                    if (index == 0)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                        ),
                                        child: Container(
                                          height: 55.h,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xffF74354),
                                              ),
                                              VerticalDivider(
                                                indent: 10,
                                                thickness: 1,
                                                width: 5,
                                                color: Colors.black,
                                                endIndent: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  'Enter Pickup here...',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Container(
                                        height: 55.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color(0xff038484),
                                            ),
                                            VerticalDivider(
                                              indent: 10,
                                              thickness: 1,
                                              width: 5,
                                              color: Colors.black,
                                              endIndent: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                'Enter Drop here...',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: homeController
                                                    .isCheck.value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    homeController
                                                        .toggleCheck(value!);
                                                  });
                                                },
                                              ),
                                              const Text(
                                                'Round Trip',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          index ==
                                                  homeController
                                                          .entries.length -
                                                      1
                                              ? // Only show on last item
                                              Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          homeController
                                                              .addEntry(); // Add new entry
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: Colors.blue,
                                                        size: 19,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          homeController
                                                              .addEntry();
                                                        });
                                                      },
                                                      child: const Text(
                                                        'Add Location',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            homeController
                                                                .removeEntry(
                                                                    index);
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ))
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        ksizedbox30,
                        ScheduleContainerWidget(),
                        ksizedbox20,
                        InkWell(
                            onTap: () {
                              Get.to(ScheduleDeliveryScreen());
                            },
                            child: CommonContainer(
                              name: "Next",
                            )),
                        ksizedbox10,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
