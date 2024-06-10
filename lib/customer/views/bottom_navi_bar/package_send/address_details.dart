import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            color: Colors.yellow,
          ),
          ksizedbox20,
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Address",
                  style: primaryfont.copyWith(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                ksizedbox10,
                Container(
                  height: 45,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: AppColors.kwhite,
                  ),
                  child: TextFormField(
                      // controller: parcelitemController,
                      decoration: InputDecoration(
                          hintText: 'Enter postal code',
                          hintStyle: primaryfont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff444444),
                            ),
                          ))),
                ),
                ksizedbox10,
                Text(
                  "Enter Block no / Unit no",
                  style: primaryfont.copyWith(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                ksizedbox20,
                Container(
                  height: 45,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: AppColors.kwhite,
                  ),
                  child: TextFormField(
                      // controller: parcelitemController,
                      decoration: InputDecoration(
                          hintText: 'Enter Block no / Unit no',
                          hintStyle: primaryfont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff444444),
                            ),
                          ))),
                ),
                ksizedbox20,
                Text(
                  "Customer Name",
                  style: primaryfont.copyWith(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                ksizedbox20,
                Container(
                  height: 45,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: AppColors.kwhite,
                  ),
                  child: TextFormField(
                      // controller: parcelitemController,
                      decoration: InputDecoration(
                          hintText: 'Enter postal code',
                          hintStyle: primaryfont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff444444),
                            ),
                          ))),
                ),
                ksizedbox20,
                Text(
                  "Enter Phone Number",
                  style: primaryfont.copyWith(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                ksizedbox10,
                Container(
                  height: 45,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: AppColors.kwhite,
                  ),
                  child: TextFormField(
                      // controller: parcelitemController,
                      decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          hintStyle: primaryfont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff444444),
                            ),
                          ))),
                ),
                ksizedbox30,
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CommonContainer(
                      name: 'Confirm',
                    )),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
