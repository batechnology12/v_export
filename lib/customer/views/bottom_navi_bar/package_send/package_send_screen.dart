import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/address_details.dart';
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

  final formKey = GlobalKey<FormState>();
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
          'Booking Parcel',
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
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                              padding: EdgeInsets.only(top: 10),
                              duration: const Duration(milliseconds: 300),
                              height: 190.0 * homeController.entries.length,
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
                                      if (index == 0)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                            left: 10,
                                          ),
                                          child: Container(
                                            height: 50.h,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(.32),
                                                  width: 1),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Color(0xffF74354),
                                                ),
                                                const VerticalDivider(
                                                  indent: 10,
                                                  thickness: 1,
                                                  width: 5,
                                                  color: Color(0xff455A64),
                                                  endIndent: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Get.to(AddressDetails());
                                                    },
                                                    child: Text(
                                                      'Enter Pickup here...',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontSize: 13.sp,
                                                        color:
                                                            Color(0xff455A64),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
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
                                          height: 50.h,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(.32),
                                                width: 1),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Color(0xff038484),
                                              ),
                                              const VerticalDivider(
                                                indent: 10,
                                                thickness: 1,
                                                width: 5,
                                                color: Color(0xff455A64),
                                                endIndent: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(AddressDetails());
                                                  },
                                                  child: Text(
                                                    'Enter Drop here...',
                                                    style: primaryfont.copyWith(
                                                      fontSize: 13.sp,
                                                      color: Color(0xff455A64),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
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
                                                Text(
                                                  'Round Trip',
                                                  style: primaryfont.copyWith(
                                                    fontSize: 17.sp,
                                                    color: Color(0xff455A64),
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
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                              Color(0xff0072E8),
                                                          size: 19.sp,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            homeController
                                                                .addEntry();
                                                          });
                                                        },
                                                        child: Text(
                                                          'Add Location',
                                                          style: primaryfont
                                                              .copyWith(
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color(
                                                                0xff0072E8),
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
      ),
    );
  }
}
