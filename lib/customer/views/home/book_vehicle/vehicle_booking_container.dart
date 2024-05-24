import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';


class VehicleBookingContainerWidget extends StatefulWidget {
  const VehicleBookingContainerWidget({super.key});

  @override
  State<VehicleBookingContainerWidget> createState() =>
      _VehicleBookingContainerWidgetState();
}

class _VehicleBookingContainerWidgetState extends State<VehicleBookingContainerWidget> {

  bool manpowercheck =  false;
  bool postinvoicecheck = false;
  bool staircase = false;
  bool otpverificationcheck = false;
  bool fragilcheck = false;
  bool noadditinalservicecheck = false;

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
    return Container(
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
                        blurRadius: 1.5,
                        color: AppColors.kgrey)
                  ],
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    Text(
                      'Pickup Date',
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
                      'Select Vehicle',
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
                          labelText: 'Select Vehicle',
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
                   
                   
                    ksizedbox10,
                    Text(
                      'Pickup Time',
                      style: primaryfont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff455A64)),
                    ),
                    ksizedbox10,
                    Container(
                      height: 45,
                  
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
                           ksizedbox10,
                               Text(
                      'Delivery Time',
                      style: primaryfont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff455A64)),
                    ),
                    ksizedbox10,
                    Container(
                      height: 45,
                 
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
                                                    InkWell(
                                                      onTap: (){
                                                        Get.back();
                                                      },
                                                      child: Icon(Icons.cancel_outlined,
                                                      color: Color(0xffFF0835),))
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
                                                   actions: <Widget>[
                                                    InkWell(
                                                      onTap: (){
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.kblue,
                                                          borderRadius: BorderRadius.circular(5)
                                                        ),
                                                        child: Center(
                                                          child: Text('Confirm',
                                                          style: primaryfont.copyWith(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 16,
                                                            color: AppColors.kwhite
                                                          ),),
                                                        ),
                                                      ))
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
                                    ksizedbox10,
                  ],
                ),
              ),
            ),
            ksizedbox10,
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
