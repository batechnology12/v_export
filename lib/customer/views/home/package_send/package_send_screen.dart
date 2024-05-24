import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/views/home/package_send/schedule_container_widget.dart';
import 'package:v_export/customer/views/home/schedule_delivery.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';


class PackageSendScreen extends StatefulWidget {
  const PackageSendScreen({super.key});

  @override
  State<PackageSendScreen> createState() => _PackageSendScreenState();
}

class _PackageSendScreenState extends State<PackageSendScreen> {

  bool ischeck = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      body: SafeArea(
        child:
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.kblue,
                    child:Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_outlined,
                    color: AppColors.kwhite,),
                  ),
                  Text('Booking Parcel',
                  style: primaryfont.copyWith(
                     fontSize: 18.sp,
                      color: AppColors.kwhite,
                      fontWeight: FontWeight.w600
                    
                  ),),
                  Text('')
                ],
                            ),
                    )
                  ),
                ),
                   Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                          
                      ),
                       color: AppColors.kwhite,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                      child: ListView(
                        children: [
                          Column(
                           children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                             child: Container(
                                                       height: 200,
                                                       width: size.width,
                                                       decoration: BoxDecoration(
                              color: AppColors.kwhite,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(0.0, 0.75),
                                  blurRadius: 1,
                                  color: AppColors.kgrey
                                )
                              ],
                              borderRadius: BorderRadius.circular(5)
                                                       ),
                                                       child: Column(
                              children: [
                                ksizedbox20,
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Container(
                                    height: 41,
                                   width: size.width,
                                   decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.kgrey,
                                      width: 1
                                    ),
                                    color: AppColors.kwhite,
                                    borderRadius: BorderRadius.circular(5)
                                 
                                   ),
                                   child: Row(
                                    children: [
                                      Icon(Icons.location_on,
                                      color: Color(0xffF74354),),
                                      VerticalDivider(
                                     indent: 10,
                                     thickness: 1,
                                      width: 5,
                                     color: Colors.black,
                                      endIndent: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text('Enter Pickup here...',
                                          style: primaryfont.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            
                                          ),),
                                        )
                                    ],
                                   ),
                                  ),
                                ),
                                  Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10,top: 14),
                                  child: Container(
                                    height: 41,
                                   width: size.width,
                                   decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.kgrey,
                                      width: 1
                                    ),
                                    color: AppColors.kwhite,
                                    borderRadius: BorderRadius.circular(5)
                                 
                                   ),
                                   child: Row(
                                    children: [
                                      Icon(Icons.location_on,
                                      color: Color(0xff038484),),
                                      VerticalDivider(
                                     indent: 10,
                                     thickness: 1,
                                      width: 5,
                                     color: Colors.black,
                                      endIndent: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text('Enter Drop here...',
                                          style: primaryfont.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            
                                          ),),
                                        )
                                    ],
                                   ),
                                  ),
                                ),
                                ksizedbox10,
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Checkbox(value: ischeck, 
                                        onChanged: (value){
                                          setState(() {
                                            ischeck=value!;
                                          });
                                        }),
                                        Text('Round Trip',
                                        style: primaryfont.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                        ),)
                                      ],),
                                      Row(
                                        children: [
                                          Icon(Icons.add,
                                          color: AppColors.kblue,
                                          size: 19,),
                                           Text('Add Location',
                                      style: primaryfont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kblue
                                      ),)
                                        ],
                                      ),
                                     
                                    ],
                                  ),
                                )
                              ],
                                                       ),
                                              ),
                           ),
                                            ksizedbox30,
                                             ScheduleContainerWidget(),
                                          ],
                                    
                                          ),
                                             ksizedbox20,
                 InkWell(
                    onTap: (){
                      Get.to(ScheduleDeliveryScreen());
                    },
                    child: Container(
                                height: 50,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: AppColors.kblue,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Center(
                                  child: Text('Next',
                                  style: primaryfont.copyWith(
                                    fontSize:18,
                                    fontWeight: FontWeight.w500 ,
                                    color: AppColors.kwhite
                                  ),),
                                ),
                               ),
                  ),
                  ksizedbox10,
                        ],
                      ),
                    ),
                  ),
                ),
             
              ],
            ),  
      ),
  
    );
  }
}