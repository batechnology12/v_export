import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class Teamandcondition extends BaseApiServices {
  Future<dynamic> teamscondition() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? authToken = prefs.getString("auth_token");
    dynamic responcedata;

    try {
      var dio = Dio();
      var response = await dio.get(
        getTermsAndConditionsUrl,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      responcedata = response;
      return responcedata;
    } catch (e) {
      Get.snackbar('', 'Error, please try again');
    }
  }
}