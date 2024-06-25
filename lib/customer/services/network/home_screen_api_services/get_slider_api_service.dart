import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class GetSliderApiServices extends BaseApiServices {
  Future getSlider() async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");

      var response = await dio.get(
        getSliderList,
        options: Options(
            headers: {'Authorization': 'Bearer $authtoken'},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );

      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
