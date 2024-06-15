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
  //   String fromTime = "";
  // String toTime = "";
  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        deliverydateController.value =
            TextEditingValue(text: formatDateTime.toString());
      });
    formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);
  }

  TimeOfDay toTime = TimeOfDay.now();

  void selectTime() async {
    final TimeOfDay? newTimes = await showTimePicker(
      context: context,
      initialTime: toTime,
    );

    if (newTimes != null) {
      setState(() {
        toTime = newTimes;
        fromtimeController.value = TextEditingValue(text: newTimes.toString());
      });
    }
  }

  TimeOfDay fromTime = TimeOfDay.now();

  void toselectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: fromTime,
    );

    if (newTime != null) {
      setState(() {
        fromTime = newTime;
        totimeController.value = TextEditingValue(text: newTime.toString());
      });
    }
  }

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
  final formkey = GlobalKey<FormState>();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
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
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              ksizedbox20,
                              Text(
                                'Delivery Date',
                                style: primaryfont.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff455A64)),
                              ),
                              ksizedbox10,
                              Container(
                                height: 45,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.kwhite,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(.32))),
                                child: TextFormField(
                                  controller: deliverydateController,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          selectDate(context);
                                        },
                                        child: Image.asset(
                                            "assets/icons/date.png"),
                                      ),
                                      hintText: 'Select Date',
                                      hintStyle: primaryfont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              ksizedbox10,
                              Text(
                                'Delivery Timing',
                                style: primaryfont.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff455A64)),
                              ),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 130,
                                    decoration:
                                        BoxDecoration(color: AppColors.kwhite),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              selectTime();
                                            },
                                            child: Image.asset(
                                                "assets/icons/time.png"),
                                          ),
                                          hintText: toTime.format(context),
                                          hintStyle: primaryfont.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  Text(
                                    'To',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 130,
                                    decoration:
                                        BoxDecoration(color: AppColors.kwhite),
                                    child: TextFormField(
                                      //  controller: parcelkgController,
                                      decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              toselectTime();
                                            },
                                            child: Image.asset(
                                                "assets/icons/time.png"),
                                          ),
                                          hintText: fromTime.format(context),
                                          hintStyle: primaryfont.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ],
                              ),
                              ksizedbox10,
                              ksizedbox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Upload Photo',
                                    style: primaryfont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Optional',
                                        style: primaryfont.copyWith(
                                            fontSize: 14,
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
                              ksizedbox20,
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(5),
                                dashPattern: [6, 6],
                                color: AppColors.kblue,
                                child: InkWell(
                                  onTap: () {
                                    showPickerDialog(context);
                                  },
                                  child: Container(
                                      height: 170,
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
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image.file(
                                                      image!,
                                                      fit: BoxFit.cover,
                                                    )))
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                    Image.asset(
                                                        'assets/icons/imageuploadicon.png'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2),
                                                      child: Text(
                                                        'Upload Product Picture',
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff455A64)),
                              ),
                              ksizedbox10,
                              Container(
                                height: 100,
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              ksizedbox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Additional Service*',
                                    style: primaryfont.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppColors.kblue),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      bool manpowercheck = false;
                                      bool postinvoicecheck = false;
                                      bool staircase = false;
                                      bool otpverificationcheck = false;
                                      bool fragilcheck = false;
                                      bool noadditinalservicecheck = false;
                                      await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Additional Services',
                                                    style: primaryfont.copyWith(
                                                        fontSize: 16.5,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2),
                                                    child: Image.asset(
                                                        'assets/icons/support_icon.png'),
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Container(
                                            height: 350.h,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value:
                                                                manpowercheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                manpowercheck =
                                                                    value!;
                                                              });
                                                            }),
                                                        Text('Manpower Service')
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('+30'),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value:
                                                                postinvoicecheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                postinvoicecheck =
                                                                    value!;
                                                              });
                                                            }),
                                                        Text(
                                                            'Post Invoice (Ex, Stamp)')
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('+1'),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value: staircase,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                staircase =
                                                                    value!;
                                                              });
                                                            }),
                                                        Text('Staircase')
                                                      ],
                                                    ),
                                                    const Row(
                                                      children: [
                                                        Text('+10'),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value:
                                                                otpverificationcheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                otpverificationcheck =
                                                                    value!;
                                                              });
                                                            }),
                                                        Text('OTP Verification')
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('+0.10'),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value: fragilcheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                fragilcheck =
                                                                    value!;
                                                              });
                                                            }),
                                                        Text('Fragile Item')
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('+3'),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value:
                                                                noadditinalservicecheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                noadditinalservicecheck =
                                                                    value!;
                                                              });
                                                            }),
                                                        Text(
                                                            'No Additional Services'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [Text("+1")],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: CommonContainer(
                                                  name: 'Confirm',
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                    child: Icon(
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
            )
          ],
        ),
      ),
    );
  }

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