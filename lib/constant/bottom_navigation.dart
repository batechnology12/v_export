import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../customer/views/account/account_screen.dart';
import '../customer/views/bottom_navi_bar/home_screen.dart';
import '../customer/views/mylist/mylist_screen.dart';
import '../customer/views/wallet/wallet_screen.dart';
import 'app_colors.dart';
import 'app_font.dart';


class BottomNaviBar extends StatefulWidget {
  int index;
  BottomNaviBar({super.key, this.index = 0});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  int bottomIndex = 0;
  List iconsList = [
    "assets/icons/homeicon.png",
    "assets/icons/mylisticon.png",
  //  "assets/icons/installcustomer.png",
    "assets/icons/vexportwalleticon.png",
    "assets/icons/accounticon.png",
  ];
  List screens = [
    HomeScreen(),
    MyListScreen(),
  //  InstallationCustomer(),
   WalletScreen(),
    AccountScrren(),
  ];
  List title = [
    'Home',
    'MyList',
    'Wallet',
    'Account'
  ];


  

  @override
  void initState() {
    super.initState();
    setDefault();
  }

  setDefault() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        bottomIndex = widget.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: () {
        return showExitPopup(context);
      },
      child: Scaffold(
        body: screens[bottomIndex],
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            height: 60.h,
            leftCornerRadius: 8,
            rightCornerRadius: 8,
            gapLocation: GapLocation.none,
            backgroundColor: AppColors.kwhite,
            itemCount: iconsList.length,
            tabBuilder: ((index, isActive) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconsList[index],
                      height: 26.h,
                      width: 26.w,
                      color: bottomIndex == index
                          ? AppColors.kblue
                          : Colors.black),
                  Text(title[index],
                  style: thirdsfont.copyWith(
                    fontSize: 11.5
                  ) ,),
                ],
              );
            }),
            activeIndex: bottomIndex,
            onTap: (index) {
              setState(() {
                bottomIndex = index;
              });
            }),
      ),
    );
  }
   Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit ?",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          // style: ElevatedButton.styleFrom(
                          //     textStyle:
                          //         primaryfont.copyWith(color: Colors.white),
                          //     primary: Colors.red.shade800),
                          child: Text(
                            "Yes",
                          //  style: primaryfont.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        }
        );
  }
}
