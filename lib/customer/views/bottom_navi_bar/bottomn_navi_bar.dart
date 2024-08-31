import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/account.dart';
import 'package:v_export/customer/views/bottom_navi_bar/home_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/my_list.dart';
import 'package:v_export/customer/views/bottom_navi_bar/wallet/wallet.dart';

class BottomNavigationScreen extends StatefulWidget {
  int indexes;
  BottomNavigationScreen({super.key, required this.indexes});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.indexes;
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _screens = [
    HomeScreen(),
    MyOrder(),
    Wallet(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _screens[_selectedIndex],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            backgroundColor: Color(0xffF5F6F7),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Color(0xff484C52),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? Image.asset(
                        "assets/icons/homeicon.png",
                      )
                    : Image.asset("assets/icons/home.png"),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? Image.asset(
                        "assets/icons/Group 42303.png",
                      )
                    : Image.asset("assets/icons/mylisticon.png"),
                label: 'My List',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? Image.asset(
                        "assets/icons/Group (3).png",
                        color: Colors.blue,
                      )
                    : Image.asset(
                        "assets/icons/waleet.png",
                      ),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 3
                    ? Image.asset(
                        "assets/icons/Group 42304.png",
                        color: Colors.blue,
                      )
                    : Image.asset("assets/icons/accounticon.png"),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
