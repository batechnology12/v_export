import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class CorporatEditProfileApiServices extends BaseApiServices {
  Future getcorporateProfileApi() async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");
      print("------------------------------token-------------");
      print(authtoken);
      var response = await dio.get(
        getProfileUrl,
        options: Options(
            headers: {'Authorization': 'Bearer $authtoken'},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );

      print(response.data);
      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
