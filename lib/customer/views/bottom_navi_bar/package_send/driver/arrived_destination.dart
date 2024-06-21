import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';

class ArrivedDestination extends StatefulWidget {
  const ArrivedDestination({super.key});

  @override
  State<ArrivedDestination> createState() => _ArrivedDestinationState();
}

class _ArrivedDestinationState extends State<ArrivedDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/arrived.svg"),
          ksizedbox15,
          Text(
            'Arrived At Destination',
            style: primaryfont.copyWith(
                fontSize: 21.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600),
          ),
          Text(
            '338 Serangoon North ave 6, 543338',
            style: primaryfont.copyWith(
                fontSize: 15.sp,
                color: Color(0xff1E1E1E),
                fontWeight: FontWeight.w500),
          ),
        ],
      )),
    );
  }
}
