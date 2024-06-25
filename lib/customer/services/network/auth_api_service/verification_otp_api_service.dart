import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class VerificationOtpApiService extends BaseApiServices {
  Future verificationOtp(String phone, String otp) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authtoken = prefs.getString('auth_token');
      var response = await dio.post(verificationOtpUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authtoken'
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            },
          ),
          data: {"phone": phone, "otp": otp});
      responseJson = response;
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
