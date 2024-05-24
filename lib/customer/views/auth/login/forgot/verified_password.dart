import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constant/app_colors.dart';
import '../../../../../constant/app_font.dart';
import 'create_new_password.dart';


class VerifiedPasswordScreen extends StatefulWidget {
  const VerifiedPasswordScreen({super.key});

  @override
  State<VerifiedPasswordScreen> createState() => _VerifiedPasswordScreenState();
}

class _VerifiedPasswordScreenState extends State<VerifiedPasswordScreen> {

  var mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,
            size: 19,),
          ),
          title: Text('Verification',
          style: primaryfont.copyWith(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600
          ),),
        ),
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
       
        children: [
          ksizedbox30,
             ksizedbox10,
             ksizedbox40,
             Padding(
               padding: const EdgeInsets.only(left: 20),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('Phone Verification',
                   style: primaryfont.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700
                   ),),
                   ksizedbox5,
                   Text('Code is send to +91 9876543210',
                   style: primaryfont.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500
                   ),),
                      ksizedbox40,
                      ksizedbox40,
                   OtpTextField(
                    margin: 	EdgeInsets.only(right: 15),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                 fieldHeight: 55,
                 borderWidth: 5.0,
                    fieldWidth: 55,
                    
                mainAxisAlignment: MainAxisAlignment.center,
                numberOfFields: 4,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (code) => print("OTP is => $code")),
                
                ksizedbox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don"t receive code?',
                    style: primaryfont.copyWith(
                      fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                    ),),
                    Text(' Request again',
                     style: primaryfont.copyWith(
                      fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kblue
                    )
                    )
                  ],
                )

                 ],
               ),
             ),
             
                
        ],
       ),
       bottomNavigationBar: Padding(
         padding: const EdgeInsets.only(left: 15,right: 15),
         child: Container(
          height: 110.h,
           child: Column(
             children: [
               InkWell(
                onTap: (){
                  Get.to(CreatePasswordScreen());
                },
                 child: Container(
                              height: 50.h,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: AppColors.kblue,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Text('Verify',
                                style: primaryfont.copyWith(
                                  fontSize:18.sp,
                                  fontWeight: FontWeight.w500 ,
                                  color: AppColors.kwhite
                                ),),
                              ),
                             ),
               ),
                          
                        
             ],
           ),
         ),
       ),
    );
  }
}