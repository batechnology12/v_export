import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class CheckEmailExistsApiService extends BaseApiServices {
  Future checkEmailApi({
    required String email,
  }) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");

      var response = await dio.post(checkemailUrl,
          options: Options(
              headers: {
                'Authorization': 'Bearer $authtoken',
                'Content-Type': 'application/json'
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            "email": email,
          });

      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
