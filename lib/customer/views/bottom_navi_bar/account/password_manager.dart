import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';

class PasswordManager extends StatefulWidget {
  const PasswordManager({super.key});

  @override
  State<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {
  bool curentPassword = true;
  bool newPassword = true;
  bool confirmPassword = true;

  var curentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: AppColors.kblue,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Password Manager',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: formkey,
        child: Container(
          width: double.infinity,
          height: size.height,
          decoration: const BoxDecoration(
            color: AppColors.kblue,
            gradient: LinearGradient(
              colors: [
                AppColors.kblue,
                AppColors.kwhite,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                    //  color: Color.fromARGB(255, 235, 232, 232),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Ksizedboxw10,
                          Text(
                            'Current Password',
                            style: primaryfont.copyWith(
                                color: Color(0xff455A64),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              obscureText: curentPassword,
                              controller: curentPasswordController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 5,
                                    left: 10,
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: IconButton(
                                      icon: curentPassword
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          curentPassword = !curentPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'New Password',
                            style: primaryfont.copyWith(
                                color: Color(0xff455A64),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              obscureText: newPassword,
                              controller: newPasswordController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 5,
                                    left: 10,
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: IconButton(
                                      icon: newPassword
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          newPassword = !newPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            'Confirm Password',
                            style: primaryfont.copyWith(
                                color: Color(0xff455A64),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              obscureText: confirmPassword,
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 5,
                                    left: 10,
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: IconButton(
                                      icon: confirmPassword
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          confirmPassword = !confirmPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CommonContainer(
          name: "Password Manager",
        ),
      ),
    );
  }
}
