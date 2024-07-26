import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class LoginApiServices extends BaseApiServices {
  Future loginApi({
    required String emailOrmobileNmuber,
    required String password,
  }) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      // final prefs = await SharedPreferences.getInstance();
      // String? authtoken = prefs.getString("auth_token");

      var response = await dio.post(loginUrl,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            "email_or_phone": emailOrmobileNmuber,
            "password": password,
          });
      print(
          "::::::::<Login Api>::::::${emailOrmobileNmuber}::password :${password}:::::::::");

      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
