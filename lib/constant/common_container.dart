import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font.dart';


class CommonContainer extends StatefulWidget {
  dynamic name;
   CommonContainer({super.key,this.name});

  @override
  State<CommonContainer> createState() => _CommonContainerState();
}

class _CommonContainerState extends State<CommonContainer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
    child:  Container(
                    height: 50,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColors.kblue,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: Text(widget.name,
                      style: thirdsfont.copyWith(
                        fontSize:18.5,
                        fontWeight: FontWeight.w700 ,
                        color: AppColors.kwhite
                      ),),
                    ),
                   ),
    );
  }
}