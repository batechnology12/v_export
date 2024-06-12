import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:v_export/customer/views/auth/register_account.dart/verification_screen.dart';

import '../../../../../constant/app_colors.dart';
import '../../../../../constant/app_font.dart';
import '../../../../../constant/common_container.dart';
import '../../login/login_screen.dart';

class BusinessAccount extends StatefulWidget {
  const BusinessAccount({super.key});

  @override
  State<BusinessAccount> createState() => _BusinessAccountState();
}

class _BusinessAccountState extends State<BusinessAccount> {
  bool ischecked = false;

  bool ishiding = false;
  bool confirmhide = false;
  var companynameController = TextEditingController();
  var businessphoneController = TextEditingController();
  var businessemailidController = TextEditingController();
  var contactPersonController = TextEditingController();
  var industryController = TextEditingController();
  var parcelController = TextEditingController();
  var businnesspasswordsController = TextEditingController();
  var bussinessConfirmpasswordsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Company Name *',
          style: primaryfont.copyWith(color: Color(0xff7C86A2)),
        ),
        ksizedbox10,
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter the name';
              }
              return null;
            },
            controller: companynameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        ksizedbox20,
        Text(
          'Phone Number*',
          style: primaryfont.copyWith(color: Color(0xff7C86A2)),
        ),
        ksizedbox10,
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter the mobile number';
              }
              return null;
            },
            controller: businessphoneController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        ksizedbox20,
        Text(
          'Business Email Id * ',
          style: primaryfont.copyWith(color: Color(0xff7C86A2)),
        ),
        ksizedbox10,
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter the email id';
              }
              return null;
            },
            controller: businessemailidController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        ksizedbox20,
        Text(
          'Contact Person Name * ',
          style: primaryfont.copyWith(color: Color(0xff7C86A2)),
        ),
        ksizedbox10,
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter the campany name';
              }
              return null;
            },
            controller: contactPersonController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        ksizedbox20,
        Text(
          'Industry*',
          style: primaryfont.copyWith(color: Color(0xff7C86A2)),
        ),
        ksizedbox10,
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter the industry name';
              }
              return null;
            },
            controller: industryController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        ksizedbox20,
        Text(
          'Number of parcel delivery per month? * ',
          style: primaryfont.copyWith(color: Color(0xff7C86A2)),
        ),
        ksizedbox10,
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter the industry name';
              }
              return null;
            },
            controller: parcelController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        ksizedbox20,
        Text(
          'Password*',
          style: primaryfont.copyWith(color: Color(0xff7C86A2)),
        ),
        ksizedbox10,
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter the password';
              }
              return null;
            },
            obscureText: ishiding,
            controller: businnesspasswordsController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: ishiding
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      ishiding = !ishiding;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        ksizedbox20,
        Text(
          'Confirm Password*',
          style: primaryfont.copyWith(color: Color(0xff7C86A2)),
        ),
        ksizedbox10,
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter the confirm password';
              }
              return null;
            },
            obscureText: confirmhide,
            controller: bussinessConfirmpasswordsController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: confirmhide
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      confirmhide = !confirmhide;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        ksizedbox10,
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Checkbox(
                  value: ischecked,
                  onChanged: (value) {
                    setState(() {
                      ischecked = value!;
                    });
                  }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I have read and agree to the',
                  style: thirdsfont.copyWith(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text('Terms & Condition',
                        style: thirdsfont.copyWith(
                            fontSize: 15.sp,
                            color: AppColors.kblue,
                            fontWeight: FontWeight.w500)),
                    Text(' and ',
                        style: thirdsfont.copyWith(
                            fontSize: 15.sp, fontWeight: FontWeight.w500)),
                    Text('Privacy Policy',
                        style: thirdsfont.copyWith(
                            fontSize: 15.sp,
                            color: AppColors.kblue,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ],
            )
          ],
        ),
        ksizedbox10,
        InkWell(
          onTap: () {
            Get.to(RegisterVerificationScreen());
          },
          child: Container(
            height: 50,
            width: size.width,
            decoration: BoxDecoration(
                color: AppColors.kblue, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'Sign In',
                style: primaryfont.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kwhite),
              ),
            ),
          ),
        ),
        ksizedbox10,
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Already have an account ?',
              style: secondoryfont.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp)),
          InkWell(
            onTap: () {
              Get.to(LoginScreen());
            },
            child: Text(' Sign In',
                style: secondoryfont.copyWith(
                    decoration: TextDecoration.underline,
                    fontSize: 16.sp,
                    color: AppColors.kblue,
                    fontWeight: FontWeight.w500)),
          )
        ]),
        ksizedbox20
      ],
    );
  }
}
