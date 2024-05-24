import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';


class CarosalContainerWidget extends StatefulWidget {
 String images;
  String title;
  String discription;
 
   CarosalContainerWidget({super.key,
   required this.images,
   required this.title,required this.discription,
  });

  @override
  State<CarosalContainerWidget> createState() => _CarosalContainerWidgetState();
}

class _CarosalContainerWidgetState extends State<CarosalContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: Column(
        children: [
          Stack(
                                    children:[ 
                                      SvgPicture.asset(widget.images,
                                      height: 130.h,
                                      fit: BoxFit.fitHeight,
                                    ),
                                      Positioned(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                
                                                      Text(widget.title,
                                                      style: secondoryfont.copyWith(
                                                         color: AppColors.kwhite,
                                                         fontSize: 18.sp,
                                                         fontWeight: FontWeight.w700
                                                      ),),
                                                      Text(widget.discription,
                                                      style: secondoryfont.copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppColors.kwhite,
                                                        fontWeight: FontWeight.w500
                                                      ),),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2),
                                                        child: Container(
                                                          height: 30.h,
                                                          width: 90.w,
                                                          decoration: BoxDecoration(
                                                            color: Color(0xff000B95),
                                                            borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: Center(
                                                            child: Text('Book Now',
                                                            style: secondoryfont.copyWith(
                                                               color: AppColors.kwhite,
                                                               fontWeight: FontWeight.w700
                                                            ),),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                              
                                                ),
                                                SvgPicture.asset('assets/images/carolslidercontainerimage.svg',
                                                height: 71.h,
                                                fit: BoxFit.fitHeight,)
                                            ],
                                          ),
                                        ))
                                      ]),
        ],
      ),
    );
  }
} 