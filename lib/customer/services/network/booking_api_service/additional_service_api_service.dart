import 'dart:io';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';

class GetAdditionalApiServices extends BaseApiServices {
  Future getAdditionalServices() async {
    dynamic responseJson;
    try {
      var dio = Dio();
      // final prefs = await SharedPreferences.getInstance();
      // String? authtoken = prefs.getString("auth_token");

      //  print(authtoken);
      var response = await dio.get(
        getAdditionlServicesUrl,
        options: Options(
            //   headers: {'Authorization': 'Bearer $authtoken'},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      print("----------additional Servies-------");
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
