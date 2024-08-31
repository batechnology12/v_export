import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class PrivacyPolicy extends BaseApiServices {
  Future<dynamic> privacyPolicy() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? authToken = prefs.getString("auth_token");
    dynamic responseData;

    try {
      var dio = Dio();
      var response = await dio.get(
        getPrivacyPolicyUrl,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      responseData = response;
      return responseData;
    } catch (e) {
      Get.snackbar('', 'Error, please try again');
    }
  }
}