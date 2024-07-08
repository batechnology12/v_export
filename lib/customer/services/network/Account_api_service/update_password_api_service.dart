import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class UpdatePasswordApiService extends BaseApiServices {
  Future updatePassword(
      String oldPassword, String newPassword, String newConfirmPassword) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authtoken = prefs.getString('auth_token');
      var response = await dio.post(updatePasswordUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $authtoken',
              'Content-Type': 'application/json'
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            },
          ),
          data: {
            "current_password": oldPassword,
            "new_password": newPassword,
            "new_password_confirmation": newConfirmPassword
          });
      responseJson = response;
    } on SocketException {
      print("No internet");
    }
    return responseJson;
  }
}
