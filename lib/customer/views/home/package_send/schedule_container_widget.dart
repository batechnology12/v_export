import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  var datebookingController = TextEditingController();
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
        datebookingController.value = TextEditingValue(text: picked.toString());
      });
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
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Column(
            children: [
              Container(
                            
                width: size.width,
                decoration: BoxDecoration(
                    color: AppColors.kwhite,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          offset: Offset(0.0, 0.75),
                          blurRadius: 1.5,
                          color: AppColors.kgrey)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              hintText: 'DD/MM/YYYY',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
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
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
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
                            contentPadding:
                                EdgeInsets.only(top: 5, left: 10),
                            labelText: 'Select delivery type',
                            labelStyle: primaryfont.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
                          items:
                              ['data'] // Replace with your dropdown options
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
                      ksizedbox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 45,
                            width: 170,
                            decoration:
                                BoxDecoration(color: AppColors.kwhite),
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
                            height: 45,
                            width: 100,
                            decoration:
                                BoxDecoration(color: AppColors.kwhite),
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
                        ],
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
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
                            height: 45,
                            width: 130,
                            decoration:
                                BoxDecoration(color: AppColors.kwhite),
                            child: TextFormField(
                              controller: parcelsizeController,
                              decoration: InputDecoration(
                                  hintText: '5;24 AM',
                                  hintStyle: primaryfont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Text('To'),
                          Container(
                            height: 45,
                            width: 130,
                            decoration:
                                BoxDecoration(color: AppColors.kwhite),
                            child: TextFormField(
                              controller: parcelkgController,
                              decoration: InputDecoration(
                                  hintText: '5;24 AM',
                                  hintStyle: primaryfont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder()),
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
