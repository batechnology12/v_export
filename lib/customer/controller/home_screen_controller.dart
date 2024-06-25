import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/model/get_slider_model.dart';
import 'package:v_export/customer/services/network/Account_api_service.dart/update_password_api_service.dart';
import 'package:v_export/customer/services/network/home_screen_api_services/get_slider_api_service.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/settings.dart';

class HomeScreenController extends GetxController {
  GetSliderApiServices getSliderApiServices = GetSliderApiServices();
  List<SliderData> sliderData = [];
  getSlider() async {
    dio.Response<dynamic> response = await getSliderApiServices.getSlider();
    if (response.data["status"] == true) {
      GetSliderModel getSliderModel = GetSliderModel.fromJson(response.data);
      sliderData = getSliderModel.data;
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

  UpdatePasswordApiService updatePasswordApiService =
      UpdatePasswordApiService();

  updatePassword(
      String oldPassword, String newPassword, String newConfirmPassword) async {
    dio.Response<dynamic> response = await updatePasswordApiService
        .updatePassword(oldPassword, newPassword, newConfirmPassword);
    if (response.data["status"] == true) {
      Get.to(Settings());
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
