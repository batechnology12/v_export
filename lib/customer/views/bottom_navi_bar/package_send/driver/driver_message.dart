import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/chat_class.dart';
import 'package:v_export/constant/driver_chat_class.dart';

class DriverMessage extends StatefulWidget {
  const DriverMessage({super.key});

  @override
  State<DriverMessage> createState() => _DriverMessageState();
}

class _DriverMessageState extends State<DriverMessage> {
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
        title: Row(
          children: [
            Image.asset(
              "assets/icons/Ellipse 26 (1).png",
              height: 50,
              width: 50,
            ),
            Ksizedboxw10,
            Column(
              children: [
                Text(
                  "Lee Wong",
                  style: primaryfont.copyWith(
                      color: AppColors.kwhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp),
                ),
                Text(
                  "Van Driver",
                  style: primaryfont.copyWith(
                      color: AppColors.kwhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp),
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 40.h,
              width: 40.w,
              child: SvgPicture.asset(
                'assets/icons/08.whatsapp.svg',
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      body: Container(
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
                margin: EdgeInsets.only(top: 10.h),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
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
                        ksizedbox10,
                        ksizedbox10,
                        ListView.builder(
                          itemCount: driverMessages.length,
                          reverse: true,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment:
                                  driverMessages[index].messageType ==
                                          "receiver"
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                driverMessages[index].messageType == "receiver"
                                    ? Row(
                                        mainAxisAlignment:
                                            driverMessages[index].messageType ==
                                                    "receiver"
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: size.width * 0.6,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  driverMessages[index].image,
                                                  height: 35,
                                                  width: 35,
                                                ),
                                                Ksizedboxw10,
                                                Text(
                                                  driverMessages[index]
                                                      .driverName,
                                                  style: primaryfont.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  driverMessages[index].time,
                                                  style: primaryfont.copyWith(
                                                      color: Color(0xffD9D9D9),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            driverMessages[index].messageType !=
                                                    "receiver"
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  driverMessages[index].time,
                                                  style: primaryfont.copyWith(
                                                      color: Color(0xffD9D9D9),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: size.width * 0.6,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  driverMessages[index]
                                                      .driverName,
                                                  style: primaryfont.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.sp),
                                                ),
                                                Ksizedboxw10,
                                                Image.asset(
                                                  driverMessages[index].image,
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        driverMessages[index].messageType ==
                                                "receiver"
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffF3F3F3)),
                                              borderRadius: BorderRadius.only(
                                                  topRight: driverMessages[
                                                                  index]
                                                              .messageType ==
                                                          "receiver"
                                                      ? Radius.circular(20)
                                                      : Radius.circular(0),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  topLeft: driverMessages[index]
                                                              .messageType ==
                                                          "receiver"
                                                      ? Radius.circular(0)
                                                      : Radius.circular(20)),
                                              color: Color(0xffFFFFFF)),
                                          padding: EdgeInsets.all(16),
                                          margin:
                                              EdgeInsets.symmetric(vertical: 4),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              driverMessages[index].massage,
                                              style: primaryfont.copyWith(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13.sp),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                ksizedbox20,
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              height: 60.h,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                  height: 55.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: Color(0xffECECEC)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 10, top: 12, bottom: 10),
                        hintText: "Type a message here...",
                        hintStyle: primaryfont.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 3, right: 5),
                          child: Container(
                            height: 40.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                color: Color(0xff0000000),
                                borderRadius: BorderRadius.circular(5)),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.settings_voice_outlined,
                                  color: AppColors.kwhite,
                                  size: 25.h,
                                )),
                          ),
                        )),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
