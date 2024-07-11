import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  AccountController accountController = Get.find<AccountController>();
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await accountController.getProfile();
     // await getProfileData();
      accountController.update();
    });
  }

  // getProfileData() async {
  //   if (accountController.getUserData != null) {
  //     nameController.text = accountController.getUserData!.firstName;
  //     mobileController.text = accountController.getUserData!.phone;
  //     emailController.text = accountController.getUserData!.email;
  //     //  addressController.text = accountController.getUserData!.addresses;
  //   }
  // }

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
          'Profile',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 150.h,
                                  width: 150.w,
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Image.asset(
                                    "assets/icons/Ellipse 26.png",
                                    height: 130,
                                    width: 130,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 15.h,
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.kblue,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.edit,
                                              color: Colors.white, size: 22))),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ksizedbox30,
                        Text(
                          'Name',
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
                            controller: nameController,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Enter Name';
                              }
                              return null; // Return null if the input is valid
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Name',
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
                            controller: mobileController,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Phone Number';
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
                        // Text(
                        //   'Address',
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
                        //     controller: addressController,
                        //     validator: (value) {
                        //       if (value == null) {
                        //         return 'Please Enter Address';
                        //       }
                        //       return null; // Return null if the input is valid
                        //     },
                        //     decoration: InputDecoration(
                        //       hintText: 'Enter Address',
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
}
