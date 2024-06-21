import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_details.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import '../../../constant/common_container.dart';

class ScheduleDeliveryScreen extends StatefulWidget {
  const ScheduleDeliveryScreen({super.key});

  @override
  State<ScheduleDeliveryScreen> createState() => _ScheduleDeliveryScreenState();
}

class _ScheduleDeliveryScreenState extends State<ScheduleDeliveryScreen> {
  bool ischeck = false;
  bool manpowercheck = false;
  bool postinvoicecheck = false;
  bool staircase = false;
  bool otpverificationcheck = false;
  bool fragilcheck = false;
  bool noadditinalservicecheck = false;

  DateTime selectedDate = DateTime.now();

  TimeOfDay pickTime = TimeOfDay.now();
  TimeOfDay dropTime = TimeOfDay.now();
  String pickingTime = "";
  String dropingTime = "";

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: pickTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (time != null) {
      setState(() {
        pickTime = time;
        // pickuptimeController.text = TextEditingValue(text:dropingTime.toString()),
      });

      print(pickTime);
    }
  }

  Future dropTimePicker(BuildContext context) async {
    var times = await showTimePicker(
      context: context,
      initialTime: pickTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (times != null) {
      setState(() {
        dropTime = times;
      });

      print(dropTime);
    }
  }

  var deliverydateController = TextEditingController();
  var delivarytypeController = TextEditingController();
  var parcelsizeController = TextEditingController();
  var parcelkgController = TextEditingController();
  var numberofparcelController = TextEditingController();
  var parcelitemController = TextEditingController();
  var pickuptimeController = TextEditingController();
  var fromtimeController = TextEditingController();
  var totimeController = TextEditingController();
  String formatDateTime = "";

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);
        // deliverydateController.value =
        //     TextEditingValue(text: formatDateTime.toString());
      });
  }

  // TimeOfDay toTime = TimeOfDay.now();

  // void selectTime() async {
  //   final TimeOfDay? newTimes = await showTimePicker(
  //     context: context,
  //     initialTime: toTime,
  //   );

  //   if (newTimes != null) {
  //     setState(() {
  //       toTime = newTimes;
  //       fromtimeController.value = TextEditingValue(text: newTimes.toString());
  //     });
  //   }
  // }

  // TimeOfDay fromTime = TimeOfDay.now();

  // void toselectTime() async {
  //   final TimeOfDay? newTime = await showTimePicker(
  //     context: context,
  //     initialTime: fromTime,
  //   );

  //   if (newTime != null) {
  //     setState(() {
  //       fromTime = newTime;
  //       totimeController.value = TextEditingValue(text: newTime.toString());
  //     });
  //   }
  // }

  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      print('Picked file path: ${pickedFile?.path}');

      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  var signageItems;
  final formKey = GlobalKey<FormState>();

  bool isChecked = false;
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
                              left: 10,
                              right: 10,
                              top: 15,
                            ),
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.kwhite,
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(0.0, 0.75),
                                        blurRadius: 2,
                                        color: AppColors.kgrey)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ksizedbox5,
                                  Text(
                                    'Delivery Details',
                                    style: primaryfont.copyWith(
                                        fontSize: 17.sp,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ksizedbox20,
                                  Text(
                                    'Delivery Date',
                                    style: primaryfont.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  ksizedbox10,
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      height: 50.h,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xff444444)
                                              .withOpacity(.32),
                                        ),
                                        color: AppColors.kwhite,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            formatDateTime,
                                            style: primaryfont.copyWith(
                                                color: Color(0xff455A64),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                selectDate(context);
                                              },
                                              child: Image.asset(
                                                  "assets/icons/date.png")),
                                        ],
                                      )),
                                  ksizedbox10,
                                  Text(
                                    'Delivery Timing',
                                    style: primaryfont.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff455A64)),
                                  ),
                                  ksizedbox10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 5),
                                        height: 50.h,
                                        width: 130.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.kwhite,
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(.32)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${pickTime.hour < 10 ? "0${pickTime.hour}" : pickTime.hour}:${pickTime.minute.remainder(60) < 10 ? "0${pickTime.minute.remainder(60)}" : '${pickTime.minute.remainder(60)}'}:00"
                                                  .toString(),
                                              style: primaryfont.copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff455A64)),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  displayTimePicker(context);
                                                },
                                                icon: Image.asset(
                                                    "assets/icons/mylisticon.png",
                                                    color: Colors.grey))
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'To',
                                        style: primaryfont.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 5),
                                        height: 50.h,
                                        width: 130.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.kwhite,
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(.32)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${dropTime.hour < 10 ? "0${dropTime.hour}" : dropTime.hour}:${dropTime.minute.remainder(60) < 10 ? "0${dropTime.minute.remainder(60)}" : '${dropTime.minute.remainder(60)}'}:00"
                                                  .toString(),
                                              style: primaryfont.copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff455A64)),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  dropTimePicker(context);
                                                },
                                                icon: Image.asset(
                                                  "assets/icons/mylisticon.png",
                                                  color: Colors.grey,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Container(
                                  //       height: 45,
                                  //       width: 130,
                                  //       decoration: BoxDecoration(
                                  //           color: AppColors.kwhite),
                                  //       child: TextFormField(
                                  //         decoration: InputDecoration(
                                  //             suffixIcon: GestureDetector(
                                  //               onTap: () {
                                  //                 selectTime();
                                  //               },
                                  //               child: Image.asset(
                                  //                   "assets/icons/time.png"),
                                  //             ),
                                  //             hintText: toTime.format(context),
                                  //             hintStyle: primaryfont.copyWith(
                                  //                 fontSize: 12,
                                  //                 fontWeight: FontWeight.w500),
                                  //             border: OutlineInputBorder()),
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       'To',
                                  //       style: primaryfont.copyWith(
                                  //           fontWeight: FontWeight.w500),
                                  //     ),
                                  //     Container(
                                  //       height: 45,
                                  //       width: 130,
                                  //       decoration: BoxDecoration(
                                  //           color: AppColors.kwhite),
                                  //       child: TextFormField(
                                  //         //  controller: parcelkgController,
                                  //         decoration: InputDecoration(
                                  //             suffixIcon: GestureDetector(
                                  //               onTap: () {
                                  //                 toselectTime();
                                  //               },
                                  //               child: Image.asset(
                                  //                   "assets/icons/time.png"),
                                  //             ),
                                  //             hintText:
                                  //                 fromTime.format(context),
                                  //             hintStyle: primaryfont.copyWith(
                                  //                 fontSize: 12,
                                  //                 fontWeight: FontWeight.w500),
                                  //             border: OutlineInputBorder()),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  ksizedbox10,
                                  ksizedbox5,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Upload Photo',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455A64)),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Optional',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Icon(
                                            Icons.help_outline,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  ksizedbox15,
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    dashPattern: [6, 6],
                                    color: Color(0xff0080FF),
                                    child: InkWell(
                                      onTap: () {
                                        showPickerDialog(context);
                                      },
                                      child: Container(
                                          height: 140.h,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              color: AppColors.kwhite),
                                          child: Center(
                                            child: image != null
                                                ? Container(
                                                    height: 170,
                                                    width: size.width,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: Image.file(
                                                          image!,
                                                          fit: BoxFit.cover,
                                                        )))
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                        Image.asset(
                                                            'assets/icons/imageuploadicon.png'),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Text(
                                                            'Upload Product Picture',
                                                            style: primaryfont.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.sp,
                                                                color: AppColors
                                                                    .kblue),
                                                          ),
                                                        )
                                                      ]),
                                          )),
                                    ),
                                  ),
                                  ksizedbox10,
                                  Text(
                                    'Add deliver note',
                                    style: primaryfont.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  ksizedbox10,
                                  Container(
                                    height: 100.h,
                                    width: size.width,
                                    decoration:
                                        BoxDecoration(color: AppColors.kwhite),
                                    child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 100,
                                      controller: parcelitemController,
                                      decoration: InputDecoration(
                                        hintText: 'Type here notes...',
                                        hintStyle: primaryfont.copyWith(
                                            fontSize: 14.h,
                                            fontWeight: FontWeight.w500),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Color(0xff444444)
                                                .withOpacity(.32),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Color(0xff444444)
                                                .withOpacity(.32),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Additional Service*',
                                        style: primaryfont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: AppColors.kblue),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showListViewDialog(context);
                                        },
                                        child: const Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: AppColors.kblue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ksizedbox10,
                                ],
                              ),
                            ),
                          ),
                          ksizedbox20,
                          InkWell(
                              onTap: () {
                                Get.to(BookingDetailsScreen());
                              },
                              child: CommonContainer(
                                name: "Booking Review",
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

  void showListViewDialog(BuildContext context) {
    List<String> list = [
      "Manpower Service",
      "Post Invoice (Ex, Stamp)",
      "Staircase",
      "OTP Verification",
      "Fragile Item",
      "Access restricted area"
    ];

    List<bool> isCheck = List<bool>.filled(list.length, false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Additional Services',
                      style: primaryfont.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.kblue,
                          fontWeight: FontWeight.w600),
                    ),
                    Ksizedboxw10,
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Image.asset(
                        'assets/icons/support_icon.png',
                      ),
                    )
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
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    isCheck[index] = !isCheck[index];
                                  },
                                );
                              },
                              child: Container(
                                height: 20.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: AppColors.kblue),
                                    borderRadius: BorderRadius.circular(5)),
                                child: isCheck[index] == true
                                    ? Image.asset("assets/icons/7-Check.png")
                                    : Text(""),
                              ),
                            ),
                            Ksizedboxw10,
                            Text(
                              "${list[index]}",
                              style: primaryfont.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("+\$30",
                                style: primaryfont.copyWith(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ))
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: CommonContainer(
                    name: 'Confirm',
                  )),
            ],
          );
        });
      },
    );
  }
  // popUp(BuildContext context) {
  //   List<String> list = [
  //     "Manpower Service",
  //     "Post Invoice (Ex, Stamp)",
  //     "Staircase",
  //     "OTP Verification",
  //     "Fragile Item",
  //     "Access restricted area"
  //   ];
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               Text(
  //                 'Additional Services',
  //                 style: primaryfont.copyWith(
  //                     fontSize: 16.sp,
  //                     color: AppColors.kblue,
  //                     fontWeight: FontWeight.w600),
  //               ),
  //               Ksizedboxw10,
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 2),
  //                 child: Image.asset(
  //                   'assets/icons/support_icon.png',
  //                 ),
  //               )
  //             ],
  //           ),
  //           GestureDetector(
  //             onTap: () {
  //               Get.back();
  //             },
  //             child: Icon(
  //               Icons.cancel_outlined,
  //               color: Colors.red,
  //             ),
  //           ),
  //         ],
  //       ),
  //       content: Container(
  //         height: 350.h,
  //         child: Column(
  //           children: [
  //             ListView.builder(
  //                 itemCount: list.length,
  //                 shrinkWrap: true,
  //                 itemBuilder: (context, index) {
  //                   return Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           // Checkbox(
  //                           //     value:
  //                           //         manpowercheck,
  //                           //     onChanged:
  //                           //         (value) {
  //                           //       setState(
  //                           //           () {
  //                           //         manpowercheck =
  //                           //             value!;
  //                           //       });
  //                           //     }),
  //                           Text("${list[index]}")
  //                         ],
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text('+30'),
  //                         ],
  //                       )
  //                     ],
  //                   );
  //                 }),

  //           ],
  //         ),
  //       ),
  //       actions: [
  //         InkWell(
  //             onTap: () {
  //               Get.back();
  //             },
  //             child: CommonContainer(
  //               name: 'Confirm',
  //             ))
  //       ],
  //     ),
  //   );
  // }

  void showPickerDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}

//  Container(
//                         height: 50.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30)),
//                         alignment: Alignment.center,
//                         child: InkWell(
//                           onTap: () {
//                             Get.to(BookingDetailsScreen());
//                           },
//                           child: Text(
//                             'Booking Review',
//                             style: thirdsfont.copyWith(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.kwhite),
//                           ),
//                         ),
//                       ),
