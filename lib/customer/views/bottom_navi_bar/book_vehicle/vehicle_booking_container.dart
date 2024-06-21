import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_export/constant/common_container.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';

class VehicleBookingContainerWidget extends StatefulWidget {
  const VehicleBookingContainerWidget({super.key});

  @override
  State<VehicleBookingContainerWidget> createState() =>
      _VehicleBookingContainerWidgetState();
}

class _VehicleBookingContainerWidgetState
    extends State<VehicleBookingContainerWidget> {
  DateTime selectedDate = DateTime.now();

  var datebookingController = TextEditingController();
  var delivarytypeController = TextEditingController();
  var parcelsizeController = TextEditingController();
  var parcelkgController = TextEditingController();
  var numberofparcelController = TextEditingController();
  var parcelitemController = TextEditingController();
  var pickuptimeController = TextEditingController();
  String formatDateTime = "";

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);
      });
  }

  TimeOfDay pickTime = TimeOfDay.now();
  String pickingTime = "";
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
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 5,
      ),
      child: Container(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: AppColors.kwhite,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          offset: Offset(0.0, 0.75),
                          blurRadius: 2,
                          color: AppColors.kgrey)
                    ],
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pickup Date',
                        style: primaryfont.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff455A64)),
                      ),
                      ksizedbox10,
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 50.h,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Color(0xff444444).withOpacity(.32),
                            ),
                            color: AppColors.kwhite,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatDateTime.isEmpty
                                    ? 'Select Date'
                                    : formatDateTime,
                                style: primaryfont.copyWith(
                                  color: Color(0xff455A64),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    selectDate(context);
                                  },
                                  child: Image.asset("assets/icons/date.png")),
                            ],
                          )),
                      ksizedbox10,
                      Text(
                        'Select Vehicle',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff455A64)),
                      ),
                      ksizedbox10,
                      Container(
                        margin: EdgeInsets.only(right: 0),
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          value: signageItems,
                          onChanged: (newValue) {
                            setState(() {
                              signageItems = newValue!;
                              // calculateSquareFeet();
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a Signage Details';
                            }
                            return null; // Return null if the input is valid
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5, left: 10),
                            hintText: 'Select Vehicle',
                            hintStyle: primaryfont.copyWith(
                              color: Color(0xff455A64),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xff444444).withOpacity(.32),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xff444444).withOpacity(.32),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
                          items: ['data'] // Replace with your dropdown options
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: primaryfont.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      ksizedbox10,
                      ksizedbox10,
                      Text(
                        'Pickup Time',
                        style: primaryfont.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff455A64)),
                      ),
                      ksizedbox10,
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50.h,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: AppColors.kwhite,
                            border: Border.all(
                                width: 1, color: Colors.grey.withOpacity(.32)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                icon: Image.asset("assets/icons/mylisticon.png",
                                    color: Colors.grey))
                          ],
                        ),
                      ),
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff455A64)),
                              ),
                              ksizedbox5,
                              Icon(
                                Icons.help_outline,
                                size: 20.sp,
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
                              height: 130.h,
                              width: size.width,
                              decoration:
                                  BoxDecoration(color: AppColors.kwhite),
                              child: Center(
                                child: image != null
                                    ? Container(
                                        height: 170,
                                        width: size.width,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                                  const EdgeInsets.only(top: 2),
                                              child: Text(
                                                'Upload Product Picture',
                                                style: primaryfont.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp,
                                                    color: AppColors.kblue),
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
                        decoration: BoxDecoration(color: AppColors.kwhite),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          maxLines: 100,
                          controller: parcelitemController,
                          decoration: InputDecoration(
                            hintText: 'Type here notes...',
                            hintStyle: primaryfont.copyWith(
                                fontSize: 14.h, fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xff444444).withOpacity(.32),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xff444444).withOpacity(.32),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ksizedbox10,
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Additional Service*',
                            style: primaryfont.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: AppColors.kblue),
                          ),
                          GestureDetector(
                            onTap: () async {
                              showListViewDialog(context);
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
              ksizedbox10,
            ],
          ),
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
}
