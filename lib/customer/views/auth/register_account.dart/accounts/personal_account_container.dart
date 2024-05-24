import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constant/app_colors.dart';
import '../../../../../constant/app_font.dart';
import '../../../../../constant/common_container.dart';
import '../../login/login_screen.dart';
import '../verification_screen.dart';


class PersonalAccount extends StatefulWidget {
  const PersonalAccount({super.key});

  @override
  State<PersonalAccount> createState() => _PersonalAccountState();
}

class _PersonalAccountState extends State<PersonalAccount> {

  bool ischeck = false;

  bool ishide = false;
  bool confirnhide = false;
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var emailController = TextEditingController();
final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
                                'Name*',
                                style: primaryfont.copyWith(
                                    color: Color(0xff7C86A2)),
                              ),
                              ksizedbox10,
                             Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value==null||value.isEmpty) {
                            return 'Please Enter the name';
                          }
                          return null;
                        },
                          controller:nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                    ),
                              ksizedbox20,
                              Text(
                                'Phone Number*',
                                style: primaryfont.copyWith(
                                    color: Color(0xff7C86A2)),
                              ),
                              ksizedbox10,
                             Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value==null||value.isEmpty) {
                            return 'Please Enter the mobile number';
                          }
                          return null;
                        },
                          controller:mobileController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                    ),
                              ksizedbox20,
                              Text(
                                'Email Id*',
                                style: primaryfont.copyWith(
                                    color: Color(0xff7C86A2)),
                              ),
                              ksizedbox10,
                              Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value==null||value.isEmpty) {
                            return 'Please Enter the email id';
                          }
                          return null;
                        },
                          controller:emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                    ),
                              ksizedbox20,
                              Text(
                                'Password*',
                                style: primaryfont.copyWith(
                                    color: Color(0xff7C86A2)),
                              ),
                              ksizedbox10,
                              Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                    validator: (value) {
                          if (value==null||value.isEmpty) {
                            return 'Please Enter the password';
                          }
                          return null;
                        },
                                  obscureText: ishide,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: ishide
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            ishide = !ishide;
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
                                style: primaryfont.copyWith(
                                    color: Color(0xff7C86A2)),
                              ),
                              ksizedbox10,
                              Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                    validator: (value) {
                          if (value==null||value.isEmpty) {
                            return 'Please Enter the confirm password';
                          }
                          return null;
                        },
                                  obscureText: confirnhide,
                                  controller: confirmpasswordController,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: confirnhide
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            confirnhide = !confirnhide;
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
                                        value: ischeck,
                                        onChanged: (value) {
                                          setState(() {
                                            ischeck = value!;
                                          });
                                        }),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'I have read and agree to the',
                                        style: thirdsfont.copyWith(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Text('Terms & Condition',
                                              style: thirdsfont.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColors.kblue,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                          Text(' and ',
                                              style: thirdsfont.copyWith(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500)),
                                          Text('Privacy Policy',
                                              style: thirdsfont.copyWith(
                                                  fontSize: 13.sp,
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
                                onTap: (){
                                  Get.to(RegisterVerificationScreen());
                              //        if(formkey.currentState!.validate()){
                              //         if(
                              //         mobileController.text.isNotEmpty&&
                              //         nameController.text.isNotEmpty&&
                              //         emailController.text.isNotEmpty&&
                              //         passwordController.text.isNotEmpty&&
                              //         confirmpasswordController.text.isNotEmpty
                              //  ) {
                              //      Get.to(LoginScreen());
                              //  }else {
                              //       Get.rawSnackbar(
                              //         messageText: Text('Please Fill the All Details')
                              //       );
                              //       }
                              //  }  
                                },
                                child: CommonContainer(
                                  name: 'Signup',
                                ),
                              ),
                              ksizedbox10,
                            
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Already have an account ?',
                                      style: secondoryfont.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.5.sp)),
                                  InkWell(
                                    onTap: (){
                                      Get.to(LoginScreen());
                                    },
                                    child: Text(
                                       ' Sign In',
                                        style: secondoryfont.copyWith(
                                            fontSize: 16.sp,
                                            color: AppColors.kblue,
                                            fontWeight: FontWeight.w500)),
                                  )
                                       ] ),
                              ksizedbox20,
          ],
        ),
      ),
    );
  }
}