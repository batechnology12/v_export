import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/model/get_profile_model.dart';
import 'package:v_export/customer/services/network/Account_api_service.dart/edit_profile_api_service.dart';

class AccountController extends GetxController {
  ProfileApiServices profileApiServices = ProfileApiServices();
  UserData? getUserData;
  RxBool imageLoading = false.obs;
  getProfile() async {
    imageLoading(true);
    update();
    dio.Response<dynamic> response = await profileApiServices.getProfile();
    imageLoading(false);

    update();
    print("------profile token--------------------------");
    print(response.data);
    if (response.data["status"] == true) {
      GetUserModel getUserModel = GetUserModel.fromJson(response.data);
      getUserData = getUserModel.data.user;
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
      update();
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }
}
