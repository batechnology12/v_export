import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';

class CorporateAccount extends StatefulWidget {
  const CorporateAccount({super.key});

  @override
  State<CorporateAccount> createState() => _CorporateAccountState();
}

class _CorporateAccountState extends State<CorporateAccount> {
  @override
  void initState() {
    // TODO: implement initState]
    super.initState();
    getData();
    loadImage();
  }

  AccountController accountController = Get.put(AccountController());

  var companynameController = TextEditingController();
  var personNameController = TextEditingController();
  var phoneController = TextEditingController();
  // var uenController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await accountController.corporateAccountProfile();
      setState(() {
        companynameController.text =
            accountController.getCorporateAccountModelList!.firstName;
        personNameController.text =
            accountController.getCorporateAccountModelList!.contactPersonName;
        phoneController.text =
            accountController.getCorporateAccountModelList!.phone;
        personNameController.text =
            accountController.getCorporateAccountModelList!.contactPersonName;
        emailController.text =
            accountController.getCorporateAccountModelList!.email;
        addressController.text =
            accountController.getCorporateAccountModelList!.address;
      });
    });
  }

  Future<void> saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('image_path', path);
  }

  Future<String?> getImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('image_path');
  }

  Future<void> loadImage() async {
    String? path = await getImagePath();
    if (path != null) {
      setState(() {
        image = File(path);
      });
    }
  }

  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        await saveImagePath(pickedFile.path);
        setState(() {
          image = File(pickedFile.path);
        });
        print(image!.path);
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
                          'Business Email',
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
                        // ksizedbox20,
                        // Text(
                        //   'UEN No',
                        //   style: primaryfont.copyWith(
                        //       fontSize: 14.sp,
                        //       fontWeight: FontWeight.w500,
                        //       color: Color(0xff455A64)),
                        // ),
                        // ksizedbox10,
                        // Container(
                        //   height: 45.h,
                        //   width: size.width,
                        //   decoration: BoxDecoration(color: AppColors.kwhite),
                        //   child: TextFormField(
                        //     controller: uenController,
                        //     validator: (value) {
                        //       if (value == null) {
                        //         return 'Please Enter UEN No';
                        //       }
                        //       return null; // Return null if the input is valid
                        //     },
                        //     decoration: InputDecoration(
                        //       hintText: 'Enter UEN No',
                        //       hintStyle: primaryfont.copyWith(
                        //           fontSize: 13.sp,
                        //           fontWeight: FontWeight.w500,
                        //           color: Color(0xff455A64)),
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(
                        //           width: 1,
                        //           color: Color(0xff5C5C5C),
                        //         ),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(
                        //           width: 1,
                        //           color: Color(0xff5C5C5C),
                        //         ),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: const BorderSide(
                        //           width: 1,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                          decoration: BoxDecoration(
                              color: AppColors.kwhite,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            maxLines: 100,
                            controller: addressController,
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
                        ksizedbox15,
                        // DottedBorder(
                        //   borderType: BorderType.RRect,
                        //   radius: Radius.circular(5),
                        //   dashPattern: [6, 6],
                        //   color: AppColors.kblue,
                        //   child: InkWell(
                        //     onTap: () {
                        //       pickImage(ImageSource.camera);
                        //     },
                        //     child: Container(
                        //         height: 170.h,
                        //         width: size.width,
                        //         decoration:
                        //             BoxDecoration(color: AppColors.kwhite),
                        //         child: Center(
                        //           child: image != null
                        //               ? Container(
                        //                   height: 170,
                        //                   width: size.width,
                        //                   child: ClipRRect(
                        //                       borderRadius:
                        //                           BorderRadius.circular(5),
                        //                       child: Image.file(
                        //                         image!,
                        //                         fit: BoxFit.cover,
                        //                       )))
                        //               : Column(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                       Image.asset(
                        //                           'assets/icons/imageuploadicon.png'),
                        //                       Padding(
                        //                         padding: const EdgeInsets.only(
                        //                             top: 2),
                        //                         child: Text(
                        //                           'Upload Product Picture',
                        //                           style: primaryfont.copyWith(
                        //                               fontWeight:
                        //                                   FontWeight.w500,
                        //                               fontSize: 14,
                        //                               color: AppColors.kblue),
                        //                         ),
                        //                       )
                        //                     ]),
                        //         )),
                        //   ),
                        // ),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: const Color(0xff2D2D2D),
                          radius: Radius.circular(20),
                          dashPattern: [5, 5],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 170.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xffF2F2F2).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20)),
                              child: image != null
                                  ? GestureDetector(
                                      onTap: () {
                                        pickImage(ImageSource.camera);
                                      },
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                        height: 170.h,
                                        width: double.infinity,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        pickImage(ImageSource.camera);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/icons/imageuploadicon.png'),
                                          ksizedbox10,
                                          Text(
                                            'Upload Product Picture',
                                            style: primaryfont.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: AppColors.kblue),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
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
        child: Obx(() {
          return accountController.corporateProfileLoading.isTrue
              ? Container(
                  height: 50.h,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: AppColors.kblue,
                  )),
                )
              : GestureDetector(
                  onTap: () {
                    accountController.corporateAccountProfileUser(
                        companyname: companynameController.text,
                        mail: emailController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        person: personNameController.text);
                  },
                  child: CommonContainer(
                    name: "Complete Profile",
                  ),
                );
        }),
      ),
    );
  }

  // void showPickerDialog(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Wrap(
  //             children: <Widget>[
  //               ListTile(
  //                 leading: Icon(Icons.photo_library),
  //                 title: Text('Photo Library'),
  //                 onTap: () {
  //                   pickImage(ImageSource.gallery);
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               ListTile(
  //                 leading: Icon(Icons.photo_camera),
  //                 title: Text('Camera'),
  //                 onTap: () {
  //                   pickImage(ImageSource.camera);
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
