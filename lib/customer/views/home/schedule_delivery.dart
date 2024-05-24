import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_export/customer/views/home/package_send/booking_details.dart';

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
  bool manpowercheck =  false;
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
            TextEditingValue(text: picked.toString());
      });
  }

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  TimeOfDay _totime = TimeOfDay(hour: 7, minute: 15);

  void toselectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _totime,
    );

    if (newTime != null) {
      setState(() {
        _time = newTime;
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  color: AppColors.kblue,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: AppColors.kwhite,
                          ),
                        ),
                        Text(
                          'Booking Parcel',
                          style: primaryfont.copyWith(
                              fontSize: 18.sp,
                              color: AppColors.kwhite,
                              fontWeight: FontWeight.w600),
                        ),
                        Text('')
                      ],
                    ),
                  )
                  ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                  color: AppColors.kwhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.kwhite,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    offset: Offset(0.0, 0.75),
                                    blurRadius: 2,
                                    color: AppColors.kgrey)
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ksizedbox5,
                                      Text(
                                        'Delivery Details',
                                        style: primaryfont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
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
                                            color: AppColors.kwhite),
                                        child: TextFormField(
                                          onTap: () {
                                            selectDate(context);
                                          },
                                          controller: deliverydateController,
                                          decoration: InputDecoration(
                                              hintText: 'DD/MM/YYYY',
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
                                            decoration: BoxDecoration(
                                                color: AppColors.kwhite),
                                            child: TextFormField(
                                              onTap: () {
                                                selectTime();
                                              },
                                              decoration: InputDecoration(
                                                  hintText: _time.format(context),
                                                  hintStyle: primaryfont.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                            decoration: BoxDecoration(
                                                color: AppColors.kwhite),
                                            child: TextFormField(
                                              onTap: () {
                                                toselectTime();
                                              },
                                              //  controller: parcelkgController,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      _totime.format(context),
                                                  hintStyle: primaryfont.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                                'Optional',                                              style: primaryfont.copyWith(
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
                                                                      .only(
                                                                      top: 2),
                                                              child: Text(
                                                                'Upload Product Picture',
                                                                style: primaryfont.copyWith(
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
                                        decoration: BoxDecoration(
                                            color: AppColors.kwhite),
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
                                          InkWell(
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (context) =>
                                                     AlertDialog(
                                                   title: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                           Text('Additional Services',
                                                           style: primaryfont.copyWith(
                                                            fontSize: 16.5,
                                                            fontWeight: FontWeight.w600
                                                           ),),
                                                           Padding(
                                                             padding: const EdgeInsets.only(left: 2),
                                                             child: Image.asset('assets/icons/support_icon.png'),
                                                           )
                                                        ],
                                                      ),
                                                      Icon(Icons.cancel_outlined)
                                                    ],
                                                   ),
                                                     content:
                                                      Container(
                                                       height: 290,                                                      child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Checkbox(
                                                                      value: manpowercheck, 
                                                                      onChanged:(value){
                                                                        setState(() {
                                                                         manpowercheck=value!;
                                                                        });
                                                                      }),
                                                                      Text('Manpower Service')
                                                                  ],
                                                                ),
                                                                Text('+30')
                                                              ],
                                                            ),
                                                              Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Checkbox(
                                                                      value: postinvoicecheck, 
                                                                      onChanged:(value){
                                                                        setState(() {
                                                                         postinvoicecheck=value!;
                                                                        });
                                                                      }),
                                                                      Text('Post Invoice (Ex, Stamp)')
                                                                  ],
                                                                ),
                                                                Text('+1')
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Checkbox(
                                                                      value: staircase, 
                                                                      onChanged:(value){
                                                                        setState(() {
                                                                         staircase=value!;
                                                                        });
                                                                      }),
                                                                      Text('Staircase')
                                                                  ],
                                                                ),
                                                                Text('+10')
                                                              ],
                                                            ),
                                                              Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Checkbox(
                                                                      value: otpverificationcheck, 
                                                                      onChanged:(value){
                                                                        setState(() {
                                                                      otpverificationcheck=value!;
                                                                        });
                                                                      }),
                                                                      Text('OTP Verification')
                                                                  ],
                                                                ),
                                                                Text('+0.10')
                                                              ],
                                                            ),
                                                              Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Checkbox(
                                                                      value: fragilcheck, 
                                                                      onChanged:(value){
                                                                        setState(() {
                                                                      fragilcheck=value!;
                                                                        });
                                                                      }),
                                                                      Text('Fragile Item')
                                                                  ],
                                                                ),
                                                                Text('+3')
                                                              ],
                                                            ),
                                                              Row(
                                                              
                                                              children: [
                                                                Checkbox(
                                                                  value: noadditinalservicecheck, 
                                                                  onChanged:(value){
                                                                    setState(() {
                                                                  noadditinalservicecheck=value!;
                                                                    });
                                                                  }),
                                                                  Text('No Additional Services'),
                                                             
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                     actions: [
                                                      InkWell(
                                                        onTap: (){
                                                          Get.back();
                                                        },
                                                        child: CommonContainer(
                                                          name: 'Confirm',))
                                                     ],
                                                 ),
                                              );
                                            },
                                            child: Text(
                                              'Additional Service*',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: AppColors.kblue),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: AppColors.kblue,
                                          ),
                                        ],
                                      ),
                                      ksizedbox20,
                                    ],
                                  ),
                                ),
                                ksizedbox10,
                              ],
                            ),
                          ),
                        ),
                      ),
                      ksizedbox40,
                      ksizedbox10,
                      InkWell(
                        onTap: () {
                           Get.to(BookingDetailsScreen());
                        },
                        child: Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: AppColors.kblue,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              'Booking Review',
                              style: thirdsfont.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kwhite),
                            ),
                          ),
                        ),
                      ),
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
