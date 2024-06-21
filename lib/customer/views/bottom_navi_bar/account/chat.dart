import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/chat_class.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool isSender = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      popUp();
    });
  }

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
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 10.h,
              width: 10.w,
              decoration: BoxDecoration(
                color: AppColors.kblue,
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColors.kwhite),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: AppColors.kwhite,
              ),
            ),
          ),
        ),
        title: Text(
          'V Export Care',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
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
                        ksizedbox10,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Today",
                                    style: primaryfont.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp),
                                  ),
                                ],
                              );
                            }),
                        ksizedbox10,
                        ListView.builder(
                          itemCount: messages.length,
                          reverse: true,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment:
                                  messages[index].messageType == "receiver"
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        messages[index].messageType ==
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
                                                0.5,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffFFFFFF)),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomLeft: messages[index]
                                                            .messageType ==
                                                        "receiver"
                                                    ? Radius.circular(0)
                                                    : Radius.circular(20),
                                                bottomRight: messages[index]
                                                            .messageType ==
                                                        "receiver"
                                                    ? Radius.circular(20)
                                                    : Radius.circular(0),
                                                topLeft: Radius.circular(20),
                                              ),
                                              color: Color(0xffFFFFFF)),
                                          padding: EdgeInsets.all(16),
                                          margin:
                                              EdgeInsets.symmetric(vertical: 4),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              messages[index].chatMessage,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 10),
                                  child: Text(
                                    "9:00 PM",
                                    style: primaryfont.copyWith(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp),
                                  ),
                                ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          popUp();
                        },
                        child: Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffC4E4FF)),
                          child: const Icon(
                            Icons.menu,
                            color: Color(0xff0072E8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          height: 55.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                              color: Color(0xffECECEC)),
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 12, bottom: 10),
                                hintText: "Type Here...........",
                                hintStyle: primaryfont.copyWith(
                                    color: Color(0xff949599),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
                                border: InputBorder.none,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.send,
                                        color: Color(0xff0072E8),
                                        size: 35.h,
                                      )),
                                )),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  popUp() {
    final size1 = MediaQuery.of(context).size;
    // bool isCheck = true;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Menu",
                        style: primaryfont.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      ksizedbox20,
                      Text(
                        "Book Another Cab",
                        style: primaryfont.copyWith(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      ksizedbox10,
                      Text(
                        "Found a better alternative",
                        style: primaryfont.copyWith(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      ksizedbox10,
                      Text(
                        "Drive is taking too long",
                        style: primaryfont.copyWith(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      ksizedbox10,
                      Text(
                        "Schedule Change",
                        style: primaryfont.copyWith(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      ksizedbox10,
                      Text(
                        "My Reason is not listed",
                        style: primaryfont.copyWith(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                ksizedbox10,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  height: 60.h,
                  width: size1.width,
                  decoration: const BoxDecoration(
                      color: Color(0xffF1F1F1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 55.h,
                              width: 55.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffC4E4FF)),
                              child: Image.asset(
                                "assets/icons/cancel1.png",
                                color: Color(0xff0072E8),
                              ),
                              // child: const Icon(
                              //   Icons.cancel,
                              //   color: Color(0xff0072E8),
                              // ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              height: 55.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20),
                                  color: Color(0xffFFFFFF)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 10, top: 12, bottom: 10),
                                    hintText: "Type Here...........",
                                    hintStyle: primaryfont.copyWith(
                                        color: Color(0xff949599),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp),
                                    border: InputBorder.none,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.send,
                                            color: Color(0xff0072E8),
                                            size: 35.h,
                                          )),
                                    )),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
