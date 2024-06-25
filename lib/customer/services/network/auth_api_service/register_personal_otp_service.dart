import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class RegisterPersonalOtpApiService extends BaseApiServices {
  Future registerOtpUser(String phone, String otp) async {
    dynamic responseJson;
    try {
      var dio = Dio();

      var response = await dio.post(registerPersonalOtpUrl,
          options: Options(
            headers: {'Content-Type': 'application/json',
       
              
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
