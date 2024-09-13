import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class CheckCorporateMobileExistApiService extends BaseApiServices {
  Future checkCorporateMobileApi({
    required String mobile,
  }) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");

      var response = await dio.post(checkemobileUrl,
          options: Options(
              headers: {
                'Authorization': 'Bearer $authtoken',
                'Content-Type': 'application/json'
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {"mobile": mobile});

      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
