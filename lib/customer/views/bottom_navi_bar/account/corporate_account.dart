import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';

class CorporateAccount extends StatefulWidget {
  const CorporateAccount({super.key});

  @override
  State<CorporateAccount> createState() => _CorporateAccountState();
}

class _CorporateAccountState extends State<CorporateAccount> {
  var companynameController = TextEditingController();
  var personNameController = TextEditingController();
  var phoneController = TextEditingController();
  var uenController = TextEditingController();
  var emailController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: AppColors.kblue,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Corporate Account',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ksizedbox10,
                        Text(
                          'Company Name',
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff455A64)),
                        ),
                        ksizedbox10,
                        Container(
                          height: 45.h,
                          width: size.width,
                          decoration: BoxDecoration(color: AppColors.kwhite),
                          child: TextFormField(
                            controller: companynameController,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Enter Company Name';
                              }
                              return null; // Return null if the input is valid
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Company Name',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff455A64)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ksizedbox20,
                        Text(
                          'Contact Person Name',
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff455A64)),
                        ),
                        ksizedbox10,
                        Container(
                          height: 45.h,
                          width: size.width,
                          decoration: BoxDecoration(color: AppColors.kwhite),
                          child: TextFormField(
                            controller: personNameController,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Enter Contact Person Name';
                              }
                              return null; // Return null if the input is valid
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Contact Person Name',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff455A64)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ksizedbox20,
                        Text(
                          'Phone Number',
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff455A64)),
                        ),
                        ksizedbox10,
                        Container(
                          height: 45.h,
                          width: size.width,
                          decoration: BoxDecoration(color: AppColors.kwhite),
                          child: TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Enter Phone Number';
                              }
                              return null; // Return null if the input is valid
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Phone Number',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff455A64)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ksizedbox20,
                        Text(
                          'Email',
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff455A64)),
                        ),
                        ksizedbox10,
                        Container(
                          height: 45.h,
                          width: size.width,
                          decoration: BoxDecoration(color: AppColors.kwhite),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Enter Email';
                              }
                              return null; // Return null if the input is valid
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Email',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff455A64)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ksizedbox20,
                        Text(
                          'UEN No',
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff455A64)),
                        ),
                        ksizedbox10,
                        Container(
                          height: 45.h,
                          width: size.width,
                          decoration: BoxDecoration(color: AppColors.kwhite),
                          child: TextFormField(
                            controller: uenController,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Enter UEN No';
                              }
                              return null; // Return null if the input is valid
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter UEN No',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff455A64)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ksizedbox20,
                        Text(
                          'Address',
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
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
                            // controller: parcelitemController,
                            decoration: InputDecoration(
                                hintText: 'Type here notes...',
                                hintStyle: primaryfont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        ksizedbox10,
                        Text(
                          'Acra File (Upload)',
                          style: primaryfont.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff455A64)),
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
                                height: 100.h,
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
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Text(
                                                  'Upload Product Picture',
                                                  style: primaryfont.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: AppColors.kblue),
                                                ),
                                              )
                                            ]),
                                )),
                          ),
                        ),
                        ksizedbox20,
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CommonContainer(
          name: "Complete Profile",
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
