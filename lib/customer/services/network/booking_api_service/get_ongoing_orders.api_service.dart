import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class GetOngongOrderApiServices extends BaseApiServices {
  Future getOngoingOderUser(String ongoingOrder) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");

      print(authtoken);
      var response = await dio.post(
        getOngoing_completed_cancelledUrl,
        options: Options(
            headers: {
                'Content-Type': 'application/json',
                'Authorization':
                    'Bearer $authtoken'
              },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
            data: {"type": ongoingOrder}
      );
      print("----------get ongoing orders-------");
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
