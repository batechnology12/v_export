import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/account.dart';
import 'package:v_export/customer/views/bottom_navi_bar/home_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/my_list.dart';
import 'package:v_export/customer/views/bottom_navi_bar/wallet/wallet.dart';

class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({
    super.key,
  });

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
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

  Future<bool> _onWillPop() async {
    return await showDialog(
          barrierColor: Colors.black.withOpacity(.80),
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xffffffff),
            title: const Text(
              'Exit App',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you sure you want to exit?',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            actions: [
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                child: TextButton(
                  onPressed: () => exit(0),
                  //     Navigator.of(context).pop(true),
                  child: Text(
                    'Exit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Cancel',
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: _screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          backgroundColor: Color(0xffffffff),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Color(0xff484C52),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/Vector (1).png",
                color: _selectedIndex == 0 ? Colors.blue : Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/li_clock.png",
                color: _selectedIndex == 1 ? Colors.blue : Colors.black,
              ),
              label: 'My List',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/Group (2).png",
                color: _selectedIndex == 2 ? Colors.blue : Colors.black,
              ),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/li_user.png",
                color: _selectedIndex == 3 ? Colors.blue : Colors.black,
              ),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
