import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/model/get_slider_model.dart';
import 'package:v_export/customer/model/notification_model.dart';
import 'package:v_export/customer/services/network/Account_api_service/update_password_api_service.dart';
import 'package:v_export/customer/services/network/home_screen_api_services/get_slider_api_service.dart';
import 'package:v_export/customer/services/network/home_screen_api_services/notification_api_service.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/settings.dart';

class HomeScreenController extends GetxController {
  GetSliderApiServices getSliderApiServices = GetSliderApiServices();
  List<SliderData> sliderData = [];
  RxBool sliderLoading = false.obs;
  getSlider() async {
    sliderLoading(true);
    dio.Response<dynamic> response = await getSliderApiServices.getSlider();
    sliderLoading(false);
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
      Get.offAll(Settings());
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

  NotificationApiServices notificationApiServices = NotificationApiServices();
  List<NotificationData> notificationList = [];
  RxBool notificationLoading = false.obs;
  getNotification() async {
    notificationLoading(true);
    dio.Response<dynamic> response =
        await notificationApiServices.notificationApi();
    notificationLoading(false);
    if (response.data["status"] == true) {
      NotificationModel notificationModel =
          await NotificationModel.fromJson(response.data);
      notificationList = notificationModel.data;
      update();
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
      // update();
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
