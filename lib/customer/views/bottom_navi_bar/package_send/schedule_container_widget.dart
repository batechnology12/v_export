import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:date_format/date_format.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';

class ScheduleContainerWidget extends StatefulWidget {
  const ScheduleContainerWidget({super.key});

  @override
  State<ScheduleContainerWidget> createState() =>
      _ScheduleContainerWidgetState();
}

class _ScheduleContainerWidgetState extends State<ScheduleContainerWidget> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay pickTime = TimeOfDay.now();
  TimeOfDay dropTime = TimeOfDay.now();

  HomeController homeController = Get.find<HomeController>();
  var datebookingController = TextEditingController();
  var delivarytypeController = TextEditingController();
  var parcelsizeController = TextEditingController();
  var parcelkgController = TextEditingController();
  var numberofparcelController = TextEditingController();
  var parcelitemController = TextEditingController();
  var pickuptimeController = TextEditingController();
  var droptimeController = TextEditingController();
  var quantityController = TextEditingController();
  String formatDateTime = "";
  String pickingTime = "";
  String dropingTime = "";
  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        datebookingController.value =
            TextEditingValue(text: formatDateTime.toString());
      });
    formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);
  }

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

  var signageItems;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: AppColors.kwhite,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          offset: Offset(0.0, 0.75),
                          blurRadius: 1.5,
                          color: AppColors.kgrey)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule your move',
                        style: primaryfont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      ksizedbox10,
                      Text(
                        'Booking Date',
                        style: primaryfont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff455A64)),
                      ),
                      ksizedbox10,
                      Container(
                        height: 45,
                        width: size.width,
                        decoration: BoxDecoration(color: AppColors.kwhite),
                        child: TextFormField(
                          onTap: () {
                            selectDate(context);
                          },
                          controller: datebookingController,
                          decoration: InputDecoration(
                              suffixIcon: Image.asset("assets/icons/date.png"),
                              hintText: 'select Date',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      ksizedbox10,
                      Text(
                        'Select Delivery types',
                        style: primaryfont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff455A64)),
                      ),
                      ksizedbox10,
                      Container(
                        margin: EdgeInsets.only(right: 0),
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
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
                            //  labelText: 'Select delivery type',
                            labelStyle: primaryfont.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
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
                      Text(
                        'Parcel size',
                        style: primaryfont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff455A64)),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 120.h * homeController.addParcels.length,
                        width: size.width,
                        //   color: Colors.yellow,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeController.addParcels.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 45.h,
                                        width: 140.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.kwhite),
                                        child: TextFormField(
                                          controller: parcelsizeController,
                                          decoration: InputDecoration(
                                              hintText: 'L x W x H',
                                              hintStyle: primaryfont.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Container(
                                        height: 45.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.kwhite),
                                        child: TextFormField(
                                          controller: parcelkgController,
                                          decoration: InputDecoration(
                                              hintText: 'Kg',
                                              hintStyle: primaryfont.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Container(
                                        height: 45.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.kwhite),
                                        child: TextFormField(
                                          controller: quantityController,
                                          decoration: InputDecoration(
                                              hintText: 'Qty',
                                              hintStyle: primaryfont.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ksizedbox5,
                                  index == homeController.addParcels.length - 1
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  homeController
                                                      .addParcelList();
                                                });
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: AppColors.kblue,
                                                size: 19,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  homeController
                                                      .addParcelList();
                                                });
                                              },
                                              child: Text(
                                                'Add Parcel',
                                                style: primaryfont.copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.kblue),
                                              ),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    homeController
                                                        .removeParcelList(
                                                            index);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        )
                                ],
                              );
                            }),
                      ),
                      ksizedbox10,
                      Text(
                        'Parcel items',
                        style: primaryfont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff455A64)),
                      ),
                      ksizedbox10,
                      Container(
                        height: 45,
                        width: size.width,
                        decoration: BoxDecoration(color: AppColors.kwhite),
                        child: TextFormField(
                          controller: parcelitemController,
                          decoration: InputDecoration(
                              hintText: 'Items',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          'ex. Food/parcel/medicine',
                          style: primaryfont.copyWith(),
                        ),
                      ),
                      ksizedbox10,
                      Text(
                        'Pickup Time',
                        style: primaryfont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff455A64)),
                      ),
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                                color: AppColors.kwhite,
                                border: Border.all(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${pickTime.hour < 10 ? "0${pickTime.hour}" : pickTime.hour}:${pickTime.minute.remainder(60) < 10 ? "0${pickTime.minute.remainder(60)}" : '${pickTime.minute.remainder(60)}'}:00"
                                      .toString(),
                                  style: primaryfont.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff455A64)),
                                ),
                                IconButton(
                                    onPressed: () {
                                      displayTimePicker(context);
                                    },
                                    icon: Image.asset("assets/icons/time.png"))
                              ],
                            ),
                          ),
                          Text('To'),
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                                color: AppColors.kwhite,
                                border: Border.all(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${dropTime.hour < 10 ? "0${dropTime.hour}" : dropTime.hour}:${dropTime.minute.remainder(60) < 10 ? "0${dropTime.minute.remainder(60)}" : '${dropTime.minute.remainder(60)}'}:00"
                                      .toString(),
                                  style: primaryfont.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff455A64)),
                                ),
                                IconButton(
                                    onPressed: () {
                                      dropTimePicker(context);
                                    },
                                    icon: Image.asset("assets/icons/time.png"))
                              ],
                            ),
                          ),
                        ],
                      ),
                      ksizedbox20,
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
}
